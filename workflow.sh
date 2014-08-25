#################################
sig0.05_1.5f_nooverlap
#################################

ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/readcounts_040411/ rc
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/edgeR_040511/ e
ln -s ~/Neurospora_contact_RNAseq/NC10_assembly/DESeq_040611/ d

#Trends for sig0.05_1.5f_nooverlap edgeR

perl find_trends_one_edgeR.pl e/2489-alone-2489-2489-B/edgeR_sig0.05.dat e/2489-2489-BA/edgeR_sig0.05.dat e/2489-alone-2489-2489-A/edgeR_sig0.05.dat rc/readcount_2489-alone-2489-2489-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-2489-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_edgeR_sig0.05_1.5f_nooverlap_2489.ncu>allDE_edgeR_sig0.05_1.5f_nooverlap_trends_2489.dat

perl find_trends_one_edgeR.pl e/2489-alone-2489-D115-B/edgeR_sig0.05.dat e/2489-D115-BA/edgeR_sig0.05.dat e/2489-alone-2489-D115-A/edgeR_sig0.05.dat rc/readcount_2489-alone-2489-D115-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-D115-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_edgeR_sig0.05_1.5f_nooverlap_D115.ncu>allDE_edgeR_sig0.05_1.5f_nooverlap_trends_D115.dat

perl find_trends_one_edgeR.pl e/2489-alone-2489-D107-B/edgeR_sig0.05.dat e/2489-D107-BA/edgeR_sig0.05.dat e/2489-alone-2489-D107-A/edgeR_sig0.05.dat rc/readcount_2489-alone-2489-D107-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-D107-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_edgeR_sig0.05_1.5f_nooverlap_D107.ncu>allDE_edgeR_sig0.05_1.5f_nooverlap_trends_D107.dat

perl find_trends_one_edgeR.pl e/2489-alone-2489-8579-B/edgeR_sig0.05.dat e/2489-8579-BA/edgeR_sig0.05.dat e/2489-alone-2489-8579-A/edgeR_sig0.05.dat rc/readcount_2489-alone-2489-8579-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-8579-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_edgeR_sig0.05_1.5f_nooverlap_8579.ncu>allDE_edgeR_sig0.05_1.5f_nooverlap_trends_8579.dat

perl find_trends_one_edgeR.pl e/2489-alone-2489-PcWy-B/edgeR_sig0.05.dat e/2489-PcWy-BA/edgeR_sig0.05.dat e/2489-alone-2489-PcWy-A/edgeR_sig0.05.dat rc/readcount_2489-alone-2489-PcWy-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-PcWy-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_edgeR_sig0.05_1.5f_nooverlap_PcWy.ncu>allDE_edgeR_sig0.05_1.5f_nooverlap_trends_PcWy.dat

perl find_trends_one_edgeR.pl e/2489-alone-2489-PcWo-B/edgeR_sig0.05.dat e/2489-PcWo-BA/edgeR_sig0.05.dat e/2489-alone-2489-PcWo-A/edgeR_sig0.05.dat rc/readcount_2489-alone-2489-PcWo-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-PcWo-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_edgeR_sig0.05_1.5f_nooverlap_PcWo.ncu>allDE_edgeR_sig0.05_1.5f_nooverlap_trends_PcWo.dat

perl barplot_exp_within_condition.pl allDE_edgeR_sig0.05_1.5f_nooverlap_trends_2489.dat allDE_edgeR_sig0.05_1.5f_nooverlap_trends_D115.dat allDE_edgeR_sig0.05_1.5f_nooverlap_trends_D107.dat allDE_edgeR_sig0.05_1.5f_nooverlap_trends_8579.dat |sort>barplot_exp_edgeR_sig0.05_1.5f_nooverlap_trends.dat

perl barplot_exp_within_condition.pl allDE_edgeR_sig0.05_1.5f_nooverlap_trends_2489.dat allDE_edgeR_sig0.05_1.5f_nooverlap_trends_D115.dat allDE_edgeR_sig0.05_1.5f_nooverlap_trends_D107.dat allDE_edgeR_sig0.05_1.5f_nooverlap_trends_8579.dat|awk '$2>0 || $3>0 || $4>0 || $5>0'|sort>barplot_exp_edgeR_sig0.05_1.5f_nooverlap_trends_nozero.dat 

perl match_color_make_barchart_trends.pl barplot_exp_edgeR_sig0.05_1.5f_nooverlap_trends_nozero.dat colorcodes.txt

#Trends for sig0.05_1.5f_nooverlap DESeq

perl find_trends_one_DESeq.pl d/2489-alone-2489-2489-B/DESeq_sig0.05.dat d/2489-2489-BA/DESeq_sig0.05.dat d/2489-alone-2489-2489-A/DESeq_sig0.05.dat rc/readcount_2489-alone-2489-2489-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-2489-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_DESeq_sig0.05_1.5f_nooverlap_2489.ncu>allDE_DESeq_sig0.05_1.5f_nooverlap_trends_2489.dat

