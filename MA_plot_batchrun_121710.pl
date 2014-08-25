#Modified MA plot batch run that makes MA plots and their dat files but also makes an extra dat file with more data on it so I can compare counts to MA data..

#! /usr/bin/perl -w

system("mkdir  MA_plot_data_graphs_040411");

use strict;
use Data::Dumper;

use Statistics::Descriptive;

#number of reads for each lane of solexa data.
my $readcounts = $ARGV[1];

my $n_info = $ARGV[0];

open(READCOUNTS, $readcounts);

my @sample_id;
#080510 do not think i need this anymore.
my @counts;
my @rows;
my @reads_array;
my @NCUid;

while(my $counts = <READCOUNTS>)
{
    chomp($counts);
#Captured all the ids of each solexa run of data and put it into an array. 
    if($counts =~ m/NCU_id\t(CV.+)/)
    {
        @sample_id = split("\t",$1);    
    }

#if it wasnt the header line with all the array ids I captured the row name and hits into an array and put each of those arrays into an array. Also collected NCUids and put them into an array of just ids. 
    else
    {
        my @counts_array = split("\t", $counts);
#	Wanted to make my deaclared counts array have all the data of counts array for later in the script below when I need to count the number of genes in the table.
	@counts=@counts_array;
     #make an array of just NCUids.
	push(@NCUid, $counts_array[0]);
        push(@reads_array,[@counts_array]);
    }
}
#print @sample_id;
#print Dumper @reads_array;
#print  @counts;

#Will fill %j_hits with hash of arrays where the key is the sample # and the values are an array of hits in the order of the tab delmited file. 
my %j_hits;
#number of samples we have in the readcount file. 
my @num_of_samples;
for(my $j = 0; $j < @counts; $j++)
#counts the number of samples and runs the loop until the last sample in @counts is reached. 
{
 #   print $j,"\n";
#makes sure I do not include the NCU id as part of one of my arrays of counts within the hash.
    if($counts[$j] !~ m/NCU/)
    {
	#getting each row of data from reads array as a string. 
        foreach my $gene(@reads_array)
        {
	    #turn it into an array with the gene
            my @gene_array = @$gene;
	    
            #print $gene, "\n";

#allows me to ignore the header line.
            if( $gene_array[$j] !~ m/CV/)
            {
	#	I push the array of different reads into my hash that is numbered according to sample position in the tab delimited file. 
                push(@{$j_hits{$j}},$gene_array[$j]);
            }
        }
#make an array of numbers each one referencing a lane/column of counts. 
        push(@num_of_samples,$j);
    }
    
}
#print Dumper @num_of_samples;
#print Dumper %j_hits;

#the number of reads in each lane of data.
my %totals;

foreach my $hits (keys %j_hits)
{
    my $jh = $j_hits{$hits};


#    print $jh;
#the array called up from the hash that has all the hits for a specific lane of data. 

    my $stat = Statistics::Descriptive::Full->new();
    $stat->add_data(@$jh);
    my $q3 = $stat->quantile(3);
    

#set my counter to zero.
#    my $total_hits = 0;


#    foreach my $hits_num(@$jh)
#    {
#	if($hits_num >= $q3)
#	{
#	    $total_hits += $hits_num;
#       print $hits,"\t",$hits_num,"\t",$total_hits,"\n";
 
#totals in here now has the q3 instead of the total gene counts above the q3.
   $totals{$hits} = $q3;
#       print $hits,"\t",$hits_num,"\t",$total_hits,"\n";
#	}
#    }
}

#print Dumper %totals;

open(NI, $n_info);

#my @every_condition;
my %sample_cond;
my @every_sample;
while( my $n_info = <NI>)
{    
    chomp($n_info);    
    if($n_info !~ m/Biorep/)    
    {        
	my @n_info_split = split("\t",$n_info);
#        my $biorep_num = $n_info_split[1];        
	my $file_name = $n_info_split[0];        
#	my $condition = $n_info_split[4];
	#print $biorep_num,"\t",$file_name,"\t",$condition,"\n";
	push(@every_sample, $file_name);
    }
}

