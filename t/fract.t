#!/usr/bin/perl -w

######################### We start with some black magic to print on failure.
use lib '../blib/lib','../blib/arch';
use strict;
use vars qw($loaded);

BEGIN {$| = 1; print "1..22\n"; }
END {print "not ok 1\n" unless $loaded;}
use Math::Cephes::Fraction qw(:fract);
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# util
sub test {
    local($^W) = 0;
    my($num, $value, $true) = @_;
    print($value == $true ? "ok $num\n" : "not ok $num (expected $true: got $value)\n");
}
my $y = fract(5, 6);
my $x = fract(1, 3);
my $z = $x->radd( $y);
test(2, $z->{n}, 7);
test(3, $z->{d}, 6);
$z = $x->rsub($y);
test(4, $z->{n}, -1);
test(5, $z->{d}, 2);
$z = $x->rmul($y);
test(6, $z->{n}, 5);
test(7, $z->{d}, 18);
$z = $x->rdiv( $y);
test(8, $z->{n}, 2);
test(9, $z->{d}, 5);
my @a = mixed_fract($z);
test(10, $a[0], 0);
test(11, $a[1], 2);
test(12, $a[2], 5);
my $n1 = 60;
my $n2 = 144;
@a = euclid($n1, $n2);
test(13, $a[0], 12);
test(14, $a[1], 5);
test(15, $a[2], 12);
$z->{n} = 16;
$z->{d} = 3;
test(16, $z->{n}, 16);
test(17, $z->{d}, 3);
@a = mixed_fract($z);
test(18, $a[0], 5);
test(19, $a[1], 1);
test(20, $a[2], 3);
$x->{n} = 44;
$x->{d} = 55;
test(21, $x->{n}, 44);
test(22, $x->{d}, 55);

