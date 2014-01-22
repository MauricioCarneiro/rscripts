library("ggplot2")

cont <- read.delim("/humgen/gsa-hpprojects/dev/carneiro/daly_ice/analysis/contamination.txt", header=F)
names(cont) <- c("sample", "freemix")
cont <- cont[order(cont$freemix),]

qplot(sample, freemix, data=subset(cont, freemix > 0.02)) + theme(axis.text.x=element_text(angle=90))