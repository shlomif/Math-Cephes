#!/usr/bin/perl -w

######################### We start with some black magic to print on failure.
use lib '../blib/lib','../blib/arch';
use strict;
use vars qw($loaded);

BEGIN {$| = 1; print "1..5\n"; }
END {print "not ok 1\n" unless $loaded;}
use Math::Cephes qw(:betas :constants :gammas);
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
my $x = 5.57;
my $y = 2.2;
my $u = 0.3;
my $z = beta($x, $y);
test(2, $z, gamma($x)*gamma($y)/gamma(7.77));
test(3, lbeta($x, $y), log($z));
$z = incbet($x, $y, $u);
test(4, $z, 0.00761009624);
test(5, incbi($x, $y, $z), $u); 
