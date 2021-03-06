# will input four allDE files.
#U is up, D is down, and N is no change.
#on 20110609 wanted to modify this script so i could get all the trends for the 2604 genes and include NNN and basically output four files to input into my venn diagram program.
use Data::Dumper;
use strict;

my $condition1=$ARGV[0];
my $condition2=$ARGV[1];
my $condition3=$ARGV[2];
my $condition4=$ARGV[3];
my $colors=$ARGV[4];
open(C1,$condition1);
open(C2,$condition2);
open(C3,$condition3);
open(C4,$condition4);
open(C, $colors);

my %c1h;
my %c2h;
my %c3h;
my %c4h;
my %col;

my %ncu_uniq;

while(my $c1 = <C1>)
{
    chomp($c1);
    my @c1_s = split("\t",$c1);
    $c1h{$c1_s[0]}=$c1_s[1];
    $ncu_uniq{$c1_s[0]}=$c1_s[0];
}
while(my $c2 = <C2>)
{
    chomp($c2);
    my @c2_s = split("\t",$c2);
    $c2h{$c2_s[0]}=$c2_s[1];
    $ncu_uniq{$c2_s[0]}=$c2_s[0];
}
while(my $c3 = <C3>)
{
    chomp($c3);
    my @c3_s = split("\t",$c3);
    $c3h{$c3_s[0]}=$c3_s[1];
    $ncu_uniq{$c3_s[0]}=$c3_s[0];
}
while(my $c4 = <C4>)
{
    chomp($c4);
    my @c4_s = split("\t",$c4);
    $c4h{$c4_s[0]}=$c4_s[1];
    $ncu_uniq{$c4_s[0]}=$c4_s[0];
}
while(my $c = <C>)
{
    chomp($c);
    my @c_s = split("\t",$c);
    $col{$c_s[0]}=$c_s[1];
}

my %con1;
my %con2;
my %con3;
my %con4;
#if the ncu is present in the condition it will be place in the new hash con# but if it is not a NNN will be placed in there instead.
foreach my $x(keys %ncu_uniq)
{
    if(exists $c1h{$x})
    {
	$con1{$x}=$c1h{$x};
    }
    else
    {
	$con1{$x}="NNN";
    }
    if(exists $c2h{$x})
    {
	$con2{$x}=$c2h{$x};
    }
    else
    {
	$con2{$x}="NNN";
    }
    if(exists $c3h{$x})
    {
	$con3{$x}=$c3h{$x};
    }
    else
    {
	$con3{$x}="NNN";
    }
    if(exists $c4h{$x})
    {
	$con4{$x}=$c4h{$x};
    }
    else
    {
	$con4{$x}="NNN";
    }
}

my @col_data1;
my @col_data2;
my @col_data3;
my @col_data4;

my $num=0;
my @ncu;
foreach my $x(reverse(sort{$con1{$a}cmp$con1{$b}} keys %con1))
{
    #if($con4{$x} ne "NNN")
    #{
	push(@col_data1,$col{$con1{$x}});
	push(@col_data2,$col{$con2{$x}});
	push(@col_data3,$col{$con3{$x}});
	push(@col_data4,$col{$con4{$x}});
   #} 
    $num++;
    push(@ncu,"$x");
}

#my @num_a=(0..($num-1));
#print ">NcA1\n";
#print join("",@col_data1),"\n";
#print ">NcA2\n";
#print join("",@col_data2),"\n";
#print ">NcC\n";
#print join("",@col_data3),"\n";
#print ">Nd\n";
#print join("",@col_data4),"\n";

#my @trends_col;
#foreach my $n(@num_a)
#{
#    my @x = ($ncu[$n],$col_data1[$n],$col_data2[$n],$col_data3[$n],$col_data1[$n]);
#    push(@trends_col,"$ncu[$n]\t$col_data1[$n]\t$col_data2[$n]\t$col_data3[$n]\t$col_data4[$n]");
#}
#print Dumper @trends_col;

#my $a;
#my $b;
#my $c;
#my $d;

#print join("\n", @trends_col),"\n";

open(OUT1, ">allDE_sig0.05_1.5f_trends_all_2489.dat");
open(OUT2, ">allDE_sig0.05_1.5f_trends_all_D115.dat");
open(OUT3, ">allDE_sig0.05_1.5f_trends_all_D107.dat");
open(OUT4, ">allDE_sig0.05_1.5f_trends_all_8579.dat");

foreach my $x(keys %ncu_uniq)
{
    #will be easy to finish it....
    print OUT1 "$x\t$con1{$x}\n";
    print OUT2 "$x\t$con2{$x}\n";
    print OUT3 "$x\t$con3{$x}\n";
    print OUT4 "$x\t$con4{$x}\n";
 #   print "$x\t$con1{$x}\n";    
}
