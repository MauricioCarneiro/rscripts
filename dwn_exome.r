# Impact of downsampling the exome

library("ggplot2")
library("gsalib")

percent_under <- function(x) {
  100 * sum(d[1:x,]$Count) / sum(d$Count)
}

args <- commandArgs(trailingOnly = TRUE)
fname <- args[1] # gatk report file
tcov <- as.numeric(args[2]) * 350  # target coverage

report <- gsa.read.gatkreport(fname)
d <- report$BaseCoverageDistribution

actual_mean_cov <- sum(as.numeric(d$Coverage * d$Count))/sum(d$Count)
title <- sprintf("Target Mean coverage: %.0f, Actual Mean coverage: %.2f, Under 4x: %.2f%%, Under 10x: %.2f%%", tcov, actual_mean_cov, percent_under(4), percent_under(10))

pdf(sprintf("%s.pdf", fname), width=12)
qplot(Coverage, Count, data=d, geom="area", fill = I("red"), xlim=c(0,150), main = title) +
  geom_vline(xintercept=4, linetype="dotted") +
  geom_vline(xintercept=10, linetype="dashed")
dev.off()