#!/usr/bin/perl -w

use strict;
use Bio::DB::SeqFeature::Store;

#gbrowse runs off of a mysql database and this script uses a bioperl
#method that lets you interface with that database. Because we have 
#gbrowse running for NcraOR74A we already have
#all the genomic features of NcraOR74A loaded into the DB, so it is 
#easy to specify a genomic region and query the DB to determine if 
#there are any features that overlap the given region. In this case, the 
#genomic position is the location of a SNP and we are specifcally querying
#for any NCU genes that overlap that position.

#This is mysql DB connection mumbo jumbo
my($user,$pass,$dbname,$host) = ('gbUser','gBr0wse',
                                 'gb_neurospora_crassa_SOL',
                                 'fungalgenomes.org');

my $gffdb = Bio::DB::SeqFeature::Store->new(-adaptor=>'DBI::mysql',
                              -dsn   => "dbi:mysql:database=$dbname",
                              -user  => $user,
                              -password  => $pass,
                              );
my $snp_calls = shift;
my $counts    = shift;
my %count_hash;

#create the SNP and EXPRESSION table files to write to
open(SNP,">","WGA_SNP_cisINPUT.dat");
open(EXP,">","WGA_EXP_cisINPUT.dat");

#OPEN THE PRE_EXISTING EXPRESSION FILE
open(RCOUNT,$counts);
while(my $line = <RCOUNT>){ #LOOP THROUGH LINE_BY_LINE
    chomp $line;
    next if $line =~ m/^\#/;
    my @line_array = split("\t",$line);
    my $NCU = $line_array[0];
    $count_hash{$NCU}=$line; #CREATE A HASH WHERE NCUids ARE KEYS AND THE ENTIRE LINE IS THE VALUE
}

open(SNP,$snp_calls);#OPEN THE PRE_EXISTING SNP FILE
while(my $line = <SNP>){
    chomp $line;
    next if $line =~ m/^\#/;
    $line =~ m/(Ncra.+contig7\.\d+)_(\d+)/;#EXTRACT THE CONTIG AND COORDINATE INFO
    my $contig = $1;
    my $pos    = $2;
    my $segment = $gffdb->segment($contig, $pos => $pos);#SPECIFY A GENOMIC REGION
    my @genes   = $segment->features('gene:NCBI_PASA_allnames');#ADD ANY FEATURES FROM THE CATEGORY gene:NCBI_PASA_allnames TO THE ARRAY @genes IF THEY OVERLAP THE GIVEN SEGMENT
    if (defined $genes[0]){#IF THERE ARE ANY FEATURES IN THE ARRAY
        foreach my $element (@genes){
	    my $id = $element->name();#GET THEIR ID
	    print SNP $line,"\n";#PRINT THE SNP LINE TO THE SNP FILE
	    print EXP $count_hash{$id},"\n";#PRINT THE EXP LINE FOR THE NCU THAT CORRESPONDS TO THE GENE THAT OVERLAPS THE GIVEN SNP
	}
    }
}
