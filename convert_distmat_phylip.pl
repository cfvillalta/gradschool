#! /usr/bin/perl -w

use strict;
use Data::Dumper;

my $input = $ARGV[0];

open(IN, $input);
my $l=0;
my @matrix;
while(my $distmat = <IN>)
{
    
    chomp($distmat);
    if($l <13 && $l>6)
    {
	#   print "$l\n";
	push(@matrix,$distmat);
	
    }
    $l++;
}
#    print join("\n",@matrix),"\n";
my @m1 = split("\t",$matrix[0]);
my @m2 = split("\t",$matrix[1]);
my @m3 = split("\t",$matrix[2]);
my @m4 = split("\t",$matrix[3]);

#    print Dumper @m3;

print  "   4\n";
print  "NcA1        $m1[1]  $m1[2]  $m1[3]  $m1[4]\n";
print  "NcA2        $m1[2]  $m2[2]  $m2[3]  $m2[4]\n";
print  "Nd          $m1[3]  $m2[3]  $m3[3]  $m3[4]\n";
print  "NcC         $m1[4]  $m2[4]  $m3[4]  $m4[4]\n";
print "\n";

