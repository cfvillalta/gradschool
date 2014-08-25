#! /usr/bin/perl -w


use strict;

use Data::Dumper;

#my sig genes
my $input1=$ARGV[0];
my $sig_ncu;
if($input1 =~ m/(.+)\./)
{
    $sig_ncu=$1;
}
#sig genes I want to compare with 
my $input2=$ARGV[1];
my $betsy;
if($input2 =~ m/(.+)\./)
{
    $betsy=$1;
}
#input total genes from study I want to compare my genes to(in this case HI).
my $input3=$ARGV[2];

#print $input1,"\n";
#print $input2,"\n";
#print $input3,"\n";


open(IN1, $input1);
open(IN2, $input2);
open(IN3, $input3);


my %ncu_sig1;
my %ncu_sig2;
my %ncu_all2;

while(my $in1 = <IN1>)
{
    chomp($in1);
    $ncu_sig1{$in1}=$in1;
}

while(my $in2 = <IN2>)
{
    chomp($in2);
    $ncu_sig2{$in2}=$in2;
}

while(my $in3 = <IN3>)
{
    chomp($in3);
    $ncu_all2{$in3}=$in3;
}
my %ncu_sig1_present;
my $sig1_present=0;
foreach my $x(keys %ncu_sig1)
{
    if(exists $ncu_all2{$x})
    {
	$sig1_present++;
	$ncu_sig1_present{$x}=$x;
    }
}
#print $sig1_present,"\n";
#print $sig1_present,"\n";

my $sig2 = 0;
foreach my $x(keys %ncu_sig2)
{
    $sig2++;
}

#print $sig2,"\n";

my $all2=0;

foreach my $x(keys %ncu_all2)
{
    $all2++;
}
#print $all2,"\n";

my $share=0;
open(NCU, ">$sig_ncu\_$betsy\_share\.ncu");
foreach my $x(keys %ncu_sig1)
{
    if(exists $ncu_sig2{$x})
    {
	$share++;
	print NCU $x,"\n";
    }
}

open(OUT,">phyper.in");
print OUT "1-phyper($share,$sig2,($all2-$sig2),$sig1_present)";

close(OUT);
system("R --no-save <phyper.in> temp");
open(TEMP, "temp");
print "1-phyper($share,$sig2,($all2-$sig2),$sig1_present)\n";
while(my $temp = <TEMP>)
{
    chomp($temp);
    if($temp =~ m/\[1\]\s(\d.+)/)
    {
	print "$input1\t$input2\t$1\n\n";
    }
    elsif($temp =~ m/\[1\]\s(\d)/)
    {
	print "$input1\t$input2\t$1\n\n";
    }
}
close(TEMP);

