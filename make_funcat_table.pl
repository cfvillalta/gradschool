#! /usr/bin/perl -w

use strict;

use Data::Dumper;

#input the file with all the funcat ids.

#input a file with all the funcat neurospora data.

my $input1=$ARGV[0];
my $input2=$ARGV[1];

open(IN1, $input1);
open(IN2, $input2);

my @fc_id;
while(my $in1=<IN1>)
{
    chomp($in1);
    push(@fc_id,$in1);
}

my @nc_fc;
my %ncu_99;
while(my $in2=<IN2>)
{
    chomp($in2);
    push(@nc_fc,$in2);
}

foreach my $x (@fc_id)
{
    
    
    print "LEVEL_";
#    print $x,"\n";
	my @x_s= split("\\.",$x);
#    print Dumper @x_s;
	my $n=0;
	foreach my $y(@x_s)
	{
#	print $y,"\n";
	    $n++;
	}
    print "$n\t";
    print "$x\t";
    #looking through list to match funcat id
    
	my %ncu;
   
	foreach my $z(@nc_fc)
	{
	    if($z =~ m/(\t$x)/)
	    {
	#	print $x,"\t";
#	    print $z,"\n";
#	    print $1,"\n";
		if($z =~ m/(NCU\d+)/)
	    {
		#	print $1,"\n";
		$ncu{$1}=$1;
		$ncu_99{$1}=$1;
	    }
	    }
	}
	
	my @ncu_array;
	foreach my $ncuid(sort(keys %ncu))
	{
	    
	    push(@ncu_array,$ncuid);
	}
	  print join("\,",@ncu_array),"\n";
}
    

print "LEVEL_1\t99\t";
my @ncu_99_a;
my %all_ncu;
foreach my $x1(@nc_fc)
{
   # print $x,"\n";
    if($x1 =~ m/(NCU\d+)/)
    {
#	print $1,"\n";
	$all_ncu{$1}=$1;
    }
}

foreach my $id(keys %all_ncu)
{
    if(exists $ncu_99{$id})
    {
#	print $x;
    }
    else
    {
	push(@ncu_99_a,$id);
    }
}

print join("\,",sort(@ncu_99_a)),"\n";
