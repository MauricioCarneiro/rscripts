require("ggplot2")
require("reshape2")
d <- read.delim("/Volumes/Lothlorien/Dropbox/sandbox/clia/cancerpanel.diagnose.tbl")
d <- d[with(d, order(AVG_INTERVAL_DP)), ]
d <- cbind(1:length(d[,1]), d)
names(d) <- c("id", names(d)[2:length(d)])
m = melt(d, id.vars="id", measure.vars=names(d)[5:length(d)])


qplot(id, value, group=id, data=m, geom="boxplot", xlab = "target", ylab="median depth", main="TSCA: depth distribution per sample for each target")
qplot(variable, value, group=variable, data=m, geom="boxplot", xlab = "", ylab="median depth", main="TSCA: sample coverage across intervals")

