#! /usr/bin/perl -w

use strict;
use Data::Dumper;
use Statistics::Descriptive;

my $input = $ARGV[0];

open(IN, $input);
my $n=0;
while( my $in = <IN>)
{
    if($in =~ m/4/)
    {
	$n++;
	close(OUT);
	open(OUT,">seqboot_$n");

	
    }
    print OUT $in;
}

close(OUT);
my @d1;
my @d2;
my @d3;
my @d4;
my @d5;
my @d6;
my @d7;
my @d8;
my @d9;
my @d10;
my @d11;
my @d12;
my @d13;
my @d14;
my @d15;
my @d16;


my @nums=(1..100);
my @lines=(7..12);
my $counter=0;

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
    $counter++;
#    print Dumper @m3;
    push(@d1,$m1[1]);
    push(@d2,$m1[2]);
    push(@d3,$m1[3]);
    push(@d4,$m1[4]);
    push(@d5,$m2[1]);
    push(@d6,$m2[2]);
    push(@d7,$m2[3]);
    push(@d8,$m2[4]);
    push(@d9,$m3[1]);
    push(@d10,$m3[2]);
    push(@d11,$m3[3]);
    push(@d12,$m3[4]);
    push(@d13,$m4[1]);
    push(@d14,$m4[2]);
    push(@d15,$m4[3]);
    push(@d16,$m4[4]);

}
my @d_a=(@d1,@d2,@d3,@d4,@d5,@d6,@d7,@d8,@d9,@d10,@d11,@d12,@d13,@d14,@d15,@d16);

my @ma;

foreach my $x(@d_a)
{
    my $stat = Statistics::Descriptive::Full->new();
    $stat->add_data(@$x);
    my $med=$stat->median();
    push(@ma, $med);
}
    
open(P,">phylip_bs_median_matrix_consensus.out");

    print P "   4\n";
    print P "NcA1        $ma[1]  $ma[2]  $ma[3]  $m4[4]\n";
    print P "NcA2        $m5[2]  $m6[2]  $m7[3]  $m8[4]\n";
    print P "NcC          $m9[3]  $m10[3]  $m11[3]  $m12[4]\n";
    print P "Nd         $m13[4]  $m14[4]  $m15[4]  $m16[4]\n";
    print P"\n";
close(P);
