#! /usr/bin/perl -w

use Data::Dumper;
use strict;

#This script will take in four files and sort them by expression pattern.
#U is up, D is down, and N is no change.

my $condition1=$ARGV[0];
my $condition2=$ARGV[1];
my $condition3=$ARGV[2];
my $condition4=$ARGV[3];
open(C1,$condition1);
open(C2,$condition2);
open(C3,$condition3);
open(C4,$condition4);

my @c1_p;
my @c2_p;
my @c3_p;
my @c4_p;
while(my $c1 = <C1>)
{
    chomp($c1);
    my @c1_s = split("\t",$c1);
    push(@c1_p,$c1_s[1]);
}
while(my $c2 = <C2>)
{
    chomp($c2);
    my @c2_s = split("\t",$c2);
    push(@c2_p,$c2_s[1]);
}
while(my $c3 = <C3>)
{
    chomp($c3);
    my @c3_s = split("\t",$c3);
    push(@c3_p,$c3_s[1]);
}
while(my $c4 = <C4>)
{
    chomp($c4);
    my @c4_s = split("\t",$c4);
    push(@c4_p,$c4_s[1]);
}

my @type=("U","D","N");
my @pattern;

foreach my $a(@type)
{
    foreach my $b(@type)
    {
	foreach my $c(@type)
	{
	    push(@pattern,"$a$b$c");
	}
    }
}
my $sum_1=0;
my $sum_2=0;
my $sum_3=0;
my $sum_4=0;

foreach my $n(@c1_p)
{
    $sum_1++;
}
foreach my $n(@c2_p)
{
    $sum_2++;
}
foreach my $n(@c3_p)
{
    $sum_3++;
}
foreach my $n(@c4_p)
{
    $sum_4++;
}

#print $sum_1,"\n";
#print $sum_2,"\n";
#print $sum_3,"\n";
#print $sum_4,"\n";


my %c1_exp;
foreach my $x(@pattern)
{
    foreach my $y(@c1_p)
    {
	if($x eq $y)
	{
	    if(exists $c1_exp{$x})
	    {
		my $n = $c1_exp{$x}+1;
		$c1_exp{$x}=$n;
	    }
	    else 
	    {
		$c1_exp{$x}=1;
	    }
	}
    }
}

my %c2_exp;
foreach my $x(@pattern)
{
    foreach my $y(@c2_p)
    {
	if($x eq $y)
	{
	    if(exists $c2_exp{$x})
	    {
		my $n = $c2_exp{$x}+1;
		$c2_exp{$x}=$n;
	    }
	    else 
	    {
		$c2_exp{$x}=1;
	    }
	}
    }
}
#print Dumper %c1_exp;

my %c3_exp;
foreach my $x(@pattern)
{
    foreach my $y(@c3_p)
    {
	if($x eq $y)
	{
	    if(exists $c3_exp{$x})
	    {
		my $n = $c3_exp{$x}+1;
		$c3_exp{$x}=$n;
	    }
	    else 
	    {
		$c3_exp{$x}=1;
	    }
	}
    }
}

my %c4_exp;
foreach my $x(@pattern)
{
    foreach my $y(@c4_p)
    {
	if($x eq $y)
	{
	    if(exists $c4_exp{$x})
	    {
		my $n = $c4_exp{$x}+1;
		$c4_exp{$x}=$n;
	    }
	    else 
	    {
		$c4_exp{$x}=1;
	    }
	}
    }
}

#print "trend\tNcA1\tNcA2\tNcC\tNd\n";
foreach my $p (@pattern)
{
    print "$p\t";
    if(exists $c1_exp{$p})
    {
#	print $c1_exp{$p},"\t";
	my $n1= sprintf("%.0f",$c1_exp{$p}/$sum_1*100);
	#my $n2= int($c1_exp{$p}/$sum_1*100);
	print "$n1\t";
	#print "$n2\n";
    }
    else 
    {
#	print "0\t";
#	print "0\t";
	print "0\t";
    }
    if(exists $c2_exp{$p})
    {
	my $n2= sprintf("%.0f",$c2_exp{$p}/$sum_2*100);
	print "$n2\t";
    }
    else 
    {
	print "0\t";
    }
if(exists $c3_exp{$p})
    {
	my $n3=sprintf("%.0f",$c3_exp{$p}/$sum_3*100);
	print "$n3\t";
    }
    else 
    {
	print "0\t";
    }
if(exists $c4_exp{$p})
    {
	my $n4 = sprintf("%.0f",$c4_exp{$p}/$sum_4*100);
	my $n4b=$c4_exp{$p}/$sum_4*100;
	print "$n4\n";
    }
    else 
    {
	print "0\n";
    }
}

