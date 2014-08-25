#!/usr/bin/perl

use strict;
use Bio::SeqIO;

my $protein_id = $ARGV[0];

my $prot_genomes = $ARGV[1];

my %seqeunces;
