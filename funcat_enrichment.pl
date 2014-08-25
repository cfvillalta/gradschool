#!/usr/bin/perl -w

use strict;

my $control = shift;
my $exper   = shift;
my $look    = shift; #FUNCAT SCHEME

my %CONtable;
my %EXPtable;
my %LOOKtable;
my %FUNtable;
my %annotated;
my $conTotal = 0;
my $expTotal = 0;


open(FUN,"FUNCAT\_table\_20110426\.dat");
while(my $line = <FUN>){
    chomp $line;
    my @array = split("\t",$line);
    next if $array[0] eq "LEVEL_1" && $array[1] == 99; #SKIP UNCLASSIFIED PROTEINS
    $FUNtable{$array[0]}{$array[1]} = $array[2];
    my @genes = split(",",$array[2]);
    foreach my $element (@genes){
	$annotated{$element}++;
    }
}
close(FUN);

open(CON,$control);
while(my $line = <CON>){
    chomp $line;
    if(exists $annotated{$line}){
	$CONtable{$line}++;
    }
}
close(CON);
$conTotal = scalar(keys %CONtable);

open(EXP,$exper);
while(my $line = <EXP>){
    chomp $line;
    if(exists $annotated{$line}){
	$EXPtable{$line}++;
    }
}
close(EXP);
$expTotal = scalar(keys %EXPtable);

open(LK,$look);
while(my $line = <LK>){
    chomp $line;
    $line =~ m/([0-9\.]+)\s(.+)$/;
    my $num = $1;
    my $funct = $2;
    $funct =~ s/\W+/_/g;
    $LOOKtable{$num} = $funct;
}
close(LK);


foreach my $level (sort keys %FUNtable){
    open(OUT,">","R.in");
    foreach my $cat (sort keys %{$FUNtable{$level}}){
        my @NCUs = split(",",$FUNtable{$level}{$cat});
	my $category = $LOOKtable{$cat};
	#print $cat,"\t",$category,"\n";
	$category =~ s/\s/_/g;
	my $control=0;
	my $experiment=0;
	foreach my $cat_gene (@NCUs){
	    #print $cat,"_",$category,"\t",$cat_gene,"\n";
	    if(exists $CONtable{$cat_gene}){
		$control++;
	    }
	    if(exists $EXPtable{$cat_gene}){
		$experiment++;
		#print $cat_gene,"\n";
	    }
	}
	next if $control==0;
	next if $experiment<=1;
	
#       x: vector of quantiles representing the number of white balls drawn without replacement from an urn which contains both black and white balls.
#	   AKA the number of genes from the experiment that are in this FUNCAT
#       m: the number of white balls in the urn
#          AKA the number of genes in the control that are in this FUNCAT
#       n: the number of black balls in the urn.
#          AKA the number of genes in the control that are NOT in this FUNCAT
#       k: the number of balls drawn from the urn.
#          AKA the number of genes in the experiment
	my $x = $experiment-1;
	my $m = $control;
	my $n = $conTotal - $control;
	my $k = $expTotal;
	print OUT $cat,"_",$category,"\t",$x,"\t",$m,"\t",$n,"\t",$k,"\n";
#	print $cat,"_",$category,"\t",$x,"\t",$m,"\t",$n,"\t",$k,"\n";
    }
    close(OUT);
    next unless -s "R.in";
    system("R --no-save < phyper.R > temp");
    print $level,"\n";
    system("cat R.out");
}
