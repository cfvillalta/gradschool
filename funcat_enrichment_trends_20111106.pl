# will input four allDE files.
#U is up, D is down, and N is no change.

use Data::Dumper;
use strict;

my $condition1=$ARGV[0];
open(C1,$condition1);


my %c1h;
my %trend_uniq;

while(my $c1 = <C1>)
{
    chomp($c1);
    my @c1_s = split("\t",$c1);
    $c1h{$c1_s[0]}=$c1_s[1];
    $trend_uniq{$c1_s[1]}=0;
}

#print Dumper %c1h;
#print Dumper %trend_uniq;



foreach my $x(keys %trend_uniq)
{
   # print $x,"\n";
    open(OUT, "> f_out.dat");
    foreach my $y(keys %c1h)
    {
	if($x eq $c1h{$y})
	{
	    print OUT "$y\n";
	}
    }
    close(OUT);
    system("perl funcat\_enrichment\.pl all\_NCU\_2489\-D115\-D107\-8579\.ncu f\_out\.dat funcat\-2.1_scheme\|awk '\$3<0.05'>f\.out");
   
    
    open(FIN, "f.out");
    while( my $fin=<FIN>)
    {
	print "$x\t$fin";
    }

  #  print "\n";
}


