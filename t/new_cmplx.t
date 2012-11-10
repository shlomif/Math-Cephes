#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;
use Math::Cephes qw(:cmplx);
use Math::Cephes::Complex;

######################### End of black magic.

{
    my $z = new_cmplx(2,0);

    my $w = new_cmplx();

    cexp($z, $w);

    # TEST
    is ($w->{r}, exp(2), "Testing new_complx");
}
