#!/usr/bin/perl

#This is a script so I can make a graph in R where the Y axis is counts of hits from solexa reads and the x axis is the name of a gene. 
#Want to get porportions of hits per gene/total hits in each run that mapped to each gene. Total hits also that is a consensus of all the runs.

use strict;

my $read_counts = $ARGV[0];

open(READS, $read_counts);

while(my $reads = <READS>)
{
    next if $reads =~ m/^\#/;
    chomp($reads);
    print $reads;
}
