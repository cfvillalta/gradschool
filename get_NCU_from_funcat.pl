#! /usr/bin/perl -w

use strict;
use Data::Dumper;
#a script where I input the NCU file that was enriched, my funcat file with all the NCUS and the funcat terms that were found to be enriched. 

#the output will be the funcat term and underneath it the NCUS that were within it.

my $ncu_list= $ARGV[0];
my $sig_funcat=$ARGV[1];
my $funcat_table=$ARGV[2];

open(NCU,$ncu_list);
open(SIG, $sig_funcat);
open(TABLE, $funcat_table);

my @ncu;
while(my $n = <NCU>)
{
    chomp($n);
    push(@ncu,$n);
}
#print Dumper @ncu;
my %sig;
while(my $s = <SIG>)
{
    chomp($s);
    if($s =~ m/(LEVEL\_.+\d+)\_/)
    {
#	print $1,"\n";
	$sig{$1}=$s;
    }
}

my %table;
while(my $t=<TABLE>)
{
    chomp($t);
 #   print $t,"\n";
    my @ts= split("\t",$t);
    my $id = "$ts[0]\t$ts[1]";
    my @ns= split(",",$ts[2]);
    $table{$id}=[@ns];
}

#print Dumper %table;

foreach my $x(keys %sig)
{
    print "$sig{$x}\n";
  #  print "$x\n";
    my $term=$table{$x};
    my @genes=@$term;
  #  print Dumper @genes;
    foreach my $x(@genes)
    {
#	print "$x\n";
	foreach my $y(@ncu)
	{
	 #   print "$y\n";
	    if($x eq $y)
	    {
		print "$x\n";
	    }
	}
    }
}

