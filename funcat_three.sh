echo PcWy
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579-PcWy-PcWo.ncu A1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo
echo PcWo
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579-PcWy-PcWo.ncu B1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo
echo all_N
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579-PcWy-PcWo.ncu C1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo

echo PcWy PcWo
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579-PcWy-PcWo.ncu AB1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo

echo PcWo all_N
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579-PcWy-PcWo.ncu BC1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo

echo PcWy PcWo all_N
perl funcat_enrichment.pl all_NCU_2489-D115-D107-8579-PcWy-PcWo.ncu ABC1.ncu funcat-2.1_scheme|awk '$3<0.05'
echo