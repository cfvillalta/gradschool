#!/usr/bin/perl                                                                                                

use strict;
use Data::Dumper;


#Input a gff3 file and a wig file from tophat to determine average # of raw hits per mRNA transcipt.           
#Just numbers from exons/introns are excluded.                                                                 

#input gff                                                                                                     
my $gff = $ARGV[0];

#input wig output from tophat                                                                                  

my $wig = $ARGV[1];

open(GFF,$gff);
open(WIG, $wig);

#%exon will eventually have the id/contig/position of all the exons.                                           
my %exon;
my %solexa;

while(my $WIG = <WIG>)
{
#    print $WIG;                                                                                               
    if ($WIG =~ m/(Pchr_mcb247_v1_contig\d+)\s+(\d+)\s+(\d+)\s+(\d+)/ && $4 == 0)
    {
        chomp($WIG);

       print $WIG, "\n";                                                                                      
        my $contig = $1;
        my $start = $2;
        my $end = $3;
        my $hits = $4;

        my @contig_split = split("\t", $1);

#       print $1."test". "\n";                                                                                 

        $solexa{$WIG} = [$contig, $start, $end, $hits];

    }
}
