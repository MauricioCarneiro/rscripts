library("ggplot2")

agilent <- read.table("/humgen/gsa-hpprojects/dev/carneiro/wex_refbias/agilent.refbias.grp", header=T, quote="\"")
illumina <- read.table("/humgen/gsa-hpprojects/dev/carneiro/wex_refbias/illumina.refbias.grp", header=T, quote="\"")
wgs <- read.table("/humgen/gsa-hpprojects/dev/carneiro/wex_refbias/wgs.refbias.grp", header=T, quote="\"")

qplot(RefBias, data=agilent)
qplot(RefBias, data=wgs)

d = merge(agilent, wgs, by="Site")

qplot(RefBias.x, RefBias.y, data=subset(d, GQ.x > 50 & GQ.y > 50), xlim=c(0,1), ylim=c(0,1), alpha=I(0.5)) + geom_abline(intercept=0, slope=1, linetype="dashed")