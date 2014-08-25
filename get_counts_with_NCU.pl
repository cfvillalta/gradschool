#! /usr/bin/perl -w


use strict;
use Data::Dumper;

my $rc = $ARGV[0];

my $ncu = $ARGV[1];

open(RC, $rc);
open(NCU, $ncu);

my %counts_hash;
my $header;
while(my $counts = <RC>)
{
    chomp($counts);
    my @counts_split = split("\t",$counts);
    if ($counts !~ m/NCU_id.+/)
    {
        $counts_hash{$counts_split[0]}=$counts;
    }
    else
    {
	$header=$counts;
    }
    
}

my @id_array;
while(my $id = <NCU>)
{
    if($id =~ m/NCU/)
    {
	chomp($id);
	push(@id_array,$id);
    }
}

print $header,"\n";
foreach my $x(@id_array)
{    
 #   print "$x\t";
    print $counts_hash{$x},"\n";
} 
