#EDEGER
#2489-2489-BA
mkdir 2489-2489-BA
cp rc/readcount_2489-2489-BA.dat 2489-2489-BA/.
cp rc/readcount_2489-2489-BA_3q_norm_e4.dat 2489-2489-BA/.
cp rc/2489-2489-BA-3q-e4-tot-lib-size.dat 2489-2489-BA/.
cp 2489-2489-BA/2489-2489-BA-3q-e4-tot-lib-size.dat 2489-2489-BA/libsize.dat
cp 2489-2489-BA/readcount_2489-2489-BA_3q_norm_e4.dat 2489-2489-BA/readcount.dat
cp *.R 2489-2489-BA/.
cp *.pl 2489-2489-BA/.
cd 2489-2489-BA
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-2489-BA_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-2489-BA_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-D115-BA
mkdir 2489-D115-BA
cp rc/readcount_2489-D115-BA.dat 2489-D115-BA/.
cp rc/readcount_2489-D115-BA_3q_norm_e4.dat 2489-D115-BA/.
cp rc/2489-D115-BA-3q-e4-tot-lib-size.dat 2489-D115-BA/.
cp 2489-D115-BA/2489-D115-BA-3q-e4-tot-lib-size.dat 2489-D115-BA/libsize.dat
cp 2489-D115-BA/readcount_2489-D115-BA_3q_norm_e4.dat 2489-D115-BA/readcount.dat
cp *.R 2489-D115-BA/.
cp *.pl 2489-D115-BA/.
cd 2489-D115-BA
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-D115-BA_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-D115-BA_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-D107-BA
mkdir 2489-D107-BA
cp rc/readcount_2489-D107-BA.dat 2489-D107-BA/.
cp rc/readcount_2489-D107-BA_3q_norm_e4.dat 2489-D107-BA/.
cp rc/2489-D107-BA-3q-e4-tot-lib-size.dat 2489-D107-BA/.
cp 2489-D107-BA/2489-D107-BA-3q-e4-tot-lib-size.dat 2489-D107-BA/libsize.dat
cp 2489-D107-BA/readcount_2489-D107-BA_3q_norm_e4.dat 2489-D107-BA/readcount.dat
cp *.R 2489-D107-BA/.
cp *.pl 2489-D107-BA/.
cd 2489-D107-BA
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-D107-BA_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-D107-BA_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-8579-BA
mkdir 2489-8579-BA
cp rc/readcount_2489-8579-BA.dat 2489-8579-BA/.
cp rc/readcount_2489-8579-BA_3q_norm_e4.dat 2489-8579-BA/.
cp rc/2489-8579-BA-3q-e4-tot-lib-size.dat 2489-8579-BA/.
cp 2489-8579-BA/2489-8579-BA-3q-e4-tot-lib-size.dat 2489-8579-BA/libsize.dat
cp 2489-8579-BA/readcount_2489-8579-BA_3q_norm_e4.dat 2489-8579-BA/readcount.dat
cp *.R 2489-8579-BA/.
cp *.pl 2489-8579-BA/.
cd 2489-8579-BA
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-8579-BA_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-8579-BA_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-PcWy-BA
mkdir 2489-PcWy-BA
cp rc/readcount_2489-PcWy-BA.dat 2489-PcWy-BA/.
cp rc/readcount_2489-PcWy-BA_3q_norm_e4.dat 2489-PcWy-BA/.
cp rc/2489-PcWy-BA-3q-e4-tot-lib-size.dat 2489-PcWy-BA/.
cp 2489-PcWy-BA/2489-PcWy-BA-3q-e4-tot-lib-size.dat 2489-PcWy-BA/libsize.dat
cp 2489-PcWy-BA/readcount_2489-PcWy-BA_3q_norm_e4.dat 2489-PcWy-BA/readcount.dat
cp *.R 2489-PcWy-BA/.
cp *.pl 2489-PcWy-BA/.
cd 2489-PcWy-BA
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-PcWy-BA_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-PcWy-BA_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-PcWo-BA
mkdir 2489-PcWo-BA
cp rc/readcount_2489-PcWo-BA.dat 2489-PcWo-BA/.
cp rc/readcount_2489-PcWo-BA_3q_norm_e4.dat 2489-PcWo-BA/.
cp rc/2489-PcWo-BA-3q-e4-tot-lib-size.dat 2489-PcWo-BA/.
cp 2489-PcWo-BA/2489-PcWo-BA-3q-e4-tot-lib-size.dat 2489-PcWo-BA/libsize.dat
cp 2489-PcWo-BA/readcount_2489-PcWo-BA_3q_norm_e4.dat 2489-PcWo-BA/readcount.dat
cp *.R 2489-PcWo-BA/.
cp *.pl 2489-PcWo-BA/.
cd 2489-PcWo-BA
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-PcWo-BA_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-PcWo-BA_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..


