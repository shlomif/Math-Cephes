#!/usr/bin/perl -w
use strict;
######################### We start with some black magic to print on failure.
use lib '../blib/lib','../blib/arch';
use vars qw($loaded);
BEGIN {$| = 1; print "1..50\n"; }
END {print "not ok 1\n" unless $loaded;}
use Math::Cephes qw(:hypers :trigs :constants);
#use Math::Cephes::Complex qw(:cmplx);
use Math::Cephes::Complex;
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
my $y = Math::Cephes::Complex->new(1,3);
my $x = new Math::Cephes::Complex(5,6);
my $z = $x->cadd($y);
test(2, $z->{r}, 6);
test(3, $z->{i}, 9);
$z = $x->csub($y);
test(4, $z->{r}, 4);
test(5, $z->{i}, 3);
$z = $x->cmul($y);
test(6, $z->{r}, -13);
test(7, $z->{i}, 21);
$z = $x->cdiv( $y);
test(8, $z->{r}, 2.3);
test(9, $z->{i}, -0.9);
$z = $z->cneg;
test(10, $z->{r}, -2.3);
test(11, $z->{i}, 0.9);
$z = $x->cmov;
test(12, $z->{r}, 5);
test(13, $z->{i}, 6);
test(14, $z->cabs, sqrt(61));
$z = $x->clog;
test(15, $z->{r}, log(hypot(5,6)));
test(16, $z->{i}, atan2(6,5));
$z = $x->cexp;
test(17, $z->{r}, exp(5)*cos(6));
test(18, $z->{i}, exp(5)*sin(6));
$z = $x->csin;
my $d = new Math::Cephes::Complex(sin(5)*cosh(6), cos(5)*sinh(6));
test(19, $z->{r}, $d->{r});
test(20, $z->{i}, $d->{i});
$z = $d->casin;
test(21, $z->{r}, 5-2*$PI);
test(22, $z->{i}, 6);
$d = new Math::Cephes::Complex(cos(5)*cosh(6), -sin(5)*sinh(6));
$z = $x->ccos;
test(23, $z->{r}, $d->{r});
test(24, $z->{i}, $d->{i});
$z = $d->cacos;
test(25, $z->{r}, 5-2*$PI);
test(26, $z->{i}, 6);
my $den = cos(10) + cosh(12);
$d = new Math::Cephes::Complex(sin(10)/$den, sinh(12)/$den);
$z = $x->ctan;
test(27, $z->{r}, $d->{r});
test(28, $z->{i}, $d->{i});
$z = $d->catan;
test(29, $z->{r}, 5-2*$PI);
test(30, $z->{i}, 6);
$z = $x->ccot;
$den = cosh(12) - cos(10);
test(31, $z->{r}, sin(10)/$den);
test(32, $z->{i}, -sinh(12)/$den);
$z = $x->csqrt;
test(33, $z->{r}, 3/$z->{i});
test(34, $z->{i}, sqrt( ( sqrt(61) - 5 ) / 2 ) );
$d = new Math::Cephes::Complex(2,3);
$z = $d->csinh;
test(35, $z->{r}, sinh(2)*cos(3));
test(36, $z->{i}, cosh(2)*sin(3));
$y = $z->casinh;
test(37, $y->{r}, 2);
test(38, $y->{i}, 3);
$z = $d->ccosh;
test(39, $z->{r}, cosh(2)*cos(3));
test(40, $z->{i}, sinh(2)*sin(3));
$y = $z->cacosh;
test(41, $y->{r}, 2);
test(42, $y->{i}, 3);
$den = cosh(4) + cos(6);
$z = $d->ctanh;
test(43, $z->{r}, sinh(4)/$den);
test(44, $z->{i}, sin(6)/$den);
$y = $z->catanh;
test(45, $y->{r}, 2);
test(46, $y->{i}, 3-$PI);
$d = new Math::Cephes::Complex(4,5);
$z = $d->cpow( $y);
my $c = $d->clog;
my $f = $y->cmul( $c);
my $g = $f->cexp;
test(47, $z->{r}, $g->{r});
test(48, $z->{i}, $g->{i});
$x->{r} = 55;
$x->{i} = 66;
test(49, $x->{r}, 55);
test(50, $x->{i}, 66);
