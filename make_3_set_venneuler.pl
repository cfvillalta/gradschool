#! /usr/bin/perl -w

use Data::Dumper;
use strict;

#want to put in 4 datasets with a line equal to one object in a dataset.


#input 4 files and they will be A,B,C,D

my $file_a= $ARGV[0];
my $file_b= $ARGV[1];
my $file_c= $ARGV[2];


#open the files;
open(FILEA,$file_a);
open(FILEB,$file_b);
open(FILEC,$file_c);


#make arrays for each file with each object a string in the array.

my @a;
my @b;
my @c;


while(my $file_A = <FILEA>)
{
    chomp($file_A);
    if($file_A =~ m/NCU/)
    {
	push(@a,$file_A);
    }	
}

while(my $file_B = <FILEB>)
{
    chomp($file_B);
    if($file_B =~ m/NCU/)
    {
	push(@b,$file_B);
    }	
}

while(my $file_C = <FILEC>)
{
    chomp($file_C);
    if($file_C =~ m/NCU/)
    {
	push(@c,$file_C);
    }	
}

close(FILEA);
close(FILEB);
close(FILEC);

#lists for which I need to determine amount.
my $A;
my $B;
my $C;
my $AB;
my $AC;
my $BC;
my $ABC;

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

#Determine how many in C

$y=0;

foreach my $obj_c(@c)
{
    $y++;
}

$C = $y;

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

#Determine how many AC
$y=0;
my @ac;
foreach my $obj_a(@a)
{
    foreach my $obj_c(@c)
    {
	if($obj_a eq $obj_c)
	{
	    push(@ac, $obj_a);
	    $y++;
	}
    }
}

$AC=$y;

#Determine how many BC
$y=0;
my @bc;
foreach my $obj_b(@b)
{
    foreach my $obj_c(@c)
    {
	if($obj_b eq $obj_c)
	{
	    $y++;
	    push(@bc,$obj_b);
	}
    }
}
$BC=$y;

#Determine how many ABC
$y=0;
my @abc;
foreach my $obj_ab(@ab)
{
    foreach my $obj_c(@c)
    {
	if($obj_ab eq $obj_c)
	{
	    $y++;
	    push(@abc,$obj_ab);
	}
    }
}

$ABC=$y;

#print everything out to check that it worked.
my $ABC1 = $ABC;
my $AB1 = $AB-$ABC1;
my $AC1 = $AC-$ABC1;
my $BC1 = $BC-$ABC1;
my $A1 = $A-($AB1+$AC1+$ABC1);
my $B1 = $B-($AB1+$BC1+$ABC1);
my $C1 = $C-($AC1+$BC1+$ABC1);

print "A\t$A\n";
print "B\t$B\n";
print "C\t$C\n";
print "AB\t$AB\n";
print "AC\t$AC\n";
print "BC\t$BC\n";
print "ABC\t$ABC\n";


print "A\t$A\n";
print join("\n",@a),"\n";
print "B\t$B\n";
print join("\n",@b),"\n";
print "C\t$C\n";
print join("\n",@c),"\n";
print "AB\t$AB\n";
print join("\n",@ab),"\n";
print "AC\t$AC\n";
print join("\n",@ac),"\n";
print "BC\t$BC\n";
print join("\n",@bc),"\n";
print "ABC\t$ABC\n";
print join("\n",@abc),"\n";

#abc1
my @abc1 = @abc;

#bc1
my @bc1;
my @not_bc1;
my %seen_bc1;
push(@not_bc1,@abc1);

if(($ABC1) eq 0)
{
    @bc1 = @bc;
}
elsif(($ABC1) gt 0)
{
    foreach my $obj_NOTBC1(@not_bc1)
    {
        $seen_bc1{$obj_NOTBC1}=1;
    }
    foreach my $obj_BC(@bc)
    {
        unless($seen_bc1{$obj_BC})
        {            push(@bc1, $obj_BC);
		 }
    }
}


#ac1
my @ac1;
my @not_ac1;
my %seen_ac1;
push(@not_ac1,@abc1);

if(($ABC1) eq 0)
{
    @ac1 = @ac;
}
elsif(($ABC1) gt 0)
{
    foreach my $obj_NOTAC1(@not_ac1)
    {
        $seen_ac1{$obj_NOTAC1}=1;
    }
    foreach my $obj_AC(@ac)
    {
        unless($seen_ac1{$obj_AC})
        {
            push(@ac1, $obj_AC);  
        }
    }
}


