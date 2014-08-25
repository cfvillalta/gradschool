 #! /usr/bin/perl -w

use Data::Dumper;
use strict;

#want to put in 4 datasets with a line equal to one object in a dataset.


#input 4 files and they will be A,B,C,D

my $file_a= $ARGV[0];
my $file_b= $ARGV[1];

print "$file_a\n$file_b\n";

#open the files;
open(FILEA,$file_a);
open(FILEB,$file_b);


#make arrays for each file with each object a string in the array.

my @a;
my @b;


while(my $file_A = <FILEA>)
{
    chomp($file_A);
   # if($file_A =~ m/NCU/)
    #{
	push(@a,$file_A);
#    }	
}

while(my $file_B = <FILEB>)
{
    chomp($file_B);
 #   if($file_B =~ m/NCU/)
  #  {
	push(@b,$file_B);
   # }	
}



close(FILEA);
close(FILEB);


#lists for which I need to determine amount.
my $A;
my $B;
my $AB;







#Determine how many in A

my $y=0;

foreach my $obj_a(@a)
{
    $y++;
}

$A = $y;

#Determine how many in B

$y=0;

foreach my $obj_b(@b)
{
    $y++;
}

$B = $y;


#Determine how many AB

my @ab;

$y=0;

foreach my $obj_a(@a)
{
    foreach my $obj_b(@b)
    {
	if($obj_a eq $obj_b)
	{
	    push(@ab, $obj_a);
	    $y++;
	}
    }
}



$AB=$y;



#print everything out to check that it worked.


my $AB1 = $AB;

my $A1 = $A-($AB1);
my $B1 = $B-($AB1);


print "A\t$A\n";
print join("\n",@a),"\n";
print "B\t$B\n";
print join("\n",@b),"\n";

print "AB\t$AB\n";
print join("\n",@ab),"\n";


#ab1
my @ab1=@ab;




#b1
my @b1;
my @not_b1;
my %seen_b1;
@not_b1=(@ab1);

if(($AB1) eq 0)
{
    @b1 = @b;
}
elsif(($AB1) gt 0)
{ 
    foreach my $obj_NOTB1(@not_b1)
    {
	$seen_b1{$obj_NOTB1}=1;
    }
    foreach my $obj_B(@b)
    {
	unless($seen_b1{$obj_B})
	{
	    push(@b1, $obj_B);
	}
    }
}

#a1
my @a1;
my @not_a1;
my %seen_a1;
@not_a1=(@ab1);

if(($AB1) eq 0)
{
    @a1 = @a;
}
elsif(($AB1) gt 0)
{ 
    foreach my $obj_NOTA1(@not_a1)
    {
	$seen_a1{$obj_NOTA1}=1;
    }
    foreach my $obj_A(@a)
    {
	unless($seen_a1{$obj_A})
	{
	    push(@a1, $obj_A);
	}
    }
}

#print "X\t$x\n";
print "A1\t$A1\n";
print join("\n",@a1),"\n";
open(A1,">A1.ncu");
print A1 join("\n",@a1),"\n";
close(A1);

print "B1\t$B1\n";
print join("\n",@b1),"\n";
open(B1,">B1.ncu");
print B1 join("\n",@b1),"\n";
close(B1);



print "AB1\t$AB1\n";
print join("\n",@ab1),"\n";
open(AB1,">AB1.ncu");
print AB1 join("\n",@ab1),"\n";
close(AB1);

;

print "A1\t$A1\n";
print "B1\t$B1\n";

print "AB1\t$AB1\n";

