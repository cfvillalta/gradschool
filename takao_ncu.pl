#! /usr/bin/perl -w 

use strict;
use Data::Dumper;

my $input = $ARGV[0];

open(IN, $input);

while(my $in = <IN>)
{
    chomp($in);
    my @s = split("\t",$in);
    if($s[1] =~ m/(NCU\d+)\./)
    {
#	my $diff = $s[10]/$s[11];
#	if($diff>1.5)
#	{
	    print $1,"\n";
#	    print $diff,"\n";
#	}
#	my $diff_neg = $s[11]/$s[10];
#	if($diff_neg>1.5)
#	{
#	    print $1,"\t";
#	    print "-$diff_neg\n";
#	}
    }
}
