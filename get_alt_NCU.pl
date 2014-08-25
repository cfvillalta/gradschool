#! /usr/bin/perl -w

use strict;

use Data::Dumper;

#input in funcat infor and output NCUs that have an alternate.

my $input = $ARGV[0];

open(IN, $input);

while(my $in = <IN>)
{
    chomp($in);
    if($in =~ m/(NCU\d+).+(NCU\d+)/)
    {
	print "$1\t$2\n";
    }
}
