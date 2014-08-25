#!/usr/bin/perl

use strict;

my $rbh = $ARGV[0];

open(RBH, $rbh);

while( my $hits1 = <RBH>)
{
    my @hits1_array = split("\t", $hits1);
    print $hits1_array[0], "\n";
}
