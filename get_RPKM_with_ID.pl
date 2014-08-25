#!/usr/bin/perl

my $EXPR = $ARGV[0];
open(EXPR,$EXPR);

my $list = $ARGV[1];

open(LIST, $list);

my @GENES;

while(my $genes = <LIST>)
{
    chomp($genes);
    push(@GENES, $genes);
}


while(my $expr = <EXPR>)
{
    chomp($expr);
    $expr =~ m/(NCU\d+)\t/;
    $exp = $1;
#    print $1, "\n";

    foreach $gene(@GENES)
    {
#	print $gene;
	if($exp eq $gene)
	{
	    print $expr, "\n";
	}
    } 
    
}