perl find_trends_one_DESeq.pl d/2489-alone-2489-D115-B/DESeq_sig0.05.dat d/2489-D115-BA/DESeq_sig0.05.dat d/2489-alone-2489-D115-A/DESeq_sig0.05.dat rc/readcount_2489-alone-2489-D115-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-D115-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_DESeq_sig0.05_1.5f_nooverlap_D115.ncu>allDE_DESeq_sig0.05_1.5f_nooverlap_trends_D115.dat

perl find_trends_one_DESeq.pl d/2489-alone-2489-D107-B/DESeq_sig0.05.dat d/2489-D107-BA/DESeq_sig0.05.dat d/2489-alone-2489-D107-A/DESeq_sig0.05.dat rc/readcount_2489-alone-2489-D107-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-D107-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_DESeq_sig0.05_1.5f_nooverlap_D107.ncu>allDE_DESeq_sig0.05_1.5f_nooverlap_trends_D107.dat

perl find_trends_one_DESeq.pl d/2489-alone-2489-8579-B/DESeq_sig0.05.dat d/2489-8579-BA/DESeq_sig0.05.dat d/2489-alone-2489-8579-A/DESeq_sig0.05.dat rc/readcount_2489-alone-2489-8579-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-8579-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_DESeq_sig0.05_1.5f_nooverlap_8579.ncu>allDE_DESeq_sig0.05_1.5f_nooverlap_trends_8579.dat

perl find_trends_one_DESeq.pl d/2489-alone-2489-PcWy-B/DESeq_sig0.05.dat d/2489-PcWy-BA/DESeq_sig0.05.dat d/2489-alone-2489-PcWy-A/DESeq_sig0.05.dat rc/readcount_2489-alone-2489-PcWy-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-PcWy-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_DESeq_sig0.05_1.5f_nooverlap_PcWy.ncu>allDE_DESeq_sig0.05_1.5f_nooverlap_trends_PcWy.dat

perl find_trends_one_DESeq.pl d/2489-alone-2489-PcWo-B/DESeq_sig0.05.dat d/2489-PcWo-BA/DESeq_sig0.05.dat d/2489-alone-2489-PcWo-A/DESeq_sig0.05.dat rc/readcount_2489-alone-2489-PcWo-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-PcWo-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_DESeq_sig0.05_1.5f_nooverlap_PcWo.ncu>allDE_DESeq_sig0.05_1.5f_nooverlap_trends_PcWo.dat

perl barplot_exp_within_condition.pl allDE_DESeq_sig0.05_1.5f_nooverlap_trends_2489.dat allDE_DESeq_sig0.05_1.5f_nooverlap_trends_D115.dat allDE_DESeq_sig0.05_1.5f_nooverlap_trends_D107.dat allDE_DESeq_sig0.05_1.5f_nooverlap_trends_8579.dat |sort>barplot_exp_DESeq_sig0.05_1.5f_nooverlap_trends.dat

perl barplot_exp_within_condition.pl allDE_DESeq_sig0.05_1.5f_nooverlap_trends_2489.dat allDE_DESeq_sig0.05_1.5f_nooverlap_trends_D115.dat allDE_DESeq_sig0.05_1.5f_nooverlap_trends_D107.dat allDE_DESeq_sig0.05_1.5f_nooverlap_trends_8579.dat|awk '$2>0 || $3>0 || $4>0 || $5>0'|sort>barplot_exp_DESeq_sig0.05_1.5f_nooverlap_trends_nozero.dat 

perl match_color_make_barchart_trends.pl barplot_exp_DESeq_sig0.05_1.5f_nooverlap_trends_nozero.dat colorcodes.txt

#allsig

perl find_trends.pl e/2489-alone-2489-2489-B/edgeR_sig0.05.dat e/2489-2489-BA/edgeR_sig0.05.dat e/2489-alone-2489-2489-A/edgeR_sig0.05.dat d/2489-alone-2489-2489-B/DESeq_sig0.05.dat d/2489-2489-BA/DESeq_sig0.05.dat d/2489-alone-2489-2489-A/DESeq_sig0.05.dat rc/readcount_2489-alone-2489-2489-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-2489-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_sig0.05_1.5f_nooverlap_2489.ncu>allDE_sig0.05_1.5f_nooverlap_trends_2489.dat

perl find_trends.pl e/2489-alone-2489-D115-B/edgeR_sig0.05.dat e/2489-D115-BA/edgeR_sig0.05.dat e/2489-alone-2489-D115-A/edgeR_sig0.05.dat d/2489-alone-2489-D115-B/DESeq_sig0.05.dat d/2489-D115-BA/DESeq_sig0.05.dat d/2489-alone-2489-D115-A/DESeq_sig0.05.dat rc/readcount_2489-alone-2489-D115-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-D115-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_sig0.05_1.5f_nooverlap_D115.ncu>allDE_sig0.05_1.5f_nooverlap_trends_D115.dat

