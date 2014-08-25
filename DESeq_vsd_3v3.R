rm(list=ls())

library(DESeq) 

countsTable = read.table("readcount.dat",header=TRUE,sep="\t",row.names=1)

head(countsTable)

conds<- c("Before","Before","Before","After","After","After")

cds3<-newCountDataSet(countsTable, conds)

head(counts(cds3))

libsizes<- scan("libsize.dat")

sizeFactors(cds3)<-libsizes

sizeFactors( cds3 )

cds3 <- estimateVarianceFunctions( cds3 )

pdf("out_scvPlot.pdf")
scvPlot(cds3)
dev.off()

vsd <- getVarianceStabilizedData( cds3 )

head( vsd )

dists <- dist( t( vsd ) )
pdf("out_heatmap_DESeq.pdf")
heatmap( as.matrix( dists ), symm=TRUE )
dev.off()
diagForT <- varianceFitDiagnostics(cds3 , "Before" )

head( diagForT )

pdf("out_smoothScatter_DESeq.pdf")
smoothScatter( log10(diagForT$baseMean), log10(diagForT$baseVar) )

lines( log10(fittedBaseVar) ~ log10(baseMean),diagForT[ order(diagForT$baseMean), ], col="red" )
box()
dev.off()

pdf("out_residualEcdPlot_DESeq.pdf")
par( mfrow=c(1,2 ) )

residualsEcdfPlot( cds3, "Before" )

residualsEcdfPlot( cds3, "After" )

box()
dev.off()
res <- nbinomTest( cds3, "Before", "After" )

pdf("out_DESeq_MAplot.pdf")
plot(res$baseMean,res$log2FoldChange,log="x",pch=20,cex=.1,col=ifelse(res$padj<.1,"red","black"),ylim=c(-5,5))
abline(h = c(-log2(1.5), log2(1.5)), col = "dodgerblue")
box()
dev.off()
write.table(res,file="DESeq.dat", sep="\t",quote=FALSE,col.names=TRUE)