#print Dumper @every_sample;
my @all_samples;
foreach my $sample(@every_sample)
{
    foreach my $sample_2(@every_sample)
    {
	if($sample ne $sample_2)
	{
	    my @sample_array = [$sample, $sample_2];
	   # print @sample_array,"\n";
	    push(@all_samples,@sample_array);
	}
    }
}

#print Dumper @all_samples;



my %seen;
my @unique_conditions;
foreach my $cond(@all_samples)
{
 #   print $cond;
    my @cond_array = sort(@$cond);
    #print @cond_array;
    my $condition = join("\t", @cond_array);
 #   print $condition,"\n";
    unless($seen{$condition})    
    {        
	push(@unique_conditions, $condition);
	$seen{$cond} = 1;    
    }
}
#hits_2 is the number assigned to each sample like 1,2,3,...
my %norm_hits_all;
my $k = 0;
foreach my $hits_2 (keys %j_hits)
{
  #  print $hits_2,"\n";
    
    my $jh_2 = $j_hits{$hits_2};
    #print  $jh_2,"\n";

    $k=0;

    foreach my $hits_num_2(@$jh_2)
    {
        $k++; 
        
        my %placement_normhits;

        my $totals_2 = $totals{$hits_2};
        
        my $hits_norm = ($hits_num_2/$totals_2);

        $placement_normhits{$k} = $hits_norm;

        #my @placement_normhits = ($k,$hits_norm);

        push(@{$norm_hits_all{$hits_2}},$hits_norm);
#       print $k,"\t";
#       print $hits_2,"\t";
#       print $hits_num_2,"\t";
#       print $totals_2,"\n";
    }
    
   
}

#print Dumper %norm_hits_all;
my @numbers = (1..$k);


my %samp_num;
foreach my $x (@num_of_samples)
{
#    print $x,"\n";
    $samp_num{$sample_id[$x-1]}= $x;
}
#print Dumper %samp_num;

foreach my $each(@unique_conditions)
{
    print $each,"\n";
    my @each_split = split("\t", $each);
 #   print $each_split[0],"\n";

    open(MA, ">MA_R.input");
    open(DAT, ">MA_plot_data_graphs_040411/$each_split[0]\_$each_split[1]_reads.dat");
    print DAT "NCUid\tM_y\tA_x\t$each_split[0]\t$each_split[1]\t$each_split[0]\_norm\t$each_split[1]\_norm\n";

    my $sample1 = $samp_num{$each_split[0]};
    print $sample1,"\n";
    my $sample2 = $samp_num{$each_split[1]};
    print $sample2,"\n";
    my $hits_hash_1 = $norm_hits_all{$sample1};
    my $hits_hash_2 = $norm_hits_all{$sample2};

    my $reads_hash_1 = $j_hits{$sample1};
    my $reads_hash_2 = $j_hits{$sample2};

    my @hits_array_1 = @$hits_hash_1;
    my @hits_array_2 = @$hits_hash_2;

    my @reads_array_1 = @$reads_hash_1;
    my @reads_array_2 = @$reads_hash_2;
    
    foreach my $row(@numbers)
    {
	 my $s1 = $hits_array_1[$row-1];
	 my $s2 = $hits_array_2[$row-1];
	 my $s1_b = $reads_array_1[$row-1];
	 my $s2_b = $reads_array_2[$row-1];
	 my $id = $NCUid[$row-1];
	 if($s1 && $s2 != 0)
	 { 
	     #on 12/02/10  reversed the subtraction on the $M part of the script.
	     #just normalize by 1000 because fixed 3q 040411
	     my $M = (log($s2)/log(2))-(log($s1)/log(2));
	     my $A = 0.5*((log($s1)/log(2)) + (log($s2)/log(2)));
	     my $s1_norm = int($s1*1000);
	     my $s2_norm = int($s2*1000);


	     print MA "$M\t$A\n";

	     print DAT "$id\t$M\t$A\t$s1_b\t$s2_b\t$s1_norm\t$s2_norm\n";
	 }
     }
    close(MA);
    close (DAT); 
    system("R --no-save < make_MA_plot_111710.R > temp");
    system("mv MA_R.out MA_plot_data_graphs_040411/$each_split[0]\_$each_split[1]\_MA.pdf");
    system("mv MA_R.input MA_plot_data_graphs_040411/$each_split[0]\_$each_split[1]\_MA.dat");
}




       