#2489-alone-2489-2489-B
mkdir 2489-alone-2489-2489-B
cp rc/readcount_2489-alone-2489-2489-B.dat 2489-alone-2489-2489-B/.
cp rc/readcount_2489-alone-2489-2489-B_3q_norm_e4.dat 2489-alone-2489-2489-B/.
cp rc/2489-alone-2489-2489-B-3q-e4-tot-lib-size.dat 2489-alone-2489-2489-B/.
cp 2489-alone-2489-2489-B/2489-alone-2489-2489-B-3q-e4-tot-lib-size.dat 2489-alone-2489-2489-B/libsize.dat
cp 2489-alone-2489-2489-B/readcount_2489-alone-2489-2489-B_3q_norm_e4.dat 2489-alone-2489-2489-B/readcount.dat
cp *.R 2489-alone-2489-2489-B/.
cp *.pl 2489-alone-2489-2489-B/.
cd 2489-alone-2489-2489-B
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-2489-B_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-2489-B_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-alone-2489-2489-A
mkdir 2489-alone-2489-2489-A
cp rc/readcount_2489-alone-2489-2489-A.dat 2489-alone-2489-2489-A/.
cp rc/readcount_2489-alone-2489-2489-A_3q_norm_e4.dat 2489-alone-2489-2489-A/.
cp rc/2489-alone-2489-2489-A-3q-e4-tot-lib-size.dat 2489-alone-2489-2489-A/.
cp 2489-alone-2489-2489-A/2489-alone-2489-2489-A-3q-e4-tot-lib-size.dat 2489-alone-2489-2489-A/libsize.dat
cp 2489-alone-2489-2489-A/readcount_2489-alone-2489-2489-A_3q_norm_e4.dat 2489-alone-2489-2489-A/readcount.dat
cp *.R 2489-alone-2489-2489-A/.
cp *.pl 2489-alone-2489-2489-A/.
cd 2489-alone-2489-2489-A
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-2489-A_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-2489-A_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-alone-2489-D115-B
mkdir 2489-alone-2489-D115-B
cp rc/readcount_2489-alone-2489-D115-B.dat 2489-alone-2489-D115-B/.
cp rc/readcount_2489-alone-2489-D115-B_3q_norm_e4.dat 2489-alone-2489-D115-B/.
cp rc/2489-alone-2489-D115-B-3q-e4-tot-lib-size.dat 2489-alone-2489-D115-B/.
cp 2489-alone-2489-D115-B/2489-alone-2489-D115-B-3q-e4-tot-lib-size.dat 2489-alone-2489-D115-B/libsize.dat
cp 2489-alone-2489-D115-B/readcount_2489-alone-2489-D115-B_3q_norm_e4.dat 2489-alone-2489-D115-B/readcount.dat
cp *.R 2489-alone-2489-D115-B/.
cp *.pl 2489-alone-2489-D115-B/.
cd 2489-alone-2489-D115-B
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-D115-B_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-D115-B_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-alone-2489-D115-A
mkdir 2489-alone-2489-D115-A
cp rc/readcount_2489-alone-2489-D115-A.dat 2489-alone-2489-D115-A/.
cp rc/readcount_2489-alone-2489-D115-A_3q_norm_e4.dat 2489-alone-2489-D115-A/.
cp rc/2489-alone-2489-D115-A-3q-e4-tot-lib-size.dat 2489-alone-2489-D115-A/.
cp 2489-alone-2489-D115-A/2489-alone-2489-D115-A-3q-e4-tot-lib-size.dat 2489-alone-2489-D115-A/libsize.dat
cp 2489-alone-2489-D115-A/readcount_2489-alone-2489-D115-A_3q_norm_e4.dat 2489-alone-2489-D115-A/readcount.dat
cp *.R 2489-alone-2489-D115-A/.
cp *.pl 2489-alone-2489-D115-A/.
cd 2489-alone-2489-D115-A
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-D115-A_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-D115-A_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-alone-2489-D107-B
mkdir 2489-alone-2489-D107-B
cp rc/readcount_2489-alone-2489-D107-B.dat 2489-alone-2489-D107-B/.
cp rc/readcount_2489-alone-2489-D107-B_3q_norm_e4.dat 2489-alone-2489-D107-B/.
cp rc/2489-alone-2489-D107-B-3q-e4-tot-lib-size.dat 2489-alone-2489-D107-B/.
cp 2489-alone-2489-D107-B/2489-alone-2489-D107-B-3q-e4-tot-lib-size.dat 2489-alone-2489-D107-B/libsize.dat
cp 2489-alone-2489-D107-B/readcount_2489-alone-2489-D107-B_3q_norm_e4.dat 2489-alone-2489-D107-B/readcount.dat
cp *.R 2489-alone-2489-D107-B/.
cp *.pl 2489-alone-2489-D107-B/.
cd 2489-alone-2489-D107-B
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-D107-B_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-D107-B_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-alone-2489-D107-A
mkdir 2489-alone-2489-D107-A
cp rc/readcount_2489-alone-2489-D107-A.dat 2489-alone-2489-D107-A/.
cp rc/readcount_2489-alone-2489-D107-A_3q_norm_e4.dat 2489-alone-2489-D107-A/.
cp rc/2489-alone-2489-D107-A-3q-e4-tot-lib-size.dat 2489-alone-2489-D107-A/.
cp 2489-alone-2489-D107-A/2489-alone-2489-D107-A-3q-e4-tot-lib-size.dat 2489-alone-2489-D107-A/libsize.dat
cp 2489-alone-2489-D107-A/readcount_2489-alone-2489-D107-A_3q_norm_e4.dat 2489-alone-2489-D107-A/readcount.dat
cp *.R 2489-alone-2489-D107-A/.
cp *.pl 2489-alone-2489-D107-A/.
cd 2489-alone-2489-D107-A
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-D107-A_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-D107-A_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-alone-2489-8579-B
mkdir 2489-alone-2489-8579-B
cp rc/readcount_2489-alone-2489-8579-B.dat 2489-alone-2489-8579-B/.
cp rc/readcount_2489-alone-2489-8579-B_3q_norm_e4.dat 2489-alone-2489-8579-B/.
cp rc/2489-alone-2489-8579-B-3q-e4-tot-lib-size.dat 2489-alone-2489-8579-B/.
cp 2489-alone-2489-8579-B/2489-alone-2489-8579-B-3q-e4-tot-lib-size.dat 2489-alone-2489-8579-B/libsize.dat
cp 2489-alone-2489-8579-B/readcount_2489-alone-2489-8579-B_3q_norm_e4.dat 2489-alone-2489-8579-B/readcount.dat
cp *.R 2489-alone-2489-8579-B/.
cp *.pl 2489-alone-2489-8579-B/.
cd 2489-alone-2489-8579-B
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-8579-B_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-8579-B_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-alone-2489-8579-A
mkdir 2489-alone-2489-8579-A
cp rc/readcount_2489-alone-2489-8579-A.dat 2489-alone-2489-8579-A/.
cp rc/readcount_2489-alone-2489-8579-A_3q_norm_e4.dat 2489-alone-2489-8579-A/.
cp rc/2489-alone-2489-8579-A-3q-e4-tot-lib-size.dat 2489-alone-2489-8579-A/.
cp 2489-alone-2489-8579-A/2489-alone-2489-8579-A-3q-e4-tot-lib-size.dat 2489-alone-2489-8579-A/libsize.dat
cp 2489-alone-2489-8579-A/readcount_2489-alone-2489-8579-A_3q_norm_e4.dat 2489-alone-2489-8579-A/readcount.dat
cp *.R 2489-alone-2489-8579-A/.
cp *.pl 2489-alone-2489-8579-A/.
cd 2489-alone-2489-8579-A
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-8579-A_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-8579-A_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-alone-2489-PcWy-B
mkdir 2489-alone-2489-PcWy-B
cp rc/readcount_2489-alone-2489-PcWy-B.dat 2489-alone-2489-PcWy-B/.
cp rc/readcount_2489-alone-2489-PcWy-B_3q_norm_e4.dat 2489-alone-2489-PcWy-B/.
cp rc/2489-alone-2489-PcWy-B-3q-e4-tot-lib-size.dat 2489-alone-2489-PcWy-B/.
cp 2489-alone-2489-PcWy-B/2489-alone-2489-PcWy-B-3q-e4-tot-lib-size.dat 2489-alone-2489-PcWy-B/libsize.dat
cp 2489-alone-2489-PcWy-B/readcount_2489-alone-2489-PcWy-B_3q_norm_e4.dat 2489-alone-2489-PcWy-B/readcount.dat
cp *.R 2489-alone-2489-PcWy-B/.
cp *.pl 2489-alone-2489-PcWy-B/.
cd 2489-alone-2489-PcWy-B
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-PcWy-B_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-PcWy-B_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-alone-2489-PcWy-A
mkdir 2489-alone-2489-PcWy-A
cp rc/readcount_2489-alone-2489-PcWy-A.dat 2489-alone-2489-PcWy-A/.
cp rc/readcount_2489-alone-2489-PcWy-A_3q_norm_e4.dat 2489-alone-2489-PcWy-A/.
cp rc/2489-alone-2489-PcWy-A-3q-e4-tot-lib-size.dat 2489-alone-2489-PcWy-A/.
cp 2489-alone-2489-PcWy-A/2489-alone-2489-PcWy-A-3q-e4-tot-lib-size.dat 2489-alone-2489-PcWy-A/libsize.dat
cp 2489-alone-2489-PcWy-A/readcount_2489-alone-2489-PcWy-A_3q_norm_e4.dat 2489-alone-2489-PcWy-A/readcount.dat
cp *.R 2489-alone-2489-PcWy-A/.
cp *.pl 2489-alone-2489-PcWy-A/.
cd 2489-alone-2489-PcWy-A
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-PcWy-A_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-PcWy-A_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-alone-2489-PcWo-B
mkdir 2489-alone-2489-PcWo-B
cp rc/readcount_2489-alone-2489-PcWo-B.dat 2489-alone-2489-PcWo-B/.
cp rc/readcount_2489-alone-2489-PcWo-B_3q_norm_e4.dat 2489-alone-2489-PcWo-B/.
cp rc/2489-alone-2489-PcWo-B-3q-e4-tot-lib-size.dat 2489-alone-2489-PcWo-B/.
cp 2489-alone-2489-PcWo-B/2489-alone-2489-PcWo-B-3q-e4-tot-lib-size.dat 2489-alone-2489-PcWo-B/libsize.dat
cp 2489-alone-2489-PcWo-B/readcount_2489-alone-2489-PcWo-B_3q_norm_e4.dat 2489-alone-2489-PcWo-B/readcount.dat
cp *.R 2489-alone-2489-PcWo-B/.
cp *.pl 2489-alone-2489-PcWo-B/.
cd 2489-alone-2489-PcWo-B
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-PcWo-B_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-PcWo-B_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..

