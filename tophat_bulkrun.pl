#!/usr/bin/perl -w

#This is a simple wrapper for tophat that makes it easy to run many lanes
#of data in batch. Execute the script inside a directory that contains
#gzipped fastq files and it will unzip each file, map the reads, rename the 
#coverage.wig with the strain ID, move it into a seperate folder, and
#recompress the fastq file when it is done. Using this script in combination
#with tophat_bulkcoverage will give you a tab delimited output with genes
#as rows and raw read counts for each individual as columns, which can
#be used as input to the glm analysis in R.
#Right now the parameters are hard-coded into the tophat system call. 
#To make it easier to change them, someday I might make each 
#parameter a variable.

#USAGE: perl tophat_bulkrun.pl /PATH/TO/GFF (for RPKMs & SPLICE JUNCTs) /PATH/TO/BOWTIE/INDEX

#NOTE: FASTQ FILES MUST END IN .fastq PLUS .gz IF GZIPPED

use strict;

my $gff_path   = $ARGV[0];
my $index_path = $ARGV[1];
my @fastq;
my %strain;

opendir(DIR,".") || die "can't opendir ".": $!";
my @files = readdir(DIR);
closedir(DIR);

#ORGANIZE FILES
system("mkdir log");
system("mkdir coverage");
foreach my $element (@files){
    if($element =~ m/(.+)\.fastq/){
        push(@fastq,$element);
        $strain{$element}=$1;
    }
}

foreach my $seq_file (@fastq){
    if($seq_file =~ m/.+\.gz|.+\.gzip/){
	print "UNZIPPING $seq_file\n";
	system("gunzip $seq_file");
    }
    my $basename= $strain{$seq_file};
    print "MAPPING $basename\n";
    system("nohup nice -n 19 time tophat -m 2 -i 40 -I 200 --solexa-quals -p 3 -G $gff_path -o $basename $index_path $basename.fastq >& log/$basename.tophat.out");
    system("echo 'tophat -m 2 -i 40 -I 200 --solexa-quals -p 3 -G $gff_path -o $basename $index_path $basename.fastq' > log/$basename.command");
    print "COMPRESSING $basename.fastq\n";
    system("gzip $basename.fastq");
    system("mv $basename/coverage.wig coverage/$basename.wig");
}

