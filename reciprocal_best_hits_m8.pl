#! /usr/bin/perl 

use strict;

my $genA2genB = $ARGV[0];

my $genB2genA = $ARGV[1];


open(A2B, $genA2genB);
open(B2A, $genB2genA);

my %A2B;
my %B2A;

while ($A2B = <A2B>)
{
    chomp($A2B);
    my @A2B_split = split("\t", $A2B);
    
 