perl find_trends.pl e/2489-alone-2489-D107-B/edgeR_sig0.05.dat e/2489-D107-BA/edgeR_sig0.05.dat e/2489-alone-2489-D107-A/edgeR_sig0.05.dat d/2489-alone-2489-D107-B/DESeq_sig0.05.dat d/2489-D107-BA/DESeq_sig0.05.dat d/2489-alone-2489-D107-A/DESeq_sig0.05.dat rc/readcount_2489-alone-2489-D107-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-D107-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_sig0.05_1.5f_nooverlap_D107.ncu>allDE_sig0.05_1.5f_nooverlap_trends_D107.dat

perl find_trends.pl e/2489-alone-2489-8579-B/edgeR_sig0.05.dat e/2489-8579-BA/edgeR_sig0.05.dat e/2489-alone-2489-8579-A/edgeR_sig0.05.dat d/2489-alone-2489-8579-B/DESeq_sig0.05.dat d/2489-8579-BA/DESeq_sig0.05.dat d/2489-alone-2489-8579-A/DESeq_sig0.05.dat rc/readcount_2489-alone-2489-8579-B_3q_norm_e4.dat rc/readcount_2489-alone-2489-8579-A_3q_norm_e4.dat ~/Neurospora_contact_RNAseq/NC10_assembly/compare_sig0.05_1.5f_nooverlap_040611/allDE_sig0.05_1.5f_nooverlap_8579.ncu>allDE_sig0.05_1.5f_nooverlap_trends_8579.dat

perl barplot_exp_within_condition.pl allDE_sig0.05_1.5f_nooverlap_trends_2489.dat allDE_sig0.05_1.5f_nooverlap_trends_D115.dat allDE_sig0.05_1.5f_nooverlap_trends_D107.dat allDE_sig0.05_1.5f_nooverlap_trends_8579.dat |sort>barplot_exp_sig0.05_1.5f_nooverlap_trends.dat

perl barplot_exp_within_condition.pl allDE_sig0.05_1.5f_nooverlap_trends_2489.dat allDE_sig0.05_1.5f_nooverlap_trends_D115.dat allDE_sig0.05_1.5f_nooverlap_trends_D107.dat allDE_sig0.05_1.5f_nooverlap_trends_8579.dat|awk '$2>0 || $3>0 || $4>0 || $5>0'|sort>barplot_exp_sig0.05_1.5f_nooverlap_trends_nozero.dat 

perl match_color_make_barchart_trends.pl barplot_exp_sig0.05_1.5f_nooverlap_trends_nozero.dat colorcodes.txt

#venn diagram from edgeR
perl make_4_set_venneuler_ncu.pl allDE_edgeR_sig0.05_1.5f_nooverlap_trends_2489.dat allDE_edgeR_sig0.05_1.5f_nooverlap_trends_D115.dat allDE_edgeR_sig0.05_1.5f_nooverlap_trends_D107.dat allDE_edgeR_sig0.05_1.5f_nooverlap_trends_8579.dat>allDE_edgeR_sig0.05_1.5f_nooverlap_4_set_venn_ncu.dat

perl make_4_set_venneuler.pl allDE_edgeR_sig0.05_1.5f_nooverlap_trends_2489.dat allDE_edgeR_sig0.05_1.5f_nooverlap_trends_D115.dat allDE_edgeR_sig0.05_1.5f_nooverlap_trends_D107.dat allDE_edgeR_sig0.05_1.5f_nooverlap_trends_8579.dat>allDE_edgeR_sig0.05_1.5f_nooverlap_4_set_venn.dat
#venn diagram from DESeq
perl make_4_set_venneuler_ncu.pl allDE_DESeq_sig0.05_1.5f_nooverlap_trends_2489.dat allDE_DESeq_sig0.05_1.5f_nooverlap_trends_D115.dat allDE_DESeq_sig0.05_1.5f_nooverlap_trends_D107.dat allDE_DESeq_sig0.05_1.5f_nooverlap_trends_8579.dat>allDE_DESeq_sig0.05_1.5f_nooverlap_4_set_venn_ncu.dat

perl make_4_set_venneuler.pl allDE_DESeq_sig0.05_1.5f_nooverlap_trends_2489.dat allDE_DESeq_sig0.05_1.5f_nooverlap_trends_D115.dat allDE_DESeq_sig0.05_1.5f_nooverlap_trends_D107.dat allDE_DESeq_sig0.05_1.5f_nooverlap_trends_8579.dat>allDE_DESeq_sig0.05_1.5f_nooverlap_4_set_venn.dat
#venn diagram from all
perl make_4_set_venneuler_ncu.pl allDE_sig0.05_1.5f_nooverlap_trends_2489.dat allDE_sig0.05_1.5f_nooverlap_trends_D115.dat allDE_sig0.05_1.5f_nooverlap_trends_D107.dat allDE_sig0.05_1.5f_nooverlap_trends_8579.dat>allDE_sig0.05_1.5f_nooverlap_4_set_venn_ncu.dat

perl make_4_set_venneuler.pl allDE_sig0.05_1.5f_nooverlap_trends_2489.dat allDE_sig0.05_1.5f_nooverlap_trends_D115.dat allDE_sig0.05_1.5f_nooverlap_trends_D107.dat allDE_sig0.05_1.5f_nooverlap_trends_8579.dat>allDE_sig0.05_1.5f_nooverlap_4_set_venn.dat
