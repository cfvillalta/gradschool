#!/usr/bin/perl

use Bio::Tools::GFF;
use Bio::SeqIO;
use Bio::SeqFeature::Generic;
use strict;

#get sequences from the Ndiscreta fasta file.

my $fasta_Nd = $ARGV[0];

my %sequences;

my $in = Bio::SeqIO ->new (-file => "$fasta_Nd", -format => 'fasta');

while (my $seq = $in -> next_seq())
{
#    print $seq -> id, "\n";
    $sequences{$seq->id} = $seq;
}

my $Nd_gff = $ARGV[1];
open(GFF, $Nd_gff);

while(my $gff = <GFF>)
{
    chomp($gff);
    my @parsed_gff = split(/\t/, $gff);
    my $type = $parsed_gff[2];
    my $contig = $parsed_gff[0];
    my $start = $parsed_gff[3];
    my $end = $parsed_gff[4];
    my $strand = $parsed_gff[6];
    my $ID = $parsed_gff[8];
#    print $gff, "\n";
    if($type eq "gene")
    {
	$ID =~ m/ID=(.+);/;
#	print $gff, "\n";
	if ($strand eq "+")
	{ 
	    my $exonseq = $sequences{$contig} -> subseq($start,$end);
	    print ">",$1, "\n";
	    print $exonseq, "\n";
	}
	else
	{
	    my $rev_exonseq = $sequences{$contig} -> subseq($start, $end);
	    my $rev_exonseq2 = Bio::Seq -> new (-seq => $rev_exonseq);
	    print ">", $1, "\n";
	    print $rev_exonseq2->revcom->seq, "\n";
	}
	
    }

}
