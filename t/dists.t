#!/usr/bin/perl -w

######################### We start with some black magic to print on failure.
use lib '../blib/lib','../blib/arch';
use strict;
use vars qw($loaded);

BEGIN {$| = 1; print "1..23\n";}
END {print "not ok 1\n" unless $loaded;}
use Math::Cephes qw(:dists :betas :gammas :constants :misc);
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
my $k = 3;
my $n = 5;
my $p = 0.7;
my $y = 0.6;
test(2, bdtr($k, $n, $p), incbet($n-$k, $k+1, 1-$p));
test(3, bdtrc($k, $n, $p), incbet($k+1, $n-$k, $p));
test(4, bdtri($k, $n, $y), 1-incbi($n-$k, $k+1, $y));
test(5, btdtr($k, $n, $y), incbet($k, $n, $y));
test(6, chdtr($k, $y), igam($k/2, $y/2));
test(7, chdtrc($k, $y), igamc($k/2, $y/2));
test(8, chdtri($k, $y), 2*igami($k/2, $y));
test(9, fdtr($k, $n, $y), incbet($k/2, $n/2,$k*$y/($n + $k*$y)));
test(10, fdtrc($k, $n, $y), incbet($n/2, $k/2, $n/($n + $k*$y)));
my $z = incbi( $n/2, $k/2, $p);
test(11, fdtri($k, $n, $p), $n*(1-$z)/($k*$z));
test(12, gdtr($k, $n, $y), igam($n, $k*$y));
test(13, gdtrc($k, $n, $y), igamc($n, $k*$y));
my $w = nbdtr($k, $n, $p); 
test(14, $w, incbet($n, $k+1, $p));
test(15, nbdtrc($k, $n, $p), incbet($k+1, $n, 1-$p));
test(16, nbdtri($k, $n, $w), $p);
$w = ndtr($y);
test(17, $w, (1+erf($y/sqrt(2)))/2);
test(18, ndtri($w), $y);
test(19, pdtr($k, $n), igamc($k+1, $n));
test(20, pdtrc($k, $n), igam($k+1, $n));
test(21, pdtri($k, $y), igami($k+1, $y));
$w = stdtr( $k, $y);
$z = $k/($k + $y*$y);
test(22, $w, 1- 0.5*incbet($k/2, 1/2, $z));
test(23, stdtri($k, $w), $y);
