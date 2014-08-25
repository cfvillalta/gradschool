#!/usr/bin/perl -w

#This script should be run from a directory containing the coverage wig output 
#from tophat or from the tophat_bulkrun script. coverage.wig files should be renamed 
#so that they contain strain ID information. This script will use the read coverage info 
#along with gene coordinates from a gff file to calculate raw read counts for each gene.
#It will do this for every wig file in the current directory and output a table where
#every row is a gene id and columns contain read counts for every individual.
#NOTE: the entire wig file will be read into memory which may be a problem for low-memory machines

use strict;

my $gff = shift; #take in the path to the gene prediction GFF from the command line
#set/initilize some global variables here
my @wig;
my %coverage_hash;
my %NCU_table;
my $read_length = 36;
my %strain;
my @strains;

#open the current directory and put all the filenames in that directory into an array
opendir(DIR,".") || die "can't opendir ".": $!";
my @files = readdir(DIR);
closedir(DIR);

#sort through those filenames and keep all that end in .wig
#for those that do end in .wig, make a lookup table (hash) to use the filename to 
#get the strain ID (which should be everything before .wig)
foreach my $element (@files){
    if($element =~ m/(.+)\.wig/){
        push(@wig,$element);
        $strain{$element}=$1;
    }
}

#go through each coverage file one-by-one
foreach my $align (@wig){
    #get the strain_ID for the current file from the lookup table
    my $strain_ID=$strain{$align};
    #save it in an array to keep track of all strain_IDs
    push(@strains,$strain_ID);

    #open the coverage file and load it into a hash of arrays where each hash key is a contig 
    #whose value is an array. Each index of the array represents a base coordinate of that 
    #contig and the array element that corresponds to that index is the number of reads that 
    #overlap that base.
    open(AL,$align);
    while (my $line = <AL>){
        chomp $line;
        next if $line =~ m/^track/;
        my @line_array = split("\t",$line);
        my $contig = $line_array[0];
        for(my $i=$line_array[1];$i<$line_array[2];$i++){
            $coverage_hash{$contig}[$i] += $line_array[3];
        }
    }
    close(AL);

    #Now that the read coverage info for the entire genome is in memory, open the gene prediction GFF
    #and use the gene coordinates to lookup the corresponding read coverage for that region from the 
    #hash of arrays 
    open(GFF,$gff);
    while(my $line = <GFF>){
	next if $line =~ m/^\#/;
	chomp $line;
	my @line_array = split("\t",$line);
	next unless $line_array[2] eq "gene";
	#Get the contig and start/stop of the gene (including UTRs if annotated)
	my $contig = $line_array[0];
	my $start  = $line_array[3];
	my $stop   = $line_array[4];
	
	$line_array[8] =~ m/Name=(\w+)/;#Get the NCU id from the attributes column
	my $NCU = $1;
	my $read_depth=0;

	#Loop through every base in the region specified by the gene start/stop and sum the read depth
	#across the region
	for(my $i=$start;$i<=$stop;$i++){
	    next unless defined $coverage_hash{$contig}[$i];
	    $read_depth+=$coverage_hash{$contig}[$i];
	}
	#Because every read covers 36bp, divide the summed read depth by read length and round
	#to the nearest integer using sprintf. Store this number in a hash of hashes where the first key
	#is the gene ID whose value is another hash. The keys of this hash are strain IDs and their
	#values are the read counts
	$NCU_table{$NCU}{$strain_ID}=sprintf("%.0f",$read_depth/$read_length);

    }
    #clear the hash that contains the read coverage info to be ready for next file
    %coverage_hash=();
}

#open an output file to print to
open(OUT,">","readcount_table.dat");
#sort the strain IDs and print a header line for the subsequent read count columns
my @sorted = sort(@strains);
print OUT "#NCU_id\t",join("\t",@sorted),"\n";

#Iterate through the hash of hashes that contains the read counts
foreach my $gene (keys %NCU_table){
    #Initialize an array that will be used to hold the read counts for each strain
    my @hold=();
    #Get the keys of the first hash (the strain IDs), sort them so they are 
    #in the same order as the header line, and push the value of each one 
    #(the read counts) onto the @hold array
    foreach my $strain (sort keys %{$NCU_table{$gene}}){
	push(@hold,$NCU_table{$gene}{$strain});
    }
    #print the @hold array with a tab between each element
    print OUT $gene,"\t",join("\t",@hold),"\n";
}
close(OUT);
