trio <- read.delim("~/Dropbox/sandbox/trio.tbl")
p101 <- read.delim("~/Dropbox/sandbox/101.tbl")
p250 <- read.delim("~/Dropbox/sandbox/250.tbl")
d <- merge(trio, p101, by="POS")
names(d) <- c("POS", "PCR", "FREE")
qplot(PCR, FREE, data=d, xlim=c(0,50), main="coverage over poorly covered targets", ylab="PCR FREE", xlab="PCR PLUS", ylim=c(0,50), size=2, alpha=0.5) + geom_abline(intercept=0, slope=1, linetype="dashed") + geom_rug(alpha=0.1) + theme_bw() + scale_alpha(guide="none") + scale_size(guide="none")