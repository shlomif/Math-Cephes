#!/usr/bin/perl -w

######################### We start with some black magic to print on failure.
use lib '../blib/lib','../blib/arch';
use strict;
use vars qw($loaded);

BEGIN {$| = 1; print "1..24\n";}
END {print "not ok 1\n" unless $loaded;}
use Math::Cephes qw(:misc);
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
my $x = 2.2;
my $n = 3;
test(2, zetac($x), .490543257);
test(3, zeta($x, $n), .2729056157);
test(4, dawsn($x), .2645107600);
my ($flagf, $S, $C) = fresnl($x);
test(5, $flagf, 0);
test(6, $S, .4557046121);
test(7, $C, .6362860449);
my ($flagt, $Si, $Ci) = sici($x);
test(8, $flagt, 0);
test(9, $Si, 1.687624827);
test(10, $Ci, .3750745990);
my ($flagh, $Shi, $Chi) = shichi($x);
test(11, $flagh, 0);
test(12, $Shi, 2.884902918);
test(13, $Chi, 2.847711781);
test(14, expn($n, $x), .02352065665);
test(15, ei($x), 5.732614700);
test(16, spence($x), -.9574053086);
my ($flaga, $ai, $aiprime, $bi, $biprime) = airy($x);
test(17, $flaga, 0);
test(18, $ai, .02561040442);
test(19, $aiprime, -.04049726324);
test(20, $bi, 4.267036582);
test(21, $biprime, 5.681541770);
test(22, erf($x), .9981371537);
test(23, erfc($x), .001862846298);
test(24, struve($n, $x), .1186957024)
