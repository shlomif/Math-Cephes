#!/usr/bin/perl -w

######################### We start with some black magic to print on failure.
use lib '../blib/lib','../blib/arch';
use strict;
use vars qw($loaded);

BEGIN {$| = 1; print "1..14\n"; }
END {print "not ok 1\n" unless $loaded;}
use Math::Cephes qw(:explog :utils :constants);
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
my $e = exp(1);
test(2, log(pow($e, $e)), $e);
test(3, log($e*$e), 2);
test(4, 1/log(2), $LOG2E);
test(5, exp(-1), 1/$e);
test(6, exp($LOGE2), 2);
test(7, log10(10000), 4);
test(8, log10(sqrt(10)), 0.5);
test(9, exp2(-1/2), $SQRTH);
test(10, exp2(8), 256);
test(11, log2($SQRT2), 0.5);
test(12, log2(256), 8);
test(13, log1p(0.5), log(1.5));
test(14, expm1(0.5), exp(0.5)-1);

