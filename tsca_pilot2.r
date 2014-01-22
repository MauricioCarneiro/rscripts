library("ggplot2")

k25 <- read.table("/humgen/gsa-hpprojects/dev/carneiro/degen/data/pilot2/kapa25.bpa.grp", header=T, quote="\"")

## Distribution of barcode counts per amplicon
qplot(as.factor(Start), Count, group=Start, data=k25, ylim=c(0,150), geom="boxplot", main="Distribution of barcode counts per amplicon", xlab="Amplicon start location", ylab="Barcode counts") + theme(axis.text.x=element_text(angle=90))

## Number of distinct barcodes per amplicon
x = as.data.frame(table(k25$Start))
names(x) <- c("Start", "Barcodes")
qplot(reorder(as.factor(Start), Barcodes), Barcodes, data=x, xlab="Amplicon start location", ylab="Number of distinct barcodes", main="Distinct barcodes per amplicon") + theme(axis.text.x=element_text(angle=90))

## Total number of reads per barcode (across amplicons)
d <- read.delim("/humgen/gsa-hpprojects/dev/carneiro/degen/data/pilot2/kapa25.bpa.grp.tbl", header=F)
d = d[order(d$V2),]
qplot(reorder(V1, V2), V2, data=d, main="Total number of reads per barcode", xlab="Barcode", ylab="Total number of reads") + theme_gray() + theme(axis.text.x=element_text(angle=90))
qplot(reorder(V1, V2), V2, data=subset(d, V2 > 120), main="High performing barcodes", xlab="Barcode", ylab="Total number of reads") + theme_gray() + theme(axis.text.x=element_text(angle=90))
qplot(reorder(V1, V2), V2, data=subset(d, V2 > 1 & V2 < 5), main="Low performing barcodes", xlab="Barcode", ylab="Total number of reads") + theme_gray() + theme(axis.text.x=element_text(angle=90))

## Error rate per cycle
d <- cbind(read.delim("/humgen/gsa-hpprojects/dev/carneiro/degen/data/pilot2/kapa25.bam.db.tbl"), dataset="kapa")
d <- rbind(d, cbind(read.delim("/humgen/gsa-hpprojects/dev/carneiro/degen/data/pilot2/gotaq25.bam.db.tbl"), dataset="gotaq"))
qplot(ReadPosition, Mismatches/TotalBases, color=dataset, data=d, geom="jitter", main="Error rate per cycle", ylab = "Mismatch proportion") + geom_hline(yintercept = median(d$Mismatches/d$TotalBases), linetype="dashed", color=I("red")) + geom_hline(yintercept = mean(d$Mismatches/d$TotalBases), linetype="dashed", color=I("blue"))
