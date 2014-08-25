#! /usr/bin/perl -w

#want to input a readcount file with just bioreps with only genes with greater than 5 reads.

#will call on three perl programs for biorep comparison, pois to simulated data comparison, and negative bionomial comparison.

#programs output will tell if the data either is the same or if the model fits. Either be true or the number 1 for true. 

#output the type of test and whether it is true in tab delimited format and the sum of critical values and what the sig value would be for the hypothesis to be true (cutoff is 0.05).

use strict;
use Data::Dumper;
use Statistics::Descriptive;

opendir(DIR,".")|| die "can't opendir ".":$!";
my @files=readdir(DIR);
#print Dumper @files,"TEST\n";
closedir(DIR);

foreach my $readcount(@files)
{
    if($readcount !~ m/readcount_table/)
    {
	if($readcount =~ m/readcount.+\.dat/)
	{
	    print "#$readcount\n";
	    
	    open(RC,$readcount);
	    
	    system("cp $readcount readcount.dat");
	    system("R --no-save < poisson_chi_test_bioreps_fit.R > temp");
	    system("R --no-save < poisson_fit_bioreps.R > temp");
	    system("R --no-save < nb_fit_bioreps.R > temp");
	    
	    my $bioreps_fit = "pois_chi_compare_biorep.out";
	    my $pois_fit = "pois_chisqtest.out";
	    my $nb_fit = "nb_chisqtest.out";
	    

	    
	    my $header;
	    my @sample_id;
	    while(my $rc = <RC>)
	    {
		chomp($rc);
		if($rc =~ m/NCU_id\t(CV.+)/)
		{
		    $header=$rc;
		    @sample_id = split("\t",$1);
		}
		
	    }
	    
	    open(BIOREP,$bioreps_fit);
	    my $biofit_header;
	    
	    print "\#Poisson Distribution and Chi-Square test of Bioreps\n";
	    
	    while(my $biofit = <BIOREP>)
	    {
		chomp($biofit);
		if($biofit =~ m/crit_val_sum/)
		{
		    $biofit_header = $biofit;
		    print "ID\t$biofit\n";
		    
		}
		elsif($biofit =~ s/1\t/$sample_id[0]\_$sample_id[1]\t/)
		{
		    print $biofit,"\n";
		}
		elsif($biofit =~ s/2\t/$sample_id[0]\_$sample_id[2]\t/)
		{
		    print $biofit,"\n";
		}
		elsif($biofit =~ s/3\t/$sample_id[1]\_$sample_id[2]\t/)
		{
		    print $biofit,"\n";
		}
		
		
	    }
	    
	    open(POISFIT,$pois_fit);
	    
	    print "\n\#poisson_fit_test\n";
	    
	    while(my $pf = <POISFIT>)
	    {
		chomp($pf);
		if($pf =~ s/1\t/crit_val_sum\t/)
		{
		    print $pf,"\n";
		}
		elsif($pf =~ s/2\t/chisq_sig\t/)
		{
		    print $pf,"\n";
		}
		elsif($pf =~ s/3\t1/chitests\tTRUE/)
		{
		    print $pf,"\n";
		}
		elsif($pf =~ s/3\t0/chitests\tFALSE/)
		{
		    print $pf,"\n";
		}
	    }
	    
	    open(NBFIT,$nb_fit);

	    print "\n\#negative_binomial_fit_test\n";

	    while(my $nb = <NBFIT>)
	    {
		chomp($nb);
		if($nb =~ s/1\t/crit_val_sum\t/)
		{
		    print $nb,"\n";
		}
		elsif($nb =~ s/2\t/chisq_sig\t/)
		{
		    print $nb,"\n";
		}
		elsif($nb =~ s/3\t1/chitests\tTRUE/)
		{
		    print $nb,"\n";
		}
		elsif($nb =~ s/3\t0/chitests\tFALSE/)
		{
		    print $nb,"\n";
		}
	    }
	    close(RC);
	    print"\n";
	}
    }
}
