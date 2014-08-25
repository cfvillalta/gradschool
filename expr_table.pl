#! /usr/bin/perl

use strict;
use Data::Dumper;

my %condition;
my @expr;
my @cons;
my %rpkm_hash;
my %conID_hash;
opendir(DIR,".") || die "can't opendir ".": $!";
my @files = readdir(DIR);
#print @files;
closedir(DIR);

foreach my $element (@files)
{
    if($element =~ m/.+\.expr\.(.+)/)
    {
	push(@expr, $element);
	$condition{$element}=$1;
    }
}



foreach my $con_file (@expr)
{
    my $con_ID = $condition{$con_file};
#    print $con_ID,"\n";
    push(@cons,$con_ID);
    open(CON,$con_file);
    while(my $line = <CON>)
    {
	chomp($line);
	my @hash_array;
	my @line_array = split("\t", $line);
	my $gene = $line_array[0];

	$rpkm_hash{$gene}{$con_ID}= $line_array[1];
    }
}
my @sorted = sort(@cons);
print "PCS1_ID\t", join("\t",@sorted),"\n";

foreach my $gene(keys %rpkm_hash)
{
    my @hold=();
    foreach my $cond(sort keys %{$rpkm_hash{$gene}})
    {
	push(@hold,$rpkm_hash{$gene}{$cond});
    }
    print $gene, "\t", join("\t",@hold,"\n");
}
#print Dumper %rpkm_hash;
#print Dumper %conID_hash;


