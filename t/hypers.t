#!/usr/bin/perl -w

######################### We start with some black magic to print on failure.
use lib '../blib/lib','../blib/arch';
use strict;
use vars qw($loaded);

BEGIN {$| = 1; print "1..7\n"; }
END {print "not ok 1\n" unless $loaded;}
use Math::Cephes qw(:hypers :explog);
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
my $x = 3;
my $y = (exp($x)+exp(-$x))/2;
test(2, cosh($x), $y);
test(3, acosh($y), $x);
$y = (exp($x)-exp(-$x))/2;
test(4, sinh($x), $y);
test(5, asinh($y), $x);
$y = 1 - 2/(exp(2*$x)+1);
test(6, tanh($x), $y);
test(7, atanh($y), $x);
