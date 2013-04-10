require("ggplot2")
require("reshape2")
#d <- read.delim("/Volumes/Lothlorien/Dropbox/sandbox/clia/cancerpanel.diagnose.tbl")
d <- read.delim("/humgen/gsa-hpprojects/dev/carneiro/tsca/analysis/eomi_rerun.pool1.diagnose.vcf.tbl")
d <- read.delim("/humgen/gsa-hpprojects/dev/carneiro/tsca/analysis/eomi_rerun.pool2.diagnose.vcf.tbl")
d <- d[with(d, order(AVG_INTERVAL_DP)), ]
d <- cbind(1:length(d[,1]), d)
names(d) <- c("id", names(d)[2:length(d)])
m = melt(d, id.vars="id", measure.vars=names(d)[6:length(d)])


qplot(id, value, group=id, data=m, geom="boxplot", xlab = "target", ylab="median depth", main="TSCA: depth distribution per sample for each target") + geom_hline(yintercept=20, linetype="dashed")
qplot(variable, value, group=variable, data=m, geom="boxplot", xlab = "", ylab="median depth", main="TSCA: sample coverage across intervals") + theme(axis.text.x=element_text(angle=90)) + geom_hline(yintercept=20, linetype="dashed")
qplot(id, value, alpha=0.1, data=m, geom="point", color=variable,  xlab = "target", ylab="median depth", main="TSCA: depth distribution per sample for each target") + geom_hline(yintercept=20, linetype="dashed") + scale_color_discrete(guide="none") + scale_alpha_continuous(guide="none")

