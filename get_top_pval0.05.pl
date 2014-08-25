#!usr/bin/perl

use strict;

my $pval = $ARGV[0];

open(PVAL, $pval);

while(my $values = <PVAL>)
{
    chomp($values);
    my @parsed_values = split(/\t/,$values);
    if($parsed_values[1] < 0.05)
    {
	print $values, "\n";
    }
}
