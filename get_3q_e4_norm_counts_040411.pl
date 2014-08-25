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
    if($rc =~ m/NCU_id\t(CV.+)/)
    {
	@sample_id = split("\t",$1);
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

my @q3_array;
foreach my $run(@samples)
{
    my @run = @$run;
    my $stat = Statistics::Descriptive::Full->new();
    $stat->add_data(@run);
    my $q3 = $stat->quantile(3);
    push(@q3_array, $q3);
}

$sample_num=0;
#my @total;

#foreach my $sample(@sample_id)
#{
   # $sample_num++;
    #my $total_hits = 0;
# print $sample_num,"\n";

   # foreach my $gene(@reads_array)
    #{
        #my @gene = @$gene;

	#if($gene[$sample_num] > $q3_array[$sample_num-1])
	#{
            
   #         $total_hits+=$gene[$sample_num];
  #      }
 #   }

#push(@total,$total_hits);
#}

my @reads_stdev_input;

#open(THRNORM2,">readcount_$name\_nozero_3q_e4.dat");


#print THRNORM2 $header,"\n";
print $header,"\n";

foreach my $row_1(@reads_array)
{
    

    my @row_1 = @$row_1;
    
    
#    print THRNORM2 $row_1[0],"\t";
    print $row_1[0],"\t";
    my @norm_row;
    push(@norm_row,$row_1[0]);
    my $sample_num_1=0;
    my @line;
    foreach my $sample_1(@sample_id)
    {
	$sample_num_1++;
	
	my $thirdq_norm_sample = ($row_1[$sample_num_1]/$q3_array[$sample_num_1-1]);
	push(@norm_row,$thirdq_norm_sample);
	my $thirdq_norm_sample_2 = int(($row_1[$sample_num_1]/$q3_array[$sample_num_1-1])*1000);
	
	
#	print THRNORM2 $thirdq_norm_sample_2,"\t";
	push(@line,$thirdq_norm_sample_2);
    }
   # print THRNORM2 "\n";
    print join("\t",@line),"\n";
    push(@reads_stdev_input,[@norm_row]);
}


#close(THRNORM2);
#print Dumper @reads_stdev_input;
