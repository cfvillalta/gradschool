#! /usr/bin/perl -w

use Data::Dumper;
use strict;

#want to put in 4 datasets with a line equal to one object in a dataset.


#input 4 files and they will be A,B,C,D

my $file_a= $ARGV[0];
my $file_b= $ARGV[1];
my $file_c= $ARGV[2];
my $file_d= $ARGV[3];

#open the files;
open(FILEA,$file_a);
open(FILEB,$file_b);
open(FILEC,$file_c);
open(FILED,$file_d);

#make arrays for each file with each object a string in the array.

my @a;
my @b;
my @c;
my @d;

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

while(my $file_D = <FILED>)
{
    chomp($file_D);
    if($file_D =~ m/NCU/)
    {
	push(@d,$file_D);
    }	
}

close(FILEA);
close(FILEB);
close(FILEC);
close(FILED);

#lists for which I need to determine amount.
my $A;
my $B;
my $C;
my $D;
my $AB;
my $AC;
my $AD;
my $BC;
my $BD;
my $CD;
my $ABC;
my $ABD;
my $ACD;
my $BCD;

my $ABCD;







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

#Determine how many in D

$y=0;

foreach my $obj_d(@d)
{
    $y++;
}

$D = $y;

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

#Determine how many AD
$y=0;

foreach my $obj_a(@a)
{
    foreach my $obj_d(@d)
    {
	if($obj_a eq $obj_d)
	{
	    $y++;
	}
    }
}

$AD=$y;

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

#Determine how many BD
$y=0;

foreach my $obj_b(@b)
{
    foreach my $obj_d(@d)
    {
	if($obj_b eq $obj_d)
	{
	    $y++;
	}
    }
}

$BD=$y;

#Determine how many CD
$y=0;

foreach my $obj_c(@c)
{
    foreach my $obj_d(@d)
    {
	if($obj_c eq $obj_d)
	{
	    $y++;
	}
    }
}

$CD=$y;

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

#Determine how many ABD
$y=0;

foreach my $obj_ab(@ab)
{
    foreach my $obj_d(@d)
    {
	if($obj_ab eq $obj_d)
	{
	    $y++;
	}
    }
}

$ABD=$y;

#Determine how many ACD
$y=0;

foreach my $obj_ac(@ac)
{
    foreach my $obj_d(@d)
    {
	if($obj_ac eq $obj_d)
	{
	    $y++;
	}
    }
}

$ACD=$y;

#Determine how many BCD
$y=0;

foreach my $obj_bc(@bc)
{
    foreach my $obj_d(@d)
    {
	if($obj_bc eq $obj_d)
	{
	    $y++;
	}
    }
}

$BCD=$y;

#Determine how many ABCD
$y=0;

foreach my $obj_abc(@abc)
{
    foreach my $obj_d(@d)
    {
	if($obj_abc eq $obj_d)
	{
	    $y++;
	}
    }
}

$ABCD=$y;

#print everything out to check that it worked.

my $ABCD1 = $ABCD;
my $ABC1 = $ABC-$ABCD;
my $ABD1 = $ABD-$ABCD;
my $ACD1 = $ACD-$ABCD;
my $BCD1 = $BCD-$ABCD;
my $AB1 = $AB-($ABC1+$ABD1+$ABCD1);
my $AC1 = $AC-($ACD1+$ABC1+$ABCD1);
my $AD1 = $AD-($ABD1+$ACD1+$ABCD1);
my $BC1 = $BC-($ABC1+$BCD1+$ABCD1);
my $BD1 = $BD-($ABD1+$BCD1+$ABCD1);
my $CD1 = $CD-($ACD1+$BCD1+$ABCD1);
my $A1 = $A-($AB1+$AC1+$AD1+$ABC1+$ABD1+$ACD1+$ABCD1);
my $B1 = $B-($AB1+$BC1+$BD1+$ABC1+$ABD1+$BCD1+$ABCD1);
my $C1 = $C-($AC1+$BC1+$CD1+$ACD1+$ABC1+$BCD1+$ABCD1);
my $D1 = $D-($AD1+$BD1+$CD1+$ACD1+$ABD1+$BCD1+$ABCD1);

print "A\t$A\n";
print "B\t$B\n";
print "C\t$C\n";
print "D\t$D\n";
print "AB\t$AB\n";
print "AC\t$AC\n";
print "AD\t$AD\n";
print "BC\t$BC\n";
print "BD\t$BD\n";
print "CD\t$CD\n";
print "ABC\t$ABC\n";
print "ABD\t$ABD\n";
print "ACD\t$ACD\n";
print "BCD\t$BCD\n";
print "ABCD\t$ABCD\n\n";

print "A1\t$A1\n";
print "B1\t$B1\n";
print "C1\t$C1\n";
print "D1\t$D1\n";
print "AB1\t$AB1\n";
print "AC1\t$AC1\n";
print "AD1\t$AD1\n";
print "BC1\t$BC1\n";
print "BD1\t$BD1\n";
print "CD1\t$CD1\n";
print "ABC1\t$ABC1\n";
print "ABD1\t$ABD1\n";
print "ACD1\t$ACD1\n";
print "BCD1\t$BCD1\n";
print "ABCD1\t$ABCD1\n";


#open(VE,">ve.in");
#print VE "library\(venneuler\)\n";
#print VE "v\=venneuler\(c\('A'\=$A\,'B'\=$B\,'C'\=$C\,'D'\=$D\,'A&B'\=$AB\,'A&C'\=$AC\,'A&D'\=$AD\,'B&C'\=$BC\,'B&D'\=$BD\,'C&D'\=$CD\,'A&B&C'\=$ABC\,'A&B&D'\=$ABD\,'A&C&D'\=$ACD\,'B&C&D'\=$BCD\,'A&B&C&D'\=$ABCD\)\)\n";

#print VE "pdf\(file\=\"ve\_out\.pdf\"\)\n";
#print VE "plot\(v\,col\=grey.colors()\)\n";
#print VE "dev\.off\(\)";

#close(VE);

#system("R --no-save <ve.in> temp");
