#!/usr/bin/perl -w

######################### We start with some black magic to print on failure.
use lib '../blib/lib','../blib/arch';
use strict;
use vars qw($loaded);

BEGIN {$| = 1; print "1..20\n"; }
END {print "not ok 1\n" unless $loaded;}
use Math::Cephes qw(:utils :constants);
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
my $y = -5.43;
test(2, ceil($x), 6);
test(3, floor($x), 5);
test(4, round($x), 6);
test(5, ceil($y), -5);
test(6, floor($y), -6);
test(7, round($y), -5);
test(8, sqrt(2), $SQRT2);
test(9, sqrt(2/$PI), $SQ2OPI);
test(10, cbrt(729), 9);
test(11, cbrt(704.969), 8.9);
test(12, fabs($y), 5.43);
test(13, pow(2,10), 1024);
test(14, powi(2,10), 1024);
test(15, pow(5,1/3), cbrt(5));
test(16, fac(10), 3628800);
my ($z, $expnt) = frexp(6);
test(17, $z, .75);
test(18, $expnt, 3);
test(19, ldexp(.75, 3), 6);
test(20, lsqrt(2147483647), 46341);


