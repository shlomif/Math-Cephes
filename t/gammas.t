#!/usr/bin/perl -w

######################### We start with some black magic to print on failure.
use lib '../blib/lib','../blib/arch';
use strict;
use vars qw($loaded);

BEGIN {$| = 1; print "1..9\n"; }
END {print "not ok 1\n" unless $loaded;}
use Math::Cephes qw(:gammas :constants :utils);
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
my $x = 0.5;
my $euler = 0.57721566490153286061;
my $e = exp(1);
test(2, gamma($x), sqrt($PI));
test(3, gamma(10), fac(9));
test(4, fac(9), 362880);
test(5, rgamma($x), 1/sqrt($PI));
test(6, psi(1/2), -$euler - 2*$LOGE2);
test(7, igam(4,4), 1-71/3*pow($e,-4));
my $p = igamc(4,4);
test(8, $p, 71/3*pow($e, -4));
test(9, igami(4,$p), 4);
