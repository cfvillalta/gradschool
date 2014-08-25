#will have a column with NCUid, cond1,cond2,cond3,cond4
#will input a fasta file with AA as the trends for each NCU for each condition. 
use Data::Dumper;
use strict;

my $input_trend = $ARGV[0];

open(INPUT, $input_trend);

while(my $in=<INPUT>)
{
    chomp($in);
    
