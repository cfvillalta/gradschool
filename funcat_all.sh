echo NcA1
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu A1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo
echo NcA2
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu B1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo
echo NcC
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu C1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo
echo Nd
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu D1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo
echo NcA1 NcA2
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu AB1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo
echo NcA1 NcC
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu AC1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo
echo NcA1 Nd
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu AD1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo
echo NcA2 NcC
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu BC1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo
echo NcA2 Nd
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu BD1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo
echo NcC Nd
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu CD1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo
echo NcA1 NcA2 NcC
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu ABC1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo
echo NcA1 NcA2 Nd
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu ABD1.ncu funcat-2.1_scheme|awk '$3<0.05'>funcat_ABD1.dat
echo
echo NcA1 NcC Nd
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu ACD1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo
echo NcA2 NcC Nd
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu BCD1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo
echo NcA1 NcA2 NcC Nd
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579.ncu ABCD1.ncu funcat-2.1_scheme|awk '$3<0.05'