#ab1
my @ab1;
my @not_ab1;
my %seen_ab1;
push(@not_ab1,@abc1);


if(($ABC1) eq 0)
{
    @ab1 = @ab;
}
elsif(($ABC1) gt 0)
{
    foreach my $obj_NOTAB1(@not_ab1)
    {
        $seen_ab1{$obj_NOTAB1}=1;
    }
    foreach my $obj_AB(@ab)
    {
        unless($seen_ab1{$obj_AB})
        {    
            push(@ab1, $obj_AB);
        }
    }
}

#c1
my @c1;
my @not_c1;
my %seen_c1;
@not_c1=(@ac1,@bc1,@abc1);

if(($AC1+$BC1+$ABC1) eq 0)
{
    @c1 = @c;
}
elsif(($AC1+$BC1+$ABC1) gt 0)
{ 
    foreach my $obj_NOTC1(@not_c1)
    {
        $seen_c1{$obj_NOTC1}=1;
    }
    foreach my $obj_C(@c)
    {
        unless($seen_c1{$obj_C})
        {
            push(@c1, $obj_C);
        }
    }
}

#b1
my @b1;
my @not_b1;
my %seen_b1;
@not_b1=(@ab1,@bc1,@abc1);

if(($AB1+$BC1+$ABC1) eq 0)
{
    @b1 = @b;
}
elsif(($AB1+$BC1+$ABC1) gt 0)
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
@not_a1=(@ab1,@ac1,@abc1);

if(($AB1+$AC1+$ABC1) eq 0)
{
    @a1 = @a;
}
elsif(($AB1+$AC1+$ABC1) gt 0)
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


print "A1\t$A1\n";
print "B1\t$B1\n";
print "C1\t$C1\n";
print "AB1\t$AB1\n";
print "AC1\t$AC1\n";
print "BC1\t$BC1\n";
print "ABC1\t$ABC1\n";

print "A1\t$A1\n";
print join("\n",@a1),"\n";
print "B1\t$B1\n";
print join("\n",@b1),"\n";
print "C1\t$C1\n";
print join("\n",@c1),"\n";
print "AB1\t$AB1\n";
print join("\n",@ab1),"\n";
print "AC1\t$AC1\n";
print join("\n",@ac1),"\n";
print "BC1\t$BC1\n";
print join("\n",@bc1),"\n";
print "ABC1\t$ABC1\n";
print join("\n",@abc1),"\n";


print "A\t$A\n";
print "B\t$B\n";
print "C\t$C\n";
print "AB\t$AB\n";
print "AC\t$AC\n";
print "BC\t$BC\n";
print "ABC\t$ABC\n";
print "\n";
print "A1\t$A1\n";
print "B1\t$B1\n";
print "C1\t$C1\n";
print "AB1\t$AB1\n";
print "AC1\t$AC1\n";
print "BC1\t$BC1\n";
print "ABC1\t$ABC1\n";

#print "X\t$x\n";
#print "A1\t$A1\n";
#print join("\n",@a1),"\n";
open(A1,">A1.ncu");
print A1 join("\n",@a1),"\n";
close(A1);

#print "B1\t$B1\n";
#print join("\n",@b1),"\n";
open(B1,">B1.ncu");
print B1 join("\n",@b1),"\n";
close(B1);

#print "C1\t$C1\n";
#print join("\n",@c1),"\n";
open(C1,">C1.ncu");
print C1 join("\n",@c1),"\n";
close(C1);

#print "AB1\t$AB1\n";
#print join("\n",@ab1),"\n";
open(AB1,">AB1.ncu");
print AB1 join("\n",@ab1),"\n";
close(AB1);

#print "AC1\t$AC1\n";
#print join("\n",@ac1),"\n";
open(AC1,">AC1.ncu");
print AC1 join("\n",@ac1),"\n";
close(AC1);



#print "BC1\t$BC1\n";
#print join("\n",@bc1),"\n";
open(BC1,">BC1.ncu");
print BC1 join("\n",@bc1),"\n";
close(BC1);



#print "ABC1\t$ABC1\n";
#print join("\n",@abc1),"\n";
open(ABC1,">ABC1.ncu");
print ABC1 join("\n",@abc1),"\n";
close(ABC1);


