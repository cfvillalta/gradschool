#! /usr/bin/perl -w


#On 4/04/11 I modified this script so it would not output a file but just print things to the screen. 
#also now it just normalized the readcount files to the 3rd quartile and not readcounts above the third quartile.
#The numbers output are readcounts divided by the third quartile and multiplied by 1000 to make things look nicer.

use strict;

use Data::Dumper;

use Statistics::Descriptive;

#my $name = "2489-D115_BA";

my $readcount = $ARGV[0];
open(RC,$readcount);
my @sample_id;
my @reads_array;
my %counts_hash;
my $header;
#####################################################
#make a file with the total counts of the third quartile. 
while(my $rc = <RC>)
{

    chomp($rc);
#change from NCU
    if($rc =~ m/NCU_id\t(CV.+)/)
    {
        @sample_id = split("\t",$1);
        #did this to get rid of # sign change NCU
        if($rc =~ m/(NCU_id.+)/)
        {
            $header=$1;
        }
        
    }
    else
    {
        my @counts_array = split("\t",$rc);
	
	$counts_hash{$counts_array[0]}=$rc;
	
	my $y=0;

        foreach my $x(@counts_array)
        {
        #change from NCU to whatever
	    if($x !~ m/NCU.+/)
            {
		$y+=$x;
            }
        }
	if($y != 0)
        {
            push(@reads_array,[@counts_array]);
        }
    }

}

#print Dumper @reads_array;
#print $header,"\n";
#print Dumper @sample_id;
    
my @samples;
my $sample_num = 0;
foreach my $sample(@sample_id)
{
    $sample_num++;
    my @sample_array;
    foreach my $gene(@reads_array)
    {
        my @gene= @$gene;

        push(@sample_array, $gene[$sample_num]);
        
    }
    push(@samples,[@sample_array]);
}

#print Dumper @samples;

$sample_num=0;
my @total;

foreach my $sample(@sample_id)
{
    $sample_num++;
    my $total_hits = 0;
    #  print $sample_num,"\n";
    
    foreach my $gene(@reads_array)
    {
        my @gene = @$gene;
	
	#if($gene[$sample_num] > $q3_array[$sample_num-1])
	#{
	
	$total_hits+=$gene[$sample_num];
        #}
    }

    push(@total,$total_hits);
}

print join("\t",@total);
