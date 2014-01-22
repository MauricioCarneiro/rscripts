library("ggplot2")

t <- read.table("/humgen/gsa-hpprojects/dev/carneiro/dwn_exome/coverage.tbl", header=T)
m <- melt(t, id.vars="cov")
qplot(cov, value, group=variable, color=variable, data=m, geom="line") + scale_x_discrete(breaks=m$cov) + scale_color_discrete(breaks= c("u10","u4"), labels= c("< 10x", "< 4x"))