#! /usr/bin/perl -w

use strict;


my $file = $ARGV[0];

open(F, $file);

while(my $f = <F>)
{

    chomp($f);
    my @f_split = split("\t", $f);
    if($f =~ m/(NCU\d+)\./)
    {
	print $1,"\t", $f_split[1],"\n";
    }
    else
    {
	print $f,"\n";
    }
}
