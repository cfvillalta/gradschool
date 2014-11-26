#!/usr/bin/perl
#Input two text files one with the ids of files I want to wu-blast against different genomes and the other file containing the genomes I want to blast the genes against. 

#want to output blast output into separate file per genome or can have one large blast output.
use strict;
#filepath of text file with ids I want to blast.
my $blast_ids = $ARGV[0];
#text file with list of genomes I want to blast against.
my $genome_ids = $ARGV[1];
#make an array called blast
my @blast;
#make an array called genome
my @genome;
#open file use filehandle BLAST
open(BLAST, $blast_ids);
#open file use filehandle GEN
open(GEN, $genome_ids);
#use a while loop to go through BLAST and readlines into the array @blast.
while( my $blast = <BLAST>)
{
    #get rid of whitespace
    chomp($blast);
    #move $blast string into array
    push(@blast, $blast);
}
#use a while loop to go through BLASR and readlines into the array @genome.
while( my $genome = <GEN>)
{
    #get rid of whitespace
    chomp($genome);
    #move $blast string into array
    push(@genome, $genome);
}
#foreach loop through each string in @genome
foreach my $g(@genome)
{
    #foreach loop through each string in @blast
    foreach my $b(@blast)
    {
	#make a string called $system_call with commands to run wu-blastall tblastx for specific sequences against genomes (dna) on mycelium
	my $system_call = "wu-blastall -p tblastx -d /data/genomes/dna/$g -i $b -m 8 -e E-3";
	#run process with system for each sequence of interest for each genome.
	system($system_call);
    }
}
