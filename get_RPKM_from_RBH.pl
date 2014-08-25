#!/usr/bin/perl

use strict;

my $rbh = $ARGV[0];

open(RBH, $rbh);

my @hits1_array;
my @hits2_array;

my %rbh;
my @Nc_exp;
my @Nd_exp;

while( my $hits1 = <RBH>)
{
    chomp($hits1);
    my @hits_array = split("\t", $hits1);
    push(@hits1_array,$hits_array[0]);
    push(@hits2_array, $hits_array[1]);
    $rbh{$hits_array[0]} = $hits_array[1];
}

#print @hits1_array;

my $EXPR = $ARGV[1];
open(EXPR, $EXPR);

my $EXPR2 = $ARGV[2];
open(EXPR2, $EXPR2);

while(my $expr = <EXPR>)
{
    chomp($expr);
    $expr =~ m/(NCU\d+)\t/;
    my $exp = $1;
#    print $1, "\n";                                                                                                                  

    foreach my $gene(@hits1_array)
    {
 #      print $gene;                                                                                                                  
        if($exp eq $gene)
        {
#            print $expr, "\n";
	    push(@Nc_exp, $expr);  
        }
    }
}

while(my $expr2 = <EXPR2>)
{
    chomp($expr2);
    my @expr_2_array = split("\t", $expr2);
    my $exp2 = $expr_2_array[0];
    $exp2 =~ m/(.+)\.8579/;
    my $expression2 = $1;
    
    foreach my $gene2(@hits2_array)
    {
#	          print $gene2, "\n";                                                                                                                                                                    
	if($expression2 eq $gene2)
	{
	    my $Nd_expression = $expression2."\t".$expr_2_array[1];
	    push (@Nd_exp, $Nd_expression);
	}
    }
    
}

foreach my $nc(keys %rbh)
{
#    print $nc, "\n";
    foreach my $nd_exp(@Nd_exp)
    {
#	print $nd_exp, "\n";
	foreach my $nc_exp(@Nc_exp)
	{
	    my @nd_exp = split("\t", $nd_exp);
	    my @nc_exp = split("\t", $nc_exp);
		
	    
	    if( $rbh{$nc} eq $nd_exp[0] && $nc eq $nc_exp[0])
	    {
		print $nd_exp, "\t", $nc_exp, "\n";
	    }
	}
    }
}
