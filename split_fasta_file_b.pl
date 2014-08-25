#!/usr/bin/perl

use strict;
use Bio::SeqIO;

#input a fasta file to split up and will output many smaller files with the  sequence name as the new file name. 

my $fasta_file = $ARGV[0];

#print $fasta_file;

my %sequences;

my $in = Bio::SeqIO -> new(-file => "$fasta_file", -format => 'fasta');

while (my $seq = $in -> next_seq())
{
    $sequences{$seq->id} = $seq;
}

foreach my $seq2 (keys %sequences)
{
    my $filename = $seq2.".fa";
    open(OUT, '>', $filename);
    my $out = $sequences{$seq2}->seq();
    print OUT ">",$seq2, "\n", $out,"\n";
    close(OUT);
    open(ID, '>>', "Blast_ids.ids");
    print ID $filename, "\n";
    close (ID);
}
