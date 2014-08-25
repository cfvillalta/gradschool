#!/usr/bin/perl -w

use Data::Dumper;
use strict;


#is the ncu and the trend $1 and $2
my $input =$ARGV[0];

open(IN,$input);

my %ncu_trend;
my %trend;


while(my $in =<IN>)
{
    chomp($in);
    my @in_s=split("\t",$in);
    $ncu_trend{$in_s[0]}=$in_s[1];
    $trend{$in_s[1]}=0;
}

#print Dumper %ncu_trend;
#print Dumper %trend;
foreach my $x (keys %trend)
{
    print $x,"\n";
    open(T,">R\_$x\.in");
    foreach my $y(keys %ncu_trend)
    {
	if ($x eq $ncu_trend{$y}) 
	{
	    #print $y,"\n";
	    print T $y,"\n";
	}
    }
    close(T);

    system("perl funcat\_enrichment\.pl all\_NCU\_2489\-D115\-D107\-8579\-PcWy\-PcWo\.ncu R_$x.in funcat\-2.1_scheme\|awk '\$2<0.05\'");
}
