#! /usr/bin/perl

#compare the fold change with significant genes from edgeR, see which ones match.

use strict;

my $edgeR_results = $ARGV[0];
my $before_fold_change = $ARGV[1];
my $after_fold_change = $ARGV[2];

my %edgeR_hash;
my %before_hash;
my %after_hash;

open(EDGER, $edgeR_results);
open(BEFORE, $before_fold_change);
open(AFTER, $after_fold_change);

while(my $edgeR = <EDGER>)
{
    chomp($edgeR);
    my @edgeR_array = split("\t", $edgeR);
    my $edgeR_id = $edgeR_array[0];
    my $edgeR_adjpval = $edgeR_array[4];
    $edgeR_hash{$edgeR_id} = $edgeR;
}

while(my $before = <BEFORE>)
{
    if($before !~ m/\#/)
    {
	chomp($before);
	my @b_array = split("\t", $before);
	my $b_id = $b_array[0];
	my $b_c1 = $b_array[1];
	my $b_c2 = $b_array[2];
	my $b_e1 = $b_array[3];
	my $b_e2 = $b_array[4];
	my $b_change = $b_array[5];
	my $b_condition = $b_array[6];
	$before_hash{$b_id} = $before;
    }
}

while(my $after = <AFTER>)
{
    if($after !~ m/\#/)
    {
	chomp($after);
	my @a_array = split("\t", $after);
	my $a_id = $a_array[0];
	my $a_c1 = $a_array[1];
	my $a_c2 = $a_array[2];
	my $a_e1 = $a_array[3];
	my $a_e2 = $a_array[4];
	my $a_change = $a_array[5];
	my $a_condition = $a_array[6];
	$after_hash{$a_id} = $after;	
    }
}


print "NCU_ID\tA\tM\tP-value\tadjusted_P-value\tNCU_ID\tC1\tC2\tE1\tE2\n";

for my $key(keys %edgeR_hash)
{
    my $before_value = $before_hash{$key};
    my $after_value = $after_hash{$key};
    my $edgeR_value = $edgeR_hash{$key};

    if($before_value =~ m/^PCS.+/)
    {
	print $edgeR_value,"\t", $before_value,"\n";
    }
    elsif($after_value =~ m/^PCS.+/)
    {
	print $edgeR_value,"\t",$after_value,"\n";
    }
}
