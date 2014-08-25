#!/usr/bin/perl

#Input two text files one with the ids of files I want to wu-blast against different genomes and the other file containing the genomes I want to blast the genes against. 

#want to output blast output into separate file per genome or can have one large blast output.
use strict;

my $blast_ids = $ARGV[0];

my $genome_ids = $ARGV[1];

my @blast;

my @genome;

open(BLAST, $blast_ids);

open(GEN, $genome_ids);

while( my $blast = <BLAST>)
{
    chomp($blast);
    push(@blast, $blast);
}

while( my $genome = <GEN>)
{
    chomp($genome);
    push(@genome, $genome);
}

foreach my $g(@genome)
{
    foreach my $b(@blast)
    {
	my $system_call = "wu-blastall -p tblastx -d /data/genomes/dna/$g -i $b -m 8 -e E-3";
#	print $system_call;
	system($system_call);
    }
}
