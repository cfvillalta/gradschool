#!/usr/bin/perl

use strict;

my $tblastx = $ARGV[0];

my $genomes = $ARGV[1];

open(TBX, $tblastx);

open(GEN, $genomes);

my @tbx;
my @gen;
my %input;

while(my $tbx = <TBX>, my $gen = <GEN>)
{
    chomp($tbx);
    chomp($gen);
    
    $input{$tbx} = $gen;

}

foreach my $key (keys %input)
{
    my $x = $key."_". $input{$key};;
    
    my $run = "perl MAT/050409/get_seqs_from_tblastx.pl MAT/tblastx/$key /data/genomes/dna/$input{$key} >MAT/tblastx/$x.seqs";

    print $x, "\n";
	
    system($run);
}
    

