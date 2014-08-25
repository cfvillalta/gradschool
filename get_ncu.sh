echo NcA1
perl funcat_enrichment.pl  A1.ncu |awk '$4<0.05'
echo
echo NcA2
perl funcat_enrichment.pl B1.ncu|awk '$4<0.05'
echo
echo NcC
perl funcat_enrichment.pl C1.ncu |awk '$4<0.05'
echo
echo Nd
perl funcat_enrichment.pl D1.ncu |awk '$4<0.05'
echo
echo NcA1 NcA2
perl funcat_enrichment.pl AB1.ncu|awk '$4<0.05'
echo
echo NcA1 NcC
perl funcat_enrichment.pl AC1.ncu |awk '$4<0.05'
echo
echo NcA1 Nd
perl funcat_enrichment.pl  AD1.ncu |awk '$4<0.05'
echo
echo NcA2 NcC
perl funcat_enrichment.pl BC1.ncu |awk '$4<0.05'
echo
echo NcA2 Nd
perl funcat_enrichment.pl BD.ncu |awk '$4<0.05'
echo
echo NcC Nd
perl funcat_enrichment.pl  CD1.ncu |awk '$4<0.05'
echo
echo NcA1 NcA2 NcC
perl funcat_enrichment.pl ABC1.ncu |awk '$4<0.05'
echo
echo NcA1 NcA2 Nd
perl funcat_enrichment.pl ABD1.ncu |awk '$4<0.05'>funcat_ABD1.dat
echo
echo NcA1 NcC Nd
perl funcat_enrichment.pl ACD1.ncu |awk '$4<0.05'
echo
echo NcA2 NcC Nd
perl funcat_enrichment.pl BCD1.ncu |awk '$4<0.05'
echo
echo NcA1 NcA2 NcC Nd
perl funcat_enrichment.pl ABCD1.ncu |awk '$4<0.05'