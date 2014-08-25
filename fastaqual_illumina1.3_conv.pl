#!/usr/bin/perl/

############################
#This program will take in a .qual file with phred scores and a .fasta files with sequences and convert them into a .fastq file in Illumina 1.3 format. The Illumina 1.3 format encodes a Phred quality score from 0 to 40 using ASCII 64 to 104. (http://en.wikipedia.org/wiki/FASTQ_format)
############################


use strict;
use Bio::SeqIO;
use Data::Dumper;

#input .fasta file
my $fasta = $ARGV[0];

#input .qual file
my $qual = $ARGV[1];

my %fasta;
my %qual;

#my $in_fasta = Bio::SeqIO->new(-file => "$fasta", -format => 'Fasta');

#while(my $fas = $in_fasta->next_seq())
#{
#    print $fas->id, "\n";
#    print $fas->seq(),"\n";
#    $fasta{$fas->id} = $fas->seq();
#}

#print Dumper(%fasta);

my $in_qual = Bio::SeqIO->new(-file => "$qual", -format => 'qual');

while(my $quality = $in_qual->next_seq())
{
#    print $quality->id, "\n";
    my @quals = @{$quality->qual};
#    print join("\t",@quals), "\n";
    $qual{$quality->id} = [@quals];
}

#print Dumper(%qual);

foreach my $x (keys %qual) 
{
    my @ascii_score;
#    print join(" ",@{$qual{$x}}),"\n";
    my @q_score = @{$qual{$x}};
    foreach my $y (@q_score)
    {
	my $new_score = $y + 64;
#	print chr($new_score),"\n";
	push (@ascii_score, chr($new_score));
    }

#    print "@",$x, "\n";
#    print $fasta{$x},"\n";
    print "+", $x, "\n";
    print join("",@ascii_score), "\n";


}

#print Dumper(@ascii_scores);
 
