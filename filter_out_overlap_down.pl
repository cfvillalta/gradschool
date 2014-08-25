#! /usr/bin/perl -w

use strict;

use Data::Dumper;

use Statistics::Descriptive;

my $readcount = $ARGV[0];

my $header;
my @sample_id;
my %cond_1_hash;
my %cond_2_hash;
my @ncu_id;

open(RC,$readcount);

while(my $rc = <RC>)
{

    chomp($rc);
    
    if($rc =~ m/NCU_id\t(CV.+)/)
    {
	$header = $rc;
	@sample_id = split("\t",$1);
    }

    else
    {
	my @counts_array = split("\t",$rc);

	push(@ncu_id, $counts_array[0]);
	
	my @cond_1 = ($counts_array[1],$counts_array[2],$counts_array[3]);
	my @cond_2 = ($counts_array[4],$counts_array[5],$counts_array[6]);
	$cond_1_hash{$counts_array[0]}=[@cond_1];
	$cond_2_hash{$counts_array[0]}=[@cond_2];
    }
}


my @list_ids;

foreach my $id(@ncu_id)
{
   my $cond_1 = $cond_1_hash{$id};
   my $cond_2 = $cond_2_hash{$id};

   my @cond_1 = @$cond_1;
   my @cond_2 = @$cond_2;

   foreach my $condition1(@cond_1)
   {
       foreach my $condition2(@cond_2)
       {
	   if($condition1 <= $condition2)
	   {
	       push(@list_ids,$id);
	      # print $id,"\n";
	      # print $condition1,"\t", $condition2,"\n";
	      # print join("\t",@cond_1),"\n";
	      # print join("\t",@cond_2),"\n";
	   }
       }
   }
}

my %seen;

foreach my $i (@list_ids)
{
    if($seen{$i})
    {
	my $new_num = ($seen{$i} + 1);
	$seen{$i}=$new_num;
    }
    unless($seen{$i})
    {
	$seen{$i} = 1;
    }
}
#print Dumper %seen;
foreach my $ids(keys %seen)
{
  #  if(int($seen{$ids}) >= 3)
  #  {
	print $ids, "\n";
  #  }
}
