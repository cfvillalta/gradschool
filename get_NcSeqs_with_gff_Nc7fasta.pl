#!/usr/bin/perl

use Bio::Tools::GFF;
use Bio::SeqIO;
use Bio::SeqFeature::Generic;
use strict;


#get sequences from fasta and put them in a hash.

my $fasta_Nc = $ARGV[0];

my %sequences;

my $in = Bio::SeqIO ->new (-file => "$fasta_Nc", -format => 'fasta');

while (my $seq = $in -> next_seq())
{
#	print $seq -> id, "\n";
	$sequences{$seq->id} = $seq;   
}

my $nc7ID = $ARGV[1];
open(ID, $nc7ID);


my @seqID_array;

while(my $seqID = <ID>)
{
    chomp($seqID);
    push(@seqID_array, $seqID);
}

#print join("\n", @seqID_array);

my $Nc7_gff3 = $ARGV[2];

open(GFF, $Nc7_gff3);

while(my $gff = <GFF>)
{
    if($gff =~ m/Ncra.+/)
    {
	chomp($gff);
	if($gff =~ m/(NCU\d+);/)
	   {
#	       print $1, "\n";
	       foreach my $ncID (@seqID_array)
	       {
		   if ($1 eq $ncID)
		   {
#		       print $1, "\t", $ncID, "\n";
#		       print $gff, "\n";
		       my @parsed_gff = split(/\t/, $gff);
		       my $contig = $parsed_gff[0];
		       my $start = $parsed_gff[3];
		       my $end = $parsed_gff[4];
		       my $strand = $parsed_gff[6];
		       #print $start, "\t", $end, "\t", $strand, "\n";
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
	   }
    }
}
