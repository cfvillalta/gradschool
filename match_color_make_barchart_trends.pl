#! /usr/bin/perl -w

use Data::Dumper;
use strict;
#input in trend table
my $table_in = $ARGV[0];
my $colors = $ARGV[1];



open(TABLE, $table_in);
open(COLORS, $colors);
my $table;

if($table_in =~ m/(.+)\..+/)
{
    $table=$1;
}
#print $table,"\n";

my @trend;
while(my $t = <TABLE>)
{
    chomp($t);
   
    my @t_array = split("\t", $t);
    push(@trend, $t_array[0]);
    
}
my %color_key;
while(my $c = <COLORS>)
{
    chomp($c);
    my @c_array = split("\t",$c);
    $color_key{$c_array[0]}=$c_array[1];
}

my @chart_color;
foreach my $x(@trend)
{
    print "$x\t$color_key{$x}\n";
    push(@chart_color,$color_key{$x});
}

my $color_in = join(",",@chart_color);
my $color_in_rev =  join(",",reverse(@chart_color));

open (B, ">make_barchart.R");

print B "rm(list=ls())\n";

print B "pdf\(file\=\"$table.pdf\"\)\n";
print B "c\=colors\(\)\[c\($color_in\)\]\n";
print "c\=colors\(\)\[c\($color_in\)\]\n";
print B "x\=read.table\(\"$table_in\"\,sep\=\"\\t\",row.names\=1,header\=FALSE\)\n";
print B "y\=t\(x\)\n";
print B "par\(xpd\=T\, mar\=par\(\)\$mar\+c\(0\,0\,0\,4\)\)\n";
print B "barplot\(t\(y\)\,col\=c\,names\.arg\=c\(\"NcA1\"\,\"NcA2\"\,\"NcC\"\,\"Nd\"\)\,space\=0.1\,cex.axis\=0.8\,las\=1\,ylim\=c\(0\,100\)\)\n";
print B "legend\(5\,100\,row.names\(x\)\,cex\=0.8\,fill\=c\)\n";
print B "box\(\)\n";
print B "dev.off\(\)\n";
print B "rm(list = ls())\n";

system("R \-\-no\-save \<make_barchart.R\> temp");

#print "R \-\-no\-save \<make_barchart.R\> temp";
#rev
system("sort -r $table_in> $table\_rev.in");
open (B, ">make_barchart_rev.R");

print B "pdf\(file\=\"$table\_rev.pdf\"\)\n";
print "c\=colors\(\)\[c\($color_in_rev\)\]\n";
print B "c\=colors\(\)\[c\($color_in_rev\)\]\n";
print B "x\=read.table\(\"$table\_rev.in\"\,sep\=\"\\t\",row.names\=1,header\=FALSE\)\n";
print B "y\=t\(x\)\n";
print B "par\(xpd\=T\, mar\=par\(\)\$mar\+c\(0\,0\,0\,4\)\)\n";
print B "barplot\(t\(y\)\,col\=c\,names\.arg\=c\(\"NcA1\"\,\"NcA2\"\,\"NcC\"\,\"Nd\"\)\,space\=0.1\,cex.axis\=0.8\,las\=1\,ylim\=c\(0\,100\)\)\n";
print B "legend\(5\,100\,row.names\(x\)\,cex\=0.8\,fill\=c\)\n";
print B "box\(\)\n";
print B "dev.off\(\)\n";
print B "rm(list = ls())\n";

system("R \-\-no\-save \<make_barchart_rev.R\> temp");
