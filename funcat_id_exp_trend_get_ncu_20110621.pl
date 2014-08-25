#! /usr/bin/perl -w


use strict;
use Data::Dumper;

#input funcat_table. split by line then by funcat term.
my $funcat_table = $ARGV[0];
#need trend and NCU from allDE files
my $NCU_trend= $ARGV[1];
#need trend and funcat from funcat file 
my $trend_funcat=$ARGV[2];
#will need to input in three files.

open(FT, $funcat_table);
open(NT, $NCU_trend);
open(TF, $trend_funcat);

