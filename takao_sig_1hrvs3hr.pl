#! /usr/bin/perl -w 

use strict;
use Data::Dumper;

my $input = $ARGV[0];

open(IN, $input);

while(my $in = <IN>)
{
    chomp($in);
 #   print $in;
    my @s = split("\t",$in);
    if($s[0] =~ m/(NCU\d+)\./)
    {
#	my $diff = $s[2]/$s[1];
#	if($diff>1.5 && $s[4]>0.95)
#	{
#	    print $1,"\t";
#	    print $s[4],"\t";
#	    print $diff,"\n";
#	}
#	my $diff_neg = $s[1]/$s[2];
#	if($diff_neg>1.5 && $s[3]>0.95)
#	{
	    print $1,"\n";
#	    print $s[3],"\t";
#	    print "-$diff_neg\n";
#	}
    }
}
