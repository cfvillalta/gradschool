rm(list=ls())
library(edgeR)

exp = read.table("readcount.dat",header=TRUE,sep="\t",row.names=1)

NCUids = row.names(exp)

lib_size = scan("libsize.dat")

total_genes = nrow(exp)

group <- c(0,0,0,1,1,1)

d<-DGEList(exp, group = group, lib.size=lib_size)

d <- estimateCommonDisp(d)

prior.n <- estimateSmoothing(d)
prior.n

d <- estimateTagwiseDisp(d, prior.n = 10, grid.length = 500)

de.tgw <- exactTest(d,common.disp=FALSE)

p_qval<-topTags(de.tgw, n=total_genes)

sig<-sum(p.adjust(de.tgw$table$p.value, method="fdr")<0.05)

de_sig <-rownames(topTags(de.tgw,n=sig)$table)

pdf(file="out_edgeR.pdf")

plotSmear(d, de.tags = de_sig, main = "logFC vs logConc edgeR plot", ylim=c(-4,4),xlim=c(-25,0))

abline(h = c(-log2(1.5), log2(1.5)), col = "dodgerblue")

box()

dev.off()

write.table(p_qval$table,file="edgeR.dat", sep="\t",quote=FALSE,col.names=TRUE)

p_qval_sig <- topTags(de.tgw, n=sig)

write.table(p_qval_sig$table,file="edgeR_sig0.05.dat", sep="\t",quote=FALSE,col.names=TRUE)
