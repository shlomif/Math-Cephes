#!/usr/bin/perl -w

######################### We start with some black magic to print on failure.
use lib '../blib/lib','../blib/arch';
use strict;
use vars qw($loaded);

BEGIN {$| = 1; print "1..16\n"; }
END {print "not ok 1\n" unless $loaded;}
use Math::Cephes qw(:trigs :constants);
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
my $x = 7*$PI + $PIO4;
my $y = 945;
test(2, -sin($x), $SQRTH);
test(3, -cos($x), $SQRTH);
test(4, tan($x), 1);
test(5, cot($x), 1);
test(6, acos($SQRTH), $PIO4);
test(7, asin($SQRTH), $PIO4);
test(8, atan(1), $PIO4);
test(9, atan2(sqrt(3), 1), $PI/3);
test(10, -sindg($y), $SQRTH);
test(11, -cosdg($y), $SQRTH);
test(12, tandg($y), 1);
test(13, cotdg($y), 1);
test(14, radian(359, 59, 60), 2*$PI);
test(15, cosm1(0), 0);
test(16, hypot(5, 12), 13);
