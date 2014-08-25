#! /usr/bin/perl -w

use Data::Dumper;
use strict;

#Input in alone vs. before, alone vs.after, and before vs. after for DESeq, edgeR, and the poisson.

#would be nine files.

my $edger1 = $ARGV[0];
my $edger2 = $ARGV[1];
my $edger3 = $ARGV[2];

my $rc1= $ARGV[3];
my $rc2= $ARGV[4];
my $genes = $ARGV[5];

open(E1,$edger1);
open(E2,$edger2);
open(E3,$edger3);

open(RC1,$rc1);
open(RC2,$rc2);

open(G, $genes);

my %edgeR1;
my %edgeR2;
my %edgeR3;
my %rc1;
my %rc2;
my @NCU;

while(my $e1 = <E1>)
{
    chomp($e1);
    my @array = split("\t", $e1);
    $edgeR1{$array[1]}=[@array];
}

while(my $e2 = <E2>)
{
    chomp($e2);
    my @array = split("\t", $e2);
    $edgeR2{$array[1]}=[@array];
}

while(my $e3 = <E3>)
{
    chomp($e3);
    my @array = split("\t", $e3);
    $edgeR3{$array[1]}=[@array];
}

while(my $r1 = <RC1>)
{
    chomp($r1);
    my @array=split("\t",$r1);
    $rc1{$array[0]}=[@array];
}

while(my $r2 = <RC2>)
{
    chomp($r2);
    my @array=split("\t",$r2);
    $rc2{$array[0]}=[@array];
}

while(my $g = <G>)
{
    if($g =~ m/NCU/)
    {
	chomp($g);
	push(@NCU,$g);
    }
}    

#input all files pois edgeR and DESeq from the sig <0.05
#also input a list of all files in certain condition eg all in 2489 sig 1.5 fold up and down in alone vs before before vs after and alone vs after.
#also input in readcounts
my %alone_before;
my %before_after;
my %alone_after;

#go through each gene if it is up/down and sig in edgeR or DESeq or pois call sig. But if opposite like sig up and then sig down in another call "X". If not present/not sig call "N"
my %all_ncu;
#alone versus before
foreach my $x(@NCU)
{
    my @all;
    if($x =~ m/NCU/)
    {
#	print $x,"\t";
	
#edgeR
	my $er1;
	if(exists $edgeR1{$x})
	{
	    $all_ncu{$x}=$x;
	    my $a1 = $edgeR1{$x};
	    my @array1= @$a1;
#	print $array1[2],"\t"
	    if($array1[6] > 0)
	    {
#		print "eU";
		push(@all,"U");
	    }
	    elsif($array1[6]<0)
	    {
		push(@all,"D");
	    }	
	}
    }
    my $all_s=join("",@all);
    #print $all_s,"\t";
    if($all_s =~ m/D/ && $all_s =~ m/U/)
    {
#	print "X\n";
	$alone_before{$x}="X";
    }
    elsif($all_s =~ m/U/ && $all_s !~ m/D/)
    {
#	print "U\n";
	$alone_before{$x}="U";
    }
    elsif($all_s =~ m/D/ && $all_s !~ m/U/)
    {
#	print "D\n";
	$alone_before{$x}="D";
    }
#    print "\n";
}

foreach my $x (@NCU)
{

    if(exists $all_ncu{$x})
    {
    }
    else
    {
	$alone_before{$x}="N";
#	print "N\n";
    }
}

###################
#before vs after
my %all_ncu2;
foreach my $x(@NCU)
{
    my @all;
    if($x =~ m/NCU/)
    {
#	print $x,"\t";
	
#edgeR
	my $er2;
	if(exists $edgeR2{$x})
	{
	    $all_ncu2{$x}=$x;
	    my $a1 = $edgeR2{$x};
	    my @array1= @$a1;
#	print $array1[2],"\t"
	    if($array1[6] > 0)
	    {
#		print "eU";
		push(@all,"U");
	    }
	    elsif($array1[6]<0)
	    {
		push(@all,"D");
	    }	
	}
    
	my $all_s=join("",@all);
    #print $all_s,"\t";
	if($all_s =~ m/D/ && $all_s =~ m/U/)
	{
#	print "X\n";
	    $before_after{$x}="X";
	}
	elsif($all_s =~ m/U/ && $all_s !~ m/D/)
	{
#	print "U\n";
	    $before_after{$x}="U";
	}
	elsif($all_s =~ m/D/ && $all_s !~ m/U/)
	{
#	print "D\n";
	    $before_after{$x}="D";
	}
#    print "\n";
    }
}

foreach my $x (@NCU)
{

    if(exists $all_ncu2{$x})
    {
    }
    else
    {
#	print "N\n";
	$before_after{$x}="N";
    }
}

#before vs alone
my %all_ncu3;
foreach my $x(@NCU)
{
    my @all;
    if($x =~ m/NCU/)
    {
#	print $x,"\t";
	
#edgeR
	my $er3;
	if(exists $edgeR3{$x})
	{
	    $all_ncu3{$x}=$x;
	    my $a1 = $edgeR3{$x};
	    my @array1= @$a1;
#	print $array1[2],"\t"
	    if($array1[6] > 0)
	    {
#		print "eU";
		push(@all,"U");
	    }
	    elsif($array1[6]<0)
	    {
		push(@all,"D");
	    }	
	}
    }
    
    my $all_s=join("",@all);
    #print $all_s,"\t";
    if($all_s =~ m/D/ && $all_s =~ m/U/)
    {
#	print "X\n";
	$alone_after{$x}="X";
    }
    elsif($all_s =~ m/U/ && $all_s !~ m/D/)
    {
#	print "U\n";
	$alone_after{$x}="U";
    }
    elsif($all_s =~ m/D/ && $all_s !~ m/U/)
    {
#	print "D\n";
	$alone_after{$x}="D";
    }
#    print "\n";
}

#my $number=0;
foreach my $x (@NCU)
{
#    $number++;

    if(exists $all_ncu3{$x})
    {
    }
    else
    {
	$alone_after{$x}="N";
#	print "N\n";
    }
}
#print "HI\t$number\n";

##################
#PRINT INFO
##################
foreach my $x (@NCU)
{
    print "$x\t";
    print "$alone_before{$x}";
    print "$before_after{$x}";
    print "$alone_after{$x}\n";
}
