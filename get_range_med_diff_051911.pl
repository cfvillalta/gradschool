#! /usr/bin/perl -w 

use strict;

use Data::Dumper;

#will input the statas file from boxplots and get the range betweent the upper and lower hinge aka the 1st and 3rd quartile.

my $input = $ARGV[0];

open(IN, $input);

my @stats;
my $x=0;
while(my $in = <IN>)
{
    chomp($in);
    $x++;
    if($in !~ m/\"x\"/)
    {
	my @in_s=split("\t",$in);
#    print Dumper @in_s;
	push(@stats, $in_s[1]);
    }
}
#print Dumper @stats;

#print join("\n",@stats);

my $before=$stats[4]-$stats[2];
my $after=$stats[10]-$stats[8];
print "$input\n";
print "$before\n$after\n";
