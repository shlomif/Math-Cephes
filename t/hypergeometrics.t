#!/usr/bin/perl -w

######################### We start with some black magic to print on failure.
use lib '../blib/lib','../blib/arch';
use strict;
use vars qw($loaded);

BEGIN {$| = 1; print "1..3\n"; }
END {print "not ok 1\n" unless $loaded;}
use Math::Cephes qw(:hypergeometrics);
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
my $x = 0.1;
my $y = 0.2;
my $z = 0.3;
my $u = 0.4;
test(2, hyp2f1($x, $y, $z, $u), 1.03417940155);
test(3, hyperg($x, $y, $z), 1.17274559901);


