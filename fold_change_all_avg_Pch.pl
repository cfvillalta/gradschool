#! /usr/bin/perl

use strict;

my $readcounts = $ARGV[0];

open(READCOUNTS, $readcounts);
open(COUNT,$readcounts);
my $lines;
my $hits_c1;
my $hits_c2;
my $hits_e1;
my $hits_e2;

while(my $line = <COUNT>)
{
    if($line !~ m/\#/)
    {
	$lines +=($line =~ tr/\n//);
	chomp($line);
	my @split_line = split("\t",$line);
	$hits_c1 += $split_line[1];
	$hits_c2 += $split_line[2];    
	$hits_e1 += $split_line[3];
	$hits_e2 += $split_line[4];

    }
}
open(BEFORE,">before_up_all_Pchr.out");
open(AFTER,">after_up_all_Pchr.out");
while (my $reads = <READCOUNTS>)
{
    if($reads =~ m/\#/)
    {
	chomp($reads);
	print BEFORE $reads,"\t","Fold_change","\t","Condition_up","\n";
	print AFTER $reads,"\t","Fold_change","\t","Condition_up","\n";
    }
    elsif($reads !~ m/\#/)
    {
	chomp($reads);
	my @rc_split =split("\t",$reads);
#get normalized scores of each condition.Want to see if they are a percentage in relation to eachother.
#	print $rc_split[2];
	my $c1 = ($rc_split[1]/$hits_c1);
	my $c2 = ($rc_split[2]/$hits_c2);
	my $e1 = ($rc_split[3]/$hits_e1);
	my $e2 = ($rc_split[4]/$hits_e2);

	
	my $c1_norm = int(($rc_split[1]/$hits_c1)*10000000);
	my $c2_norm = int(($rc_split[2]/$hits_c2)*10000000);
	my $e1_norm = int(($rc_split[3]/$hits_e1)*10000000);
	my $e2_norm = int(($rc_split[4]/$hits_e2)*10000000);
;
	
	
	my $c12 = (($c1+$c2)/2);
	my $e12 = (($e1+$e2)/2);
	if((($c1 + $c2)>0) && (($e1 + $e2) > 0))
	   {
	       if(($c12/$e12)>1.5)
	       {
		   printf BEFORE "$rc_split[0]\t$e1_norm\t$e2_norm\t$c1_norm\t$c2_norm\t%.1f\tbefore\n",($c12/$e12);
	       }
	       elsif(($e12/$c12) >1.5)
	       {
		   printf AFTER "$rc_split[0]\t$c1_norm\t$c2_norm\t$e1_norm\t$e2_norm\t%.1f\tafter\n",($e12/$c12);
	       }
	   }
       }
    }
close(BEFORE);
close(AFTER);
