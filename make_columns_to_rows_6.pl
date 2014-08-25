#! /usr/bin/perl -w

use Data::Dumper;
use strict;

#will input a file with the first column NCU ids and the next four columns trends coded by amino acids.There are no column names so the first row will be input by me with column names.

my $input_col = $ARGV[0];

open(COL, $input_col);
my @c1;
my @c2;
my @c3;
my @c4;
my @c5;
my @c6;
while(my $col = <COL>)
{
    chomp($col);
    my @col_s=split("\t", $col);
    push(@c1, $col_s[1]);
    push(@c2, $col_s[2]);
    push(@c3, $col_s[3]);
    push(@c4, $col_s[4]);
    push(@c5, $col_s[5]);
    push(@c6, $col_s[6]);
}

print ">NcA1\n";
print join("",@c1),"\n";
print ">NcA2\n";
print join("",@c2),"\n";
print ">Nd\n";
print join("",@c3),"\n";
print ">NcC\n";
print join("",@c4),"\n";
print ">PcWy\n";
print join("",@c5),"\n";
print ">PcWo\n";
print join("",@c6),"\n";