#2489-alone-2489-PcWo-A
mkdir 2489-alone-2489-PcWo-A
cp rc/readcount_2489-alone-2489-PcWo-A.dat 2489-alone-2489-PcWo-A/.
cp rc/readcount_2489-alone-2489-PcWo-A_3q_norm_e4.dat 2489-alone-2489-PcWo-A/.
cp rc/2489-alone-2489-PcWo-A-3q-e4-tot-lib-size.dat 2489-alone-2489-PcWo-A/.
cp 2489-alone-2489-PcWo-A/2489-alone-2489-PcWo-A-3q-e4-tot-lib-size.dat 2489-alone-2489-PcWo-A/libsize.dat
cp 2489-alone-2489-PcWo-A/readcount_2489-alone-2489-PcWo-A_3q_norm_e4.dat 2489-alone-2489-PcWo-A/readcount.dat
cp *.R 2489-alone-2489-PcWo-A/.
cp *.pl 2489-alone-2489-PcWo-A/.
cd 2489-alone-2489-PcWo-A
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
R --no-save <edgeR_tagwise_3v3.R> temp
awk '$3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.dat 
awk '$3>0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.dat
awk '$3>0.58 || $3<-0.58' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.dat

awk '$3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_down.ncu 
awk '$3>0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f_up.ncu
awk '$3>0.58 || $3<-0.58{print $1}' edgeR_sig0.05.dat >edgeR_sig0.05_1.5f.ncu
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-PcWo-A_3q_norm_e4.dat edgeR_sig0.05_1.5f_up.ncu >edgeR_sig0.05_1.5f_up.counts
perl get_counts_with_NCU.pl rc/readcount_2489-alone-2489-PcWo-A_3q_norm_e4.dat edgeR_sig0.05_1.5f_down.ncu >edgeR_sig0.05_1.5f_down.counts
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_down.counts > edgeR_sig0.05_1.5f_overlap_down.ncu
perl filter_out_overlap_up.pl edgeR_sig0.05_1.5f_up.counts > edgeR_sig0.05_1.5f_overlap_up.ncu
cat edgeR_sig0.05_1.5f_up.ncu edgeR_sig0.05_1.5f_overlap_up.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_up.ncu
cat edgeR_sig0.05_1.5f_down.ncu edgeR_sig0.05_1.5f_overlap_down.ncu |sort|uniq -u>edgeR_sig0.05_1.5f_nooverlap_down.ncu
cat edgeR_sig0.05_1.5f_nooverlap_up.ncu edgeR_sig0.05_1.5f_nooverlap_down.ncu |sort>edgeR_sig0.05_1.5f_nooverlap.ncu
cd ..



