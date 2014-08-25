#! /usr/bin/perl -w

use strict;

use Data::Dumper;

use Statistics::Descriptive;

my $name = "2489-2489_BA";

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
    if($rc =~ m/\#NCU_id\t(CV.+)/)
    {
	$header=$rc;
        @sample_id = split("\t",$1);
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
my @total;

foreach my $sample(@sample_id)
{
    $sample_num++;
    my $total_hits = 0;
# print $sample_num,"\n";

    foreach my $gene(@reads_array)
    {
        my @gene = @$gene;

	if($gene[$sample_num] > $q3_array[$sample_num-1])
	{
            
            $total_hits+=$gene[$sample_num];
        }
    }

push(@total,$total_hits);
}
#print Dumper @total;

my $count;

open(TOTAL, ">$name\_3q_total_counts.dat");
print TOTAL join("\t",@total),"\n";
close(TOTAL);
system("cp $name\_3q_total_counts.dat lib_size.dat");

###################################################
#Make a readcount file with NCUs that have more than 5 reads per gene.
open(COUNTS, ">readcount_$name\_5.dat");
foreach my $row(@reads_array)
{
    my @row = @$row;
    my $counter=0;
    foreach my $count(@row)
    {

	if($count !~ m/NCU/)
	{
	
	    $counter+=$count;
    
	}
    }
    if($counter > 0)
    {
	print COUNTS join("\t", @row),"\n";
    }
}
close(COUNTS);
system("cp readcount_$name\_5.dat readcount.dat");
##############################################	    

#make a file with 3rd quartile normalized counts in it but they will not be proportioned to 10 million counts. 
#make a file with 3rd quartile normalized counts in it that will be proportioned to 10 million counts.
my @reads_stdev_input;
open(THRNORM,">readcount_$name\_5_3q.dat");
open(THRNORM2,">readcount_$name\_5_3q_e7.dat");

print THRNORM $header,"\n";
print THRNORM2 $header,"\n";

foreach my $row_1(@reads_array)
{
    

    my @row_1 = @$row_1;
    my $counter_1=0;
    foreach my $count_1(@row_1)
    {

	if($count_1 !~ m/NCU/)
	{
	
	    $counter_1+=$count_1;
    
	}
    }


    if($counter_1 > 0 && $row_1)
    {
	print THRNORM $row_1[0],"\t";
	print THRNORM2 $row_1[0],"\t";
	my @norm_row;
	push(@norm_row,$row_1[0]);
	my $sample_num_1=0;
	foreach my $sample_1(@sample_id)
	{
	    $sample_num_1++;
	    
	    my $thirdq_norm_sample = ($row_1[$sample_num_1]/$total[$sample_num_1-1]);
	    push(@norm_row,$thirdq_norm_sample);
	    my $thirdq_norm_sample_2 = int(($row_1[$sample_num_1]/$total[$sample_num_1-1])*10000000);
	    
	    print THRNORM $thirdq_norm_sample,"\t";
	    print THRNORM2 $thirdq_norm_sample_2,"\t";
	}
	print THRNORM "\n";
	print THRNORM2 "\n";
	push(@reads_stdev_input,[@norm_row]);
    }
    
}
close(THRNORM);
#print Dumper @reads_stdev_input;
###########################################

#edgeR on 3rd quartile normalized counts

system("R --no-save < edgeR_tagwise_3v3.R > temp");
system("mv edgeR.dat $name\_5_3q_edgeR_tagwise.dat");
system("mv edgeR_sig0.05.dat $name\_5_3q_edgeR_tagwise_sig0.05.dat");
system("mv out.pdf $name\_5_3q_edgeR_tagwise.pdf");

############################################

#gets genes with a sig stdev, and run the unnormalized counts with the total 3rd quartile counts of those genes in edgeR. Give a pdf, dat with data, and dat with sig data.
open(RC_STDMEAN, ">readcount_$name\_5_STDMEANsig.dat");
print RC_STDMEAN $header,"\n";
foreach my $gene_x(@reads_stdev_input)
{
    my @gene_x = @$gene_x;
    #print join("\t",@gene_x),"\n";
    my @gene_1 = @gene_x[1,2,3];
    my $stat1 = Statistics::Descriptive::Full->new();
    $stat1->add_data(@gene_1);
    my $stdev1 = $stat1->standard_deviation();
    my $sum1 = $stat1->sum();
    
    my @gene_2 = @gene_x[4,5,6];
    my $stat2 = Statistics::Descriptive::Full->new();
    $stat2->add_data(@gene_2);
    my $stdev2 = $stat2->standard_deviation();
    my $sum2 = $stat2->sum();
    

    my@all_gene = @gene_x[1,2,3,4,5,6];
    my $all_stat = Statistics::Descriptive::Full->new();
    $all_stat->add_data(@all_gene);
    my $all_stdev = $all_stat->standard_deviation();
    
    my $co = 0.05;
     
    my $genex = join("\t",@gene_x);
    if($sum1 != 0 && $stdev1/$sum1 < $co)
    {
	if($sum2 != 0 && $stdev2/$sum2 < $co)
	{
	    print RC_STDMEAN $counts_hash{$gene_x[0]},"\n";
	}	
    }
	
    elsif($sum1 == 0)
    {	
	if($sum2 != 0 && $stdev2/$sum2 < $co)
	{
	    print RC_STDMEAN $counts_hash{$gene_x[0]},"\n";
	}   
    }
    
    elsif($sum2 == 0)
    {
	if($sum1 != 0 && $stdev1/$sum1 < $co)
	{
	    print RC_STDMEAN $counts_hash{$gene_x[0]},"\n";
	}  
    } 
}
close(RC_STDMEAN);
system("cp readcount_$name\_5_STDMEANsig.dat readcount.dat");
system("R --no-save < edgeR_tagwise_3v3.R > temp");
system("mv edgeR.dat $name\_5_3q_STDMEANsig_edgeR_tagwise.dat");
system("mv edgeR_sig0.05.dat $name\_5_3q_STDMEANsig_edgeR_tagwise_sig0.05.dat");
system("mv out.pdf $name\_5_3q_STDMEANsig.pdf");
system("cp $name\_5_3q_STDMEANsig_edgeR_tagwise_sig0.05.dat 5_3q_STDMEANsig_edgeR_tagwise_sig0.05.dat");
system("awk '\$3 \< 0' 5_3q_STDMEANsig_edgeR_tagwise_sig0.05.dat > $name\_5_3q_STDMEANsig_edgeR_tagwise_sig0.05_down.dat");
system("awk '\$3 \> 0' 5_3q_STDMEANsig_edgeR_tagwise_sig0.05.dat > $name\_5_3q_STDMEANsig_edgeR_tagwise_sig0.05_up.dat");
system("awk '\$3 \< 0{print \$1}' 5_3q_STDMEANsig_edgeR_tagwise_sig0.05.dat > $name\_5_3q_STDMEANsig_edgeR_tagwise_sig0.05_down.ncu");
system("awk '\$3 \> 0{print \$1}' 5_3q_STDMEANsig_edgeR_tagwise_sig0.05.dat > $name\_5_3q_STDMEANsig_edgeR_tagwise_sig0.05_up.ncu");
system("perl get_counts_with_NCU.pl readcount_$name\_5_3q_e7.dat $name\_5_3q_STDMEANsig_edgeR_tagwise_sig0.05_down.ncu > $name\_5_3q_e7_STDMEANsig_edgeR_tagwise_sig0.05_down.counts");
system("perl get_counts_with_NCU.pl readcount_$name\_5_3q_e7.dat $name\_5_3q_STDMEANsig_edgeR_tagwise_sig0.05_up.ncu > $name\_5_3q_e7_STDMEANsig_edgeR_tagwise_sig0.05_up.counts");
###############################################

