#!/usr/bin/perl/


use strict;
use Bio::SeqIO;
use Data::Dumper;

sub zup 
{ 
    join "\n" => map {join "\n" => map {shift@$_} @_} @{$_ [0]};  
} 

#input .fasta file                                                              
my $fasta = $ARGV[0];

#input .qual file                                                               
my $qual = $ARGV[1];

my %fasta;
my %qual;

open(FASTA, $fasta);

open(QUAL, $qual);

my @quality;
my @quality_id;

my $join;

while(my $quals = <QUAL>)
{
    if($quals =~ m/>(.+)/)
    {
        push(@quality_id,"+".$1);
    }
    elsif($quals =~ m/(\d\d\s.+)/)
    {
	my @all_quals;
	push(@all_quals, $quals);
	my @quals_split = split(" ",$quals);
#	print @quals_split, "\n";
	foreach my $score (@all_quals)
	{
#	    print $score;
	    my @score = split(" ",$score);
	    my @quals_ascii; 
	    foreach my $x (@score)
	    {
	#	my @quals_ascii;
#		print $x;
		my $score_ascii = chr($x + 64);
	#	print $score_ascii;
		push(@quals_ascii, $score_ascii);
	#	print join("",@quals_ascii);
	    }	    
	    $join = join("",@quals_ascii), "\n";
	    #print $join, "\n";
	    push(@quality, $join);
	}

#	print join(" ",@quals_split), "\n"; 
#        push(@quality, $1);
    }

}

my @fasta_seq;
my @fasta_id;


while(my $fas = <FASTA>)
{
    if($fas =~ m/>(.+)/)
    {
	push(@fasta_id, "@".$1);
	
    }
    elsif($fas =~ m/(\w+)/)
    {
	push(@fasta_seq, $1);
    }
    
}
my $fastq =  zup \(@fasta_id, @fasta_seq, @quality_id, @quality);
print $fastq;

