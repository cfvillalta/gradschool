#the script is meant to run the R package DEseq on two conditions comparing 3 bioreps of condition 1 to 3 bioreps of condition 2, the majority of the code except for the making of pdfs and making MA plots is dervied from the DESeq tutorial.
#removes any lists that  might be present in R
rm(list=ls())
#opens DESeq library
library(DESeq) 
#read the readcount data table into countsTable.
countsTable = read.table("readcount.dat",header=TRUE,sep="\t",row.names=1)
#get the first couple rows of the data
head(countsTable)
#make a array of the conditions
conds<- c("Before","Before","Before","After","After","After")
#input data and coditions into dataset for DESeq to read.
cds3<-newCountDataSet(countsTable, conds)
#check on format
head(counts(cds3))
#get libsize counts into array libsizes.
libsizes<- scan("libsize.dat")
#add that Data for analysis into using the sizeFactors command.
sizeFactors(cds3)<-libsizes
#check on data
sizeFactors( cds3 )
#estimate variance
cds3 <- estimateVarianceFunctions( cds3 )
#open a pdf called out_scvPlot.pdf
pdf("out_scvPlot.pdf")
#make scvPlot, will go to pdf
scvPlot(cds3)
#close pdf
dev.off()
#get variance stabilized data
vsd <- getVarianceStabilizedData( cds3 )
#check data
head( vsd )
#get distributions of variance stabilized data.
dists <- dist( t( vsd ) )
#open new pdf called out_heatmap_DESeq.pdf
pdf("out_heatmap_DESeq.pdf")
#draw heatmap onto pdf
heatmap( as.matrix( dists ), symm=TRUE )
#clsoe pdf
dev.off()
#running variance fit Diagnostics.
diagForT <- varianceFitDiagnostics(cds3 , "Before" )
#check data
head( diagForT )
#open new pdf to output smoothscatter plot
pdf("out_smoothScatter_DESeq.pdf")
#make smoothscatter plot
smoothScatter( log10(diagForT$baseMean), log10(diagForT$baseVar) )
#adjust colors of lines
lines( log10(fittedBaseVar) ~ log10(baseMean),diagForT[ order(diagForT$baseMean), ], col="red" )
#put a box around the plot
box()
#close pdf
dev.off()
#open pdf to output residual ecdplots from DESeq
pdf("out_residualEcdPlot_DESeq.pdf")
#make space for several plots.
par( mfrow=c(1,2 ) )
#make first plot for before data
residualsEcdfPlot( cds3, "Before" )
#make plots for after data
residualsEcdfPlot( cds3, "After" )
#box the plots
box()
#close pdf
dev.off()
#run run negative binomial test on data for two condiitons befor and after
res <- nbinomTest( cds3, "Before", "After" )
#make a pdf to plot an MA plot since its slightly different from scatterplot
pdf("out_DESeq_MAplot.pdf")
#plot out an MA plot.
plot(res$baseMean,res$log2FoldChange,log="x",pch=20,cex=.1,col=ifelse(res$padj<.1,"red","black"),ylim=c(-5,5))
#add lines to show where a 1.5 fold difference threshold is.
abline(h = c(-log2(1.5), log2(1.5)), col = "dodgerblue")
#box the graph
box()
#close the pdf
dev.off()
#write out data from DESeq negaitve binomial test into a tab delimited text file.
write.table(res,file="DESeq.dat", sep="\t",quote=FALSE,col.names=TRUE)
