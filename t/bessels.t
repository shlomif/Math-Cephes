#!/usr/bin/perl -w

######################### We start with some black magic to print on failure.
use lib '../blib/lib','../blib/arch';
use strict;
use vars qw($loaded);

BEGIN {$| = 1; print "1..27\n";}
END {print "not ok 1\n" unless $loaded;}
use Math::Cephes qw(:bessels);
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
my $x = 2;
my $y = 20;
my $n = 5;
my $v = 3.3;
test(2, j0($x), .2238907791);
test(3, j0($y), .1670246643);
test(4, j1($x), .5767248078);
test(5, j1($y), .06683312418);
test(6, jn($n, $x), .007039629756);
test(7, jn($n, $y), .1511697680);
test(8, jv($v, $x), .08901510322);
test(9, jv($v, $y), -.02862625778);
test(10, y0($x), .5103756726);
test(11, y0($y), .06264059681);
test(12, y1($x), -.1070324315);
test(13, y1($y), -.1655116144 );
test(14, yn($n, $x), -9.935989128 );
test(15, yn($n, $y), -.1000357679);
test(16, yv($v, $x), -1.412002815 );
test(17, yv($v, $y), .1773183649);
test(18, i0($x), 2.279585302);
test(19, i0e($y), .08978031187);
test(20, i1($x), 1.590636855 );
test(21, i1e($y), .08750622217);
test(22, iv($v, $x), .1418012924);
test(23, k0($x), .1138938727);
test(24, k0e($y), .2785448766 );
test(25, k1($x), .1398658818);
test(26, k1e($y), .2854254970);
test(27, kn($n, $x), 9.431049101)
