#this script will make MA plots from the medians of all the before bioreps versus the after bioreps. 

#will input the read counts file and output a MAplot file and the M and A plot output numbers.

#! /usr/bin/perl -w

use strict;
use Data::Dumper;
use Statistics::Descriptive;

my $readcounts=$ARGV[0];

my $cond1="2489";
my $cond2="2489";

#readcounts to normalize against

open(READCOUNTS,$readcounts);

my @reads_array;
my @counts_before;
my @counts_after;
my @counts_norm;
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
#on 4/4/11 changed it so the counts were not the total number of reads above the 3q but just the 3q so disregard the word total I was just to lazy to change all the words.
foreach my $hits(keys %j_hits)
{
    my $jh = $j_hits{$hits};
    my $stat = Statistics::Descriptive::Full->new();
    $stat->add_data(@$jh);
    my $q3 = $stat->quantile(3);

    $totals{$hits} = $q3;

}
open(MA,">MA_R.input");
open(DAT, ">$cond1\-$cond2\-BA_reads.dat");
print DAT "NCUid\tM_y\tA_x\t$cond1\t$cond2\t$cond1\_norm\t$cond2\_norm\n";
foreach my $row(@reads_array)
{
    my @row = @$row;
    
    my $stat_before = Statistics::Descriptive::Full->new();
    $stat_before->add_data(($row[1]/$totals{1}),($row[2]/$totals{2}),($row[3]/$totals{3}));
    my $median_before = $stat_before->median();
    
    my $stat_after = Statistics::Descriptive::Full->new();
    $stat_after->add_data(($row[4]/$totals{4}),($row[5]/$totals{5}),($row[6]/$totals{6}));

    my $median_after = $stat_after->median();
    
#changed e7 to e4 because with the 3q didnt need to upscale it by e7 just e4 since it wasnt being divided by a bunch of reads. 
    my $M = (log($median_after)/log(2))-(log($median_before)/log(2));
    my $A = 0.5*((log($median_before)/log(2)) + (log($median_after)/log(2)));
    my $median_before_norm = int($median_before*1000);
    my $median_after_norm = int($median_after*1000);


    print MA "$row[0]\t$M\t$A\n";
    
    print DAT "$row[0]\t$M\t$A\t$median_before\t$median_after\t$median_before_norm\t$median_after_norm\n";
    
}
close(MA);
close(DAT);

system("R --no-save < make_MA_plot_111710.R> temp");
system("mv MA_R.out $cond1-$cond2\_BA_MA.pdf");
system("mv MA_R.input $cond1-$cond2\_MA.dat");

