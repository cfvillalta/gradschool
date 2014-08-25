#!/usr/bin/perl                                                                                     

use Bio::Tools::GFF;
use Bio::SeqIO;
use Bio::SeqFeature::Generic;
use strict;

#gff file of genome                                                                                 
my $filename = $ARGV[0];

#print $filename, "\n";                                                                             

my $gff = Bio::Tools::GFF -> new( -file => $filename, -version => 2);

my $feature;

my @seqID;

my %sequences;

#fasta file of genome                                                                               
my $filename2 = $ARGV[1];

my $in = Bio::SeqIO ->new (-file => "$filename2", -format => 'fasta');

#sequences I want from the gff                                                                      
my $filename3 = $ARGV[2];

open(ID, $filename3);
open(GFF, $filename);

while(my $seqID = <ID>)
{
    chomp($seqID);
    push (@seqID, $seqID);
}

while(my $gff = <GFF>)
{
    foreach my $id(@seqID)
    {
	if ($gff =~ m/$id/)
	{
	    print $gff;
	}
    }
}
