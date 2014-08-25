#!/usr/bin/perl

use strict;
use Bio::SeqIO;

my $list = $ARGV[0];

open(LIST, $list);
my @seqs;

while( my $seqs = <LIST>)
{
    chomp($seqs);
    push(@seqs, $seqs);    
}

foreach my $s (@seqs)
{
    my %sequences;
    my $in = Bio::SeqIO -> new(-file => "$s", -format => 'fasta');

    while(my $seq = $in -> next_seq())
    {
	$sequences{$seq->id} = $seq;
    }

    foreach my $seq2(keys %sequences)
    {
	my $filename = $seq2.".fa";
	open(OUT, '>',$filename);
	my $out = $sequences{$seq2}->seq();
	print OUT ">", $seq2, "\n", $out, "\n";
	close(out);
    }
}
