#! /usr/bin/perl

use strict;

my $table = $ARGV[0];

open(TABLE, $table);

while(my $line = <TABLE>)
{
    if($line =~ m/PCS1_ID/)
    {
	print $line;
    }
    elsif($line =~ m/.+\t\d+\.\d+\t\d+\.\d+\t\d+\.\d+\t\d+\.\d+/)
    {
	chomp($line);
	my @line_array = split("\t", $line);
	my $c1 = $line_array[1];
	my $c2 = $line_array[2];
	my $e1 = $line_array[3];
	my $e2 = $line_array[4];

	my $avg_c = (($c1+$c2)/2);
	my $avg_e = (($e1+$e2)/2);

	if(($avg_c)>($avg_e*(1.5))&& $avg_e>1 && $avg_c>1)
	{
#	    print $line_array[0],"\t",$avg_c,"\t", $avg_e,"\n";
	}
	elsif(($avg_e)>($avg_c*(1.5)) && $avg_e>1 && $avg_c>1)
	{
	    print $line_array[0],"\t",$avg_c,"\t", $avg_e,"\n";
	} 
	
    }
    else
    {
#	print $line;
    }
}
