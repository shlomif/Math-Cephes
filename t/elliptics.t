#!/usr/bin/perl -w

######################### We start with some black magic to print on failure.
use lib '../blib/lib','../blib/arch';
use strict;
use vars qw($loaded);

BEGIN {$| = 1; print "1..10\n";}
END {print "not ok 1\n" unless $loaded;}
use Math::Cephes qw(:elliptics :constants :utils :trigs);
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# util
sub test {
  local($^W) = 0;
  my($num, $value, $true) = @_;
  my $error = sprintf( "%12.8f", abs($value - $true));
  print($error < 0.000001 ? "ok $num\n" : "not ok $num (expected $true: got $value)\n");
}
my $x = 0.3;
test(2, ellpk(1-$x*$x), 1.608048620);
test(3, ellik(asin(0.2), $x*$x), .2014795901);
test(4, ellpe(1-$x*$x), 1.534833465);
test(5, ellie(asin(0.2), $x*$x), .2012363833);
my $phi = $PIO4;
my $m = 0.3;
my $u = ellik($phi, $m);
my ($flag, $sn, $cn, $dn, $phi_out) = ellpj($u, $m);
test(6, $flag, 0);
test(7, $phi, $phi_out);
test(8, $sn, sin($phi_out));
test(9, $cn, cos($phi_out));
test(10, $dn, sqrt(1-$m*sin($phi_out)*sin($phi_out)));
