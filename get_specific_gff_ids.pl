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

#sequences I want from the gff                                                                      
my $filename3 = $ARGV[1];

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
		if($gff =~ m/Einit/ || $gff =~ m/Eterm/ || $gff =~ m/Esngl/)
		{
		    print $gff;
		}
	    }
    }
}
