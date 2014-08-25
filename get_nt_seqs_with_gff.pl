#!/usr/bin/perl

use Bio::Tools::GFF;
use Bio::SeqIO;
use Bio::SeqFeature::Generic;
use strict;

#gff with coordinates of sequences I want.

my $filename = $ARGV[0];

#genome fasta file
my $filename2 = $ARGV[1];

my $feature;

my %sequences;

my @gff_file;

my $gff = Bio::Tools::GFF -> new(-file => $filename, -version => 2);
#print $gff;
my $in = Bio::SeqIO ->new(-file => "$filename2", -format => 'fasta');

open(GFF, $filename);

while(my $gff_file = <GFF>)
{
    push(@gff_file, $gff_file);
    
}

while (my $seq = $in -> next_seq())
{
#    print $seq -> id, "\n";
    $sequences{$seq->id} = $seq;    
}


while (my $feature = $gff ->next_feature())
{
    my $contig = $feature -> seq_id();
    my $start = $feature -> start();
    my $end = $feature -> end();
    my $strand = $feature -> strand();
    my $exon_id = $feature -> primary_tag();
    my $frame = $feature -> frame();
    my $tags = $feature ->gff_string();

    if($strand >= 1)
    {
	foreach my $line(@gff_file)
	{
	    if ($line =~ m/$contig/ && $line =~ m/$start/ && $line =~ m/$end/)
	    {
		my @line = split("\t", $line);
		print ">". @line[8];

#		print "Contig: ", $contig, "\n", "Exon_type: ", $exon_id, "\n", "Start: ", $start, "\n", "End: ", $end, "\n", "Strand: ", $strand, "\n", "Frame: ", $frame, "\n";
		my $exonseq = $sequences{$contig} -> subseq($start,$end);	
		print $exonseq, "\n";
	    }
	}
    }
    else
    {
	foreach my $line(@gff_file)
	{
            if ($line =~ m/$contig/ && $line =~ m/$start/ && $line =~ m/$end/)
	    {   
		my @line = split("\t", $line);
		print ">".@line[8];

    
#		print "Contig: ", $contig, "\n", "Exon_type: ", $exon_id, "\n", "Start: ", $start, "\n", "End: ", $end, "\n", "Strand: ", $strand, "\n", "Frame: ", $frame, "\n";
		my $rev_exonseq = $sequences{$contig} -> subseq($start,$end);
		my $rev_exonseq2 = Bio::Seq -> new(-seq => $rev_exonseq);
		print $rev_exonseq2 ->revcom->seq, "\n";
	    }
	}
    }
}

