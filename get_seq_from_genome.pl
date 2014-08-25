#! /usr/bin/perl -w


use strict;

use Data::Dumper;

use Bio::SeqIO;

#input genome/contig/start/end and get the sequence out.

my $genome = $ARGV[0];

my $contig = $ARGV[1];

my $start = $ARGV[2];

my $end = $ARGV[3];

my $name = $ARGV[4];

my $in = Bio::SeqIO->new(-file=>"$genome", -format => 'fasta');

my %sequence;

while(my $seq = $in -> next_seq())
{
    $sequence{$seq->id}=$seq;
}

foreach my $key( keys %sequence)
{
    print $sequence{$key}->seq,"\n";
}

#my $genome_seq;

#if($start < $end)
#{
 #   $genome_seq = $sequence{$contig}->subseq($start,$end);

  #  print ">",$name,"\n",$genome_seq,"\n";
#}

#elsif($start>$end)
#{
 #  $genome_seq = $sequence{$contig}->subseq($end,$start);

  #  print ">",$name,"\n",$genome_seq,"\n";
#}
