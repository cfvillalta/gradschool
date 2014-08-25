#!/usr/bin/perl -w
#This script parses the 8th column of the mosaik SNP GFF3 file to 1.determine
#if the site is bi-allelic and 2.extract the genotype information for each strain
#The genotype info is then output in table form where each row is a SNP position 
#and each column is the allele for a given strain at that position

#USAGE: perl mosaik_parseSNPfile.pl /PATH/TO/SNP/GFF N where 
# N= number of strains used in analysis, including the reference 

use strict;

my $gff = shift;
my $number_of_strains = shift; #including reference
my %allele_count;
my %genotype_table;

my $line_count=0;
open(SNP,$gff);
while(my $line = <SNP>){#LOOP THROUGH SNP GFF LINE_BY_LINE
    next if $line =~ m/^\#/;#SKIP LINES THAT STAR WITH POUND
    next if $line =~ m/INDEL/;#SKIP INDELS
    chomp $line;
    my ($contig,$source,$method,$start,
	$end,$strand,$score,$phase,$notes)=split("\t",$line);#SPLIT LINE ON TABS
    my $pos = $contig."_".$start;#CREATE AN ID THAT COMBINES CONTIG WITH COORDINATE
    $notes =~ m/individualGenotypes=(.+?)\;/;#EXTRACT GENOTYPE SECTION OF COLUMN 8
    my @genotypes = split(',',$1);#SPLIT THAT SECTION ON COMMAS
    my $total = 0;
    foreach my $type (@genotypes){#LOOP THROUGH GENOTYPE FOR EACH STRAIN
	$type =~ m/(.+?)_.+?\:(.)/;#EXTRACT STRAIN ID AND ALLELE
	my $strain = $1;
	my $allele = $2;
	$allele_count{$allele}++;#KEEP NUMBER OF DIFFERENT ALLELES
	$genotype_table{$strain}=$allele;#STORE STRAIN GENOTYPE IN A HASH
	$total++;
    }
    my $count=0;
    foreach my $key (keys %allele_count){
	if($allele_count{$key}>=($total/4)){#MAKE SURE MINOR ALLELE FREQ IS >=.25
	    $count++;
	}
    }
    if($count==2 && $total==$number_of_strains){#IF BI_ALLELIC & ALL STRAINS ARE REPRESENTED
	$line_count++;
	if($line_count==1){
	    my @strains = sort keys %genotype_table;#PRINT OUT HEADER SPECIFYING STRAIN IDs FOREACH COLUMN
	    print "#position\t",join("\t",@strains),"\n";
	}
	print $pos,"\t";
	foreach my $strain (sort keys %genotype_table){#SORT HASH BY STRAIN ID TO KEEP THINGS IN THE RIGHT ORDER
	    print $genotype_table{$strain},"\t";#PRINT THEM OUT
	}
	print "\n";
    }
    %genotype_table=();#CLEAR THE HASHES
    %allele_count  =();
}

