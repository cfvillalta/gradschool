#!/usr/bin/perl

use strict;

#input a fasta file to split up and will output many smaller files with the  sequence name as the new file name. 

my $fasta_file = $ARGV[0];

#print $fasta_file;

open(FAS, $fasta_file);

my @fa_split;
my @seq;
while( my $fasta = <FAS>)
{
    @fa_split = split(">",$fasta);
    my $seq = join("",$fa_split[1],$fa_split[0]);
   # print $seq;
    push (@seq, $seq);
}


foreach my $s (@seq)
{
    my @s_split = split("\n", $s);
    print $fa_split[1];
    #print $s;
    open(OUT, '>', $s_split[1]); 
    #print OUT ">", $s;
    close(OUT);
}
