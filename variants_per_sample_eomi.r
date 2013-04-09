require("ggplot2")
v <- read.table("/humgen/gsa-hpprojects/dev/carneiro/eomi/analysis/noReadPos/nVariantsBySample.tbl", quote="\"")
v <- data.frame(cbind(c(1:length(v$V1)), v$V1))

qplot(X1, X2,data=v, xlab="Sample index", ylab="Total Variants", main="Total number of variants per sample") + 
  geom_hline(yintercept=mean(v$X2) + 3*sd(v$X2), linetype="dashed") +
  geom_hline(yintercept=mean(v$X2) - 3*sd(v$X2), linetype="dashed") +
  theme_bw()
  