#! /usr/bin/perl -w

use strict;
use Data::Dumper;

my $input = $ARGV[0];

open(IN, $input);
my $n=0;
while( my $in = <IN>)
{
    if($in =~ m/6/)
    {
	$n++;
	close(OUT);
	open(OUT,">seqboot_$n");

	
    }
    print OUT $in;
}

close(OUT);
my @nums=(1..100);
my @lines=(7..12);
my $counter=0;
open(P,">phylip_bs.out");
foreach my $num(@nums)
{  
    print "$num\n";
    system("distmat -sequence seqboot_$num -protmethod 0 -outfile seqboot_$num.out");
    
    open(DISTMAT, "seqboot_$num.out");
    my $l=0;
    my @matrix;
    while(my $distmat = <DISTMAT>)
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
    my @m5 = split("\t",$matrix[4]);
    my @m6 = split("\t",$matrix[5]);
    $counter++;
#    print Dumper @m3;

    print P "   6\n";
    print P "NcA1        $m1[1]  $m1[2]  $m1[3]  $m1[4]  $m1[5]  $m1[6]\n";
    print P "NcA2        $m1[2]  $m2[2]  $m2[3]  $m2[4]  $m2[5]  $m2[6]\n";
    print P "Nd          $m1[3]  $m2[3]  $m3[3]  $m3[4]  $m3[5]  $m3[6]\n";
    print P "NcC         $m1[4]  $m2[4]  $m3[4]  $m4[4]  $m4[5]  $m4[6]\n";
    print P "PcWy        $m1[5]  $m2[5]  $m3[5]  $m4[5]  $m5[5]  $m5[6]\n";
    print P "PcWo        $m1[6]  $m2[6]  $m3[6]  $m4[6]  $m5[6]  $m6[6]\n";
    print P"\n";
}
close(P);
