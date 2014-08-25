#! /usr/bin/perl -w

use Data::Dumper;
use strict;

#want to put in 4 datasets with a line equal to one object in a dataset.


#input 4 files and they will be A,B,C,D

my $file_a= $ARGV[0];
my $file_b= $ARGV[1];
my $file_c= $ARGV[2];
my $file_d= $ARGV[3];

print "$file_a\n$file_b\n$file_c\n$file_d\n";

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
$D=$y;

#print $D,"\n";
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
my @ad;
foreach my $obj_a(@a)
{
    foreach my $obj_d(@d)
    {
	if($obj_a eq $obj_d)
	{
	    $y++;
	    push(@ad,$obj_a);
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
my @bd;
foreach my $obj_b(@b)
{
    foreach my $obj_d(@d)
    {
	if($obj_b eq $obj_d)
	{
	    $y++;
	    push(@bd,$obj_b)
	}
    }
}

$BD=$y;

#Determine how many CD
$y=0;
my @cd;
foreach my $obj_c(@c)
{
    foreach my $obj_d(@d)
    {
	if($obj_c eq $obj_d)
	{
	    $y++;
	    push(@cd,$obj_c);
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
my @abd;
foreach my $obj_ab(@ab)
{
    foreach my $obj_d(@d)
    {
	if($obj_ab eq $obj_d)
	{
	    $y++;
	    push(@abd, $obj_ab);
	}
    }
}

$ABD=$y;

#Determine how many ACD
$y=0;
my @acd;
foreach my $obj_ac(@ac)
{
    foreach my $obj_d(@d)
    {
	if($obj_ac eq $obj_d)
	{
	    $y++;
	    push(@acd,$obj_ac);
	}
    }
}

$ACD=$y;

#Determine how many BCD
$y=0;
my @bcd;
foreach my $obj_bc(@bc)
{
    foreach my $obj_d(@d)
    {
	if($obj_bc eq $obj_d)
	{
	    $y++;
	    push(@bcd,$obj_bc);
	   # print $obj_bc,"\n";
	}
    }
}

$BCD=$y;

#Determine how many ABCD
$y=0;
my @abcd;
foreach my $obj_abc(@abc)
{
    foreach my $obj_d(@d)
    {
	if($obj_abc eq $obj_d)
	{
	    $y++;
	    push(@abcd,$obj_abc);
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
#print join("\n",@bcd),"\n";
print "ABCD\t$ABCD\n";
#print join("\n",@abcd),"\n";
print "\n";

#abcd1
my @abcd1=@abcd;

#bcd1
my @bcd1;
my %seen_bcd1;
if($ABCD eq 0)
{
    @bcd1=@bcd;
}
elsif($ABCD gt 0)
{
    foreach my $obj_ABCD(@abcd)
    {
	$seen_bcd1{$obj_ABCD}=1;
    }
    foreach my $obj_BCD(@bcd)
    {
	unless($seen_bcd1{$obj_BCD})
	{
	    push(@bcd1, $obj_BCD);	   
	}
    }
}

#acd1
my @acd1;
my %seen_acd1;
if($ABCD eq 0)
{
    @acd1=@acd;
}
elsif($ABCD gt 0)
{
    foreach my $obj_ABCD(@abcd)
    {
	$seen_acd1{$obj_ABCD}=1;
    }
    foreach my $obj_ACD(@acd)
    {
	unless($seen_acd1{$obj_ACD})
	{
	    push(@acd1, $obj_ACD);    
	}
    }
}

#abd1
my @abd1;
my %seen_abd1;
if($ABCD eq 0)
{
    @abd1=@abd;
}
elsif($ABCD gt 0)
{
    foreach my $obj_ABCD(@abcd)
    {
	$seen_abd1{$obj_ABCD}=1;
    }
    foreach my $obj_ABD(@abd)
    {
	unless($seen_abd1{$obj_ABD})
	{
	    push(@abd1, $obj_ABD);
	}
    }
}

#abc1
my @abc1;
my %seen_abc1;
if($ABCD eq 0)
{
    @abc1=@abc;
}
elsif($ABCD gt 0)
{
    foreach my $obj_ABCD(@abcd)
    {
	$seen_abc1{$obj_ABCD}=1;	
    }
    foreach my $obj_ABC(@abc)
    {
	unless($seen_abc1{$obj_ABC})
	{
	    
	    push(@abc1, $obj_ABC);

	}
    }
}

#cd1

my @cd1;
my @not_cd1;
my %seen_cd1;
push(@not_cd1,@acd1);
push(@not_cd1,@bcd1);
push(@not_cd1,@abcd1);

if(($ACD1+$BCD1+$ABCD1) eq 0)
{
    @cd1 = @cd;
}
elsif(($ACD1+$BCD1+$ABCD1) gt 0)
{
    foreach my $obj_NOTCD1(@not_cd1)
    {
	$seen_cd1{$obj_NOTCD1}=1;
    }
    foreach my $obj_CD(@cd)
    {
	unless($seen_cd1{$obj_CD})
	{
	    push(@cd1, $obj_CD);
	}
    }
}
		    
#bd1
my @bd1;
my @not_bd1;
my %seen_bd1;
push(@not_bd1,@abd1);
push(@not_bd1,@bcd1);
push(@not_bd1,@abcd1);

if(($ABD1+$BCD1+$ABCD1) eq 0)
{
    @bd1 = @bd;
}
elsif(($ABD1+$BCD1+$ABCD1) gt 0)
{
    foreach my $obj_NOTBD1(@not_bd1)
    {
	$seen_bd1{$obj_NOTBD1}=1;
    }
    foreach my $obj_BD(@bd)
    {
	unless($seen_bd1{$obj_BD})
	{
	    push(@bd1, $obj_BD);
	}
    }
}

#bc1
my @bc1;
my @not_bc1;
my %seen_bc1;
push(@not_bc1,@abc1);
push(@not_bc1,@bcd1);
push(@not_bc1,@abcd1);

if(($ABC1+$BCD1+$ABCD1) eq 0)
{
    @bc1 = @bc;
}
elsif(($ABC1+$BCD1+$ABCD1) gt 0)
{
    foreach my $obj_NOTBC1(@not_bc1)
    {
	$seen_bc1{$obj_NOTBC1}=1;
    }
    foreach my $obj_BC(@bc)
    {
	unless($seen_bc1{$obj_BC})
	{
	    push(@bc1, $obj_BC);
	}
    }
}

#ad1
my @ad1;
my @not_ad1;
my %seen_ad1;
push(@not_ad1,@abd1);
push(@not_ad1,@acd1);
push(@not_ad1,@abcd1);

if(($ABD1+$ACD1+$ABCD1) eq 0)
{
    @ad1 = @ad;
}
elsif(($ABD1+$ACD1+$ABCD1) gt 0)
{
    foreach my $obj_NOTAD1(@not_ad1)
    {
	$seen_ad1{$obj_NOTAD1}=1;
    }
    foreach my $obj_AD(@ad)
    {

	unless($seen_ad1{$obj_AD})
	{
	    # print $obj_AD,"\n";
	    push(@ad1, $obj_AD);    
	}
    }
}
#	print "\n";
 #   }
#}

#ac1
my @ac1;
my @not_ac1;
my %seen_ac1;
push(@not_ac1,@abc1);
push(@not_ac1,@acd1);
push(@not_ac1,@abcd1);

if(($ABC1+$ACD1+$ABCD1) eq 0)
{
    @ac1 = @ac;
}
elsif(($ABC1+$ACD1+$ABCD1) gt 0)
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
push(@not_ab1,@abd1);
push(@not_ab1,@abcd1);

if(($ABC1+$ABD1+$ABCD1) eq 0)
{
    @ab1 = @ab;
}
elsif(($ABC1+$ABD1+$ABCD1) gt 0)
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

#d1
my @d1;
my @not_d1;
my %seen_d1;
@not_d1=(@ad1,@bd1,@cd1,@acd1,@abd1,@bcd1,@abcd1);

if(($AD1+$BD1+$CD1+$ACD1+$ABD1+$BCD1+$ABCD1) eq 0)
{
    @d1 = @d;
}
elsif(($AD1+$BD1+$CD1+$ACD1+$ABD1+$BCD1+$ABCD1) gt 0)
{ 
    foreach my $obj_NOTD1(@not_d1)
    {
	$seen_d1{$obj_NOTD1}=1;
    }
    foreach my $obj_D(@d)
    {
	unless($seen_d1{$obj_D})
	{
	    push(@d1, $obj_D);
	}
    }
}

#c1
my @c1;
my @not_c1;
my %seen_c1;
@not_c1=(@ac1,@bc1,@cd1,@acd1,@abc1,@bcd1,@abcd1);

if(($AC1+$BC1+$CD1+$ACD1+$ABC1+$BCD1+$ABCD1) eq 0)
{
    @c1 = @c;
}
elsif(($AC1+$BC1+$CD1+$ACD1+$ABC1+$BCD1+$ABCD1) gt 0)
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
@not_b1=(@ab1,@bd1,@bc1,@abc1,@abd1,@bcd1,@abcd1);

if(($AB1+$BD1+$BC1+$ABC1+$ABD1+$BCD1+$ABCD1) eq 0)
{
    @b1 = @b;
}
elsif(($AB1+$BD1+$BC1+$ABC1+$ABD1+$BCD1+$ABCD1) gt 0)
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
@not_a1=(@ad1,@ab1,@ac1,@acd1,@abd1,@abc1,@abcd1);

if(($AD1+$AB1+$AC1+$ACD1+$ABD1+$ABC1+$ABCD1) eq 0)
{
    @a1 = @a;
}
elsif(($AD1+$AB1+$AC1+$ACD1+$ABD1+$ABC1+$ABCD1) gt 0)
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
#print join("\n",@a1),"\n";
#open(A1,">A1.ncu");
#print A1 join("\n",@a1),"\n";
#close(A1);

print "B1\t$B1\n";
#print join("\n",@b1),"\n";
#open(B1,">B1.ncu");
#print B1 join("\n",@b1),"\n";
#close(B1);

print "C1\t$C1\n";
#print join("\n",@c1),"\n";
#open(C1,">C1.ncu");
#print C1 join("\n",@c1),"\n";
#close(C1);

print "D1\t$D1\n";
#print join("\n",@d1),"\n";
#open(D1,">D1.ncu");
#print D1 join("\n",@d1),"\n";
#close(D1);

print "AB1\t$AB1\n";
#print join("\n",@ab1),"\n";
#open(AB1,">AB1.ncu");
#print AB1 join("\n",@ab1),"\n";
#close(AB1);

print "AC1\t$AC1\n";
#print join("\n",@ac1),"\n";
#open(AC1,">AC1.ncu");
#print AC1 join("\n",@ac1),"\n";
#close(AC1);

print "AD1\t$AD1\n";
#print join("\n",@ad1)."\n";
#open(AD1,">AD1.ncu");
#print AD1 join("\n",@ad1),"\n";
#close(AD1);

print "BC1\t$BC1\n";
#print join("\n",@bc1),"\n";
#open(BC1,">BC1.ncu");
#print BC1 join("\n",@bc1),"\n";
#close(BC1);

print "BD1\t$BD1\n";
#print join("\n",@bd1),"\n";
#open(BD1,">BD1.ncu");
#print BD1 join("\n",@bd1),"\n";
#close(BD1);

print "CD1\t$CD1\n";
#print join("\n",@cd1),"\n";
#open(CD1,">CD1.ncu");
#print CD1 join("\n",@cd1),"\n";
#close(CD1);

print "ABC1\t$ABC1\n";
#print join("\n",@abc1),"\n";
#open(ABC1,">ABC1.ncu");
#print ABC1 join("\n",@abc1),"\n";
#close(ABC1);

print "ABD1\t$ABD1\n";
#print join("\n",@abd1),"\n";
#open(ABD1,">ABD1.ncu");
#print ABD1 join("\n",@abd1),"\n";
#close(ABD1);

print "ACD1\t$ACD1\n";
#print join("\n",@acd1),"\n";
#open(ACD1,">ACD1.ncu");
#print ACD1 join("\n",@acd1),"\n";
#close(ACD1);

print "BCD1\t$BCD1\n";
#print join("\n",@bcd1),"\n";
#open(BCD1,">BCD1.ncu");
#print BCD1 join("\n",@bcd1),"\n";
#close(BCD1);

print "ABCD1\t$ABCD1\n";
#print join("\n",@abcd1,),"\n";
#open(ABCD1,">ABCD1.ncu");
#print ABCD1 join("\n",@abcd1),"\n";
#close(ABCD1);

#open(VE,">ve.in");
#print VE "library\(venneuler\)\n";
#print VE "v\=venneuler\(c\('A'\=$A\,'B'\=$B\,'C'\=$C\,'D'\=$D\,'A&B'\=$AB\,'A&C'\=$AC\,'A&D'\=$AD\,'B&C'\=$BC\,'B&D'\=$BD\,'C&D'\=$CD\,'A&B&C'\=$ABC\,'A&B&D'\=$ABD\,'A&C&D'\=$ACD\,'B&C&D'\=$BCD\,'A&B&C&D'\=$ABCD\)\)\n";

#print VE "pdf\(file\=\"ve\_out\.pdf\"\)\n";
#print VE "plot\(v\,col\=grey.colors()\)\n";
#print VE "dev\.off\(\)";

#close(VE);

#system("R --no-save <ve.in> temp");
