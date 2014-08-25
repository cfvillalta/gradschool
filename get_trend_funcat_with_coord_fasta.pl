#! /usr/bin/perl -w 

use Data::Dumper;
use strict;

#will input the trends fasta file. 
#also input a start position and end position to get all NCUs from the start to the end.
my $input_trends = $ARGV[0];
my $input_start = $ARGV[1];
my $input_end = $ARGV[2];

open(T, $input_trends);
my @id;
while(my $t = <T>)
{
    chomp($t);
    if($t =~ m/(NCU\d+)/)
    {
	push(@id, $1);
    }

}
my $aln;
if($input_trends =~ m/.+\_cols\_(.+)\.dat/)
{
    $aln = $1;
}

my @get = (($input_start-1)..($input_end-1));
#print join("",@get);
open(OUT, ">funcat_in.ncu");
foreach my $n (@get)
{
    print OUT $id[$n],"\n";
}
close(OUT);

system("perl funcat\_enrichment\.pl all\_NCU\_2489\-D115\-D107\-8579\.ncu funcat\_in.ncu funcat\-2.1_scheme\|awk '\$2<0.05'>funcat\_$aln\_$input_start\_$input_end.out");
system("perl funcat\_enrichment\.pl all\_NCU\_2489\-D115\-D107\-8579\.ncu funcat\_in.ncu funcat\-2.1_scheme\|awk '\$2<0.05'");
