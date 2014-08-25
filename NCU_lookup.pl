#!/usr/bin/perl

use strict;
use warnings;

my @NCUid = <STDIN>;

my $lookup_table = "/home/cvillalta/Neurospora_LEEDS_names.txt";

for (my $i=0;$i<scalar(@NCUid);$i++){
    chomp $NCUid[$i];
    #print "grep \'$NCUid[$i]\' $lookup_table\n";
    system("grep -w \'$NCUid[$i]\' $lookup_table");
#    print "____________________________________________________________________________________\n";
}
