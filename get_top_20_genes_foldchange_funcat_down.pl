#! /usr/bin/perl -w 

use strict;

use Data::Dumper;

#want to input a DESeq sig file and a edgeR file and get the top 20 genes from each and then get the top 20 from that top 20. 

my $edgeR_in = $ARGV[0];

my $DESeq_in = $ARGV[1];

my $condition = $ARGV[2];

#my $edgeR_in = $ARGV[3];

#my $DESeq_in = $ARGV[4];

open(E, $edgeR_in);
open(D, $DESeq_in);

my %edgeR;
my %DESeq;

#my %edgeR_all;
#my %DESeq_all;
while(my $e = <E>)
{
    chomp($e);
    if($e =~ m/NCU/)
    {
	my @es = split("\t", $e);
	$edgeR{$es[0]}=$es[2];
    }
}

while(my $d = <D>)
{
    chomp($d);
    if($d =~ m/NCU/)
    {
	my @ds= split("\t",$d);
	$DESeq{$ds[1]}=$ds[6];
    }
}

my @edgeR_s= sort{int($edgeR{$a}) cmp int($edgeR{$b})}keys%edgeR;

my @DESeq_s= sort{int($DESeq{$a}) cmp int($DESeq{$b})}keys%DESeq;

my @ed_20;
my $n=0;
foreach my $x(@edgeR_s)
{
    if($n <20)
    {
	push(@ed_20, $x);
    }
    $n++;
}

$n=0;
foreach my $x(@DESeq_s)
{
    if($n <20)
    {
	push(@ed_20, $x);
    }
    $n++;
}
$n=0;
my %top_20;
foreach my $x (@ed_20)
{
    if(exists $top_20{$x})
    {
    }
    else
    {
	if(exists $edgeR{$x} && exists $DESeq{$x})
	{
	    $top_20{$x}="$edgeR{$x}\t$DESeq{$x}";
	}
	elsif(exists $DESeq{$x})
	{
	    if(exists $edgeR{$x})
	    {
	    }
	    else
	    {	
		if(exists $DESeq{$x})
		{
		    $top_20{$x}="NA\t$DESeq{$x}";
		}
	    }
	}
	elsif(exists $edgeR{$x})
	{ 
	    if(exists $DESeq{$x})
	    {
	    }
	    else
	    {	
		if(exists $edgeR{$x})
		{
		    $top_20{$x}="$edgeR{$x}\tNA";
		}
	    }
	}
    }
}

open(FUNCAT, ">funcat\_$condition\_down\.in");
open(UP, ">top_20_exp_$condition\_down\.dat");
#open(DOWN,">top_20_exp_$condition\_down\.dat
$n=0;
print "$condition\_down\n";
my @top_20_s= sort{$top_20{$b} cmp $top_20{$a}}keys%top_20;
foreach my $x(@top_20_s)
{
    if($n<20)
    {
	print FUNCAT "$x\n";
	print UP "$x\t$top_20{$x}\n";
#	print DOWN "$x\t$top_20_down{$x}n";
    }
    $n++;
}
close(FUNCAT);
system("perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu funcat\_$condition\_down\.in  funcat-2.1_scheme\|awk \'\$2\<0.05\'\>funcat\_$condition\_down.dat");
system("perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu funcat\_$condition\_down\.in  funcat-2.1_scheme\|awk \'\$2\<0.05\'");
