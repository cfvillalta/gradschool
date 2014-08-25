#! /usr/bin/perl -w

use strict;
use Data::Dumper;
use Statistics::Descriptive;

my $readcounts = $ARGV[0];

my $cond1="2489-alone";
my $cond2="2489-D115-A";

open(READCOUNTS, $readcounts);

my @reads_array;
my @counts_before;
my @counts_after;
my @counts;

while(my $counts =<READCOUNTS>)
{
    chomp($counts);
    if($counts !~ m/NCU_id/)
    {
	my @counts_array = split("\t",$counts);
	@counts =@counts_array;
	push(@reads_array,[@counts_array]);
    }
}

my %j_hits;
my @num_of_samples;
for(my $j=0;$j<@counts; $j++)
{
    if($counts[$j] !~ m/NCU/)
    {
	foreach my $gene(@reads_array)
	{
	    my @gene_array = @$gene;
	    
	    if($gene_array[$j] !~ m/cv/)
	    {
		push(@{$j_hits{$j}},$gene_array[$j]);
	    }
	}
	push(@num_of_samples,$j);
    }
}

my %totals;

foreach my $hits(keys %j_hits)
{
    my $jh = $j_hits{$hits};
    my $stat = Statistics::Descriptive::Full->new();
    $stat->add_data(@$jh);
    my $q3 = $stat->quantile(3);

    $totals{$hits} = $q3;
}

#print Dumper %totals;

open(BP1, ">$cond1\-$cond2\_med_diff_bioreps_med.dat");
open(BP2, ">$cond1\-$cond2\_med_diff_all_lanes_med.dat");
foreach my $row(@reads_array)
{
    my @row = @$row;
############################################################
#I am just printing out the median differences. Where the meidan is just between bioreps.    
    my $stat_before = Statistics::Descriptive::Full->new();
    $stat_before->add_data(($row[1]/$totals{1}),($row[2]/$totals{2}),($row[3]/$totals{3}));
    my $median_before = $stat_before->median();
    
    my $stat_after = Statistics::Descriptive::Full->new();
    $stat_after->add_data(($row[4]/$totals{4}),($row[5]/$totals{5}),($row[6]/$totals{6}));

    my $median_after = $stat_after->median();

    my $b1 = log($row[1]/$totals{1})-log($median_before);
    my $b2 = log($row[2]/$totals{2})-log($median_before);
    my $b3 = log($row[3]/$totals{3})-log($median_before);
    
    my $a1 = log($row[4]/$totals{4})-log($median_after);
    my $a2 = log($row[5]/$totals{5})-log($median_after);
    my $a3 = log($row[6]/$totals{6})-log($median_after);

    print BP1 "$row[0]\t$b1\t$b2\t$b3\t$a1\t$a2\t$a3\n";

  
###########################################################    
#I am going to print out the median differences where the median is from all the lanes of data. The biorep normalized read count is subtracted from that.

 #   my $b_2 = ($row[2]/$totals{2});
 #   print "$b2\t$b_2\t$median_before\n";
    my $stat_all = Statistics::Descriptive::Full->new();
    $stat_all->add_data(($row[1]/$totals{1}),($row[2]/$totals{2}),($row[3]/$totals{3}),($row[4]/$totals{4}),($row[5]/$totals{5}),($row[6]/$totals{6}));
    my $median_all = $stat_all->median();
    my $b1_2 = log($row[1]/$totals{1})-log($median_after);
    my $b2_2 = log($row[2]/$totals{2})-log($median_after);
    my $b3_2 = log($row[3]/$totals{3})-log($median_after);
    
    my $a1_2 = log($row[4]/$totals{4})-log($median_before);
    my $a2_2 = log($row[5]/$totals{5})-log($median_before);
    my $a3_2 = log($row[6]/$totals{6})-log($median_before);

    print BP2 "$row[0]\t$b1_2\t$b2_2\t$b3_2\t$a1_2\t$a2_2\t$a3_2\n";  
##########################################################

}

close(BP1);
close(BP2);

system("cp $cond1\-$cond2\_med_diff_bioreps_med.dat meddiff.dat");
system("cp $cond1\-$cond2\_med_diff_bioreps_med.dat bioreps_med.dat");
system("R --no-save \<med_diff_boxplot_stats.R\> temp");
system("mv md.out $cond1\-$cond2\_med_diff_bioreps_med_stats.dat"); 

system("cp $cond1\-$cond2\_med_diff_all_lanes_med.dat meddiff.dat");
system("cp $cond1\-$cond2\_med_diff_all_lanes_med.dat all_lanes_med.dat");
system("R --no-save \<med_diff_boxplot_stats.R\> temp");
system("mv md.out $cond1\-$cond2\_med_diff_all_lanes_med_stats.dat");

system("R --no-save \<med_diff_boxplot.R\> temp");

system("mv md_br_all_1.pdf $cond1\-$cond2\_md_br_all_cond1.pdf");
system("mv md_br_all_2.pdf $cond1\-$cond2\_md_br_all_cond2.pdf");

