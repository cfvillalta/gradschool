#!/usr/bin/perl

use strict;
use Bio::SeqIO;

my $seq_in = $ARGV[0];

#print $seq_in;

my $start = $ARGV[1];

my $end = $ARGV[2];

my $genome = $ARGV[3];

my %sequences;

my $in = Bio::SeqIO -> new(-file => "$genome", -format => 'fasta');

while( my $seq = $in -> next_seq())
{   
    $sequences{$seq->id} = $seq;
}

my $out = $sequences{$seq_in}->subseq($start, $end);

print ">PCS1_8008_".$seq_in."_".$start."_".$end."\n";
print $out;
