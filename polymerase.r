require("ggplot2")

d <- read.delim("/humgen/gsa-hpprojects/dev/carneiro/tsca/analysis/polymerase.tbl", header=T)

qplot(polymerase, indel, data=d, color=polymerase, geom="polygon", main="performance of different polymerases on TSCA data", xlab="polymerase", ylab="indel error rate") + theme_bw() + scale_color_discrete(guide="none")
qplot(polymerase, mismatch, data=d, color=polymerase, geom="polygon", main="performance of different polymerases on TSCA data", xlab="polymerase", ylab="mismatch error rate") + theme_bw() + scale_color_discrete(guide="none")
qplot(mismatch, indel, data=d, color=polymerase, size=2, main="performance of different polymerases on TSCA data", xlab="mismatch error rate", ylab="indel error rate") + scale_size(guide="none") + theme_bw()