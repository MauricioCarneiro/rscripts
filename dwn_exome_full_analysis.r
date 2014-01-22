library("gsalib")
library("ggplot2")
library("reshape2")

# Make sure to set the directory where the files are for the analysis
# 
setwd("/humgen/gsa-hpprojects/dev/carneiro/se_wex/large/")
techs <- c("se") # choose the name of the different technologies ran here (e.g. c("Agilent", "Illumina"))
#
# Important setup ends here.

percent_under <- function(d, x) {
  100 * sum(d[1:x,]$Count) / sum(d$Count)
}

parse_cov <- function(file){
  report <- gsa.read.gatkreport(file)
  d <- report$BaseCoverageDistribution
  actual_mean_cov <- sum(as.numeric(d$Coverage * d$Count))/sum(d$Count)  
  c(as.numeric(sprintf("%.f", actual_mean_cov)), percent_under(d, 20), percent_under(d, 10), percent_under(d, 4))
}

parse_kb <- function(file) {
  d <- gsa.read.gatkreport(file)$NA12878Assessment
}

infiles <- dir(pattern='\\.cov.grp$')
d <- data.frame()
for (file in infiles) {
  d <- rbind(d, parse_cov(file))  
}
names(d) <- c("Coverage", ">20x", ">10x", ">4x")

d <- cbind(Tech=techs, d)
reps <- length(d$Coverage) / length(techs)
start <- 1
for (i in 1:length(techs)) {
  d[seq(start, start+reps-1),"Tech"] <- rep(techs[i], reps)
  start <- start + reps
}

d <- cbind(d, Bases=read.table("totalGB.tbl")$V2)
m <- melt(d, id.vars=c("Coverage", "Tech", "Bases"))

kbfiles <- dir(pattern='\\.kb.grp$')
i <- data.frame()
for (file in kbfiles) {
  i <- rbind(i, parse_kb(file))  
}
half <- ceiling(length(i$Name)/2)
i <- rbind(cbind(Tech="agilent", i[1:half,]), cbind(Tech="illumina", i[(half+1):length(i$Name),]))
i <- cbind(Coverage=rep(d$Coverage, each=4), i)
i <- cbind(Bases=rep(d$Bases, each=4), i)
false_positives <- i$FALSE_POSITIVE_SITE_IS_FP + i$FALSE_POSITIVE_MONO_IN_NA12878 #+ i$CALLED_NOT_IN_DB_AT_ALL
i <- cbind(i, Sensitivity=as.numeric(i$TRUE_POSITIVE / (i$TRUE_POSITIVE + i$FALSE_NEGATIVE_CALLED_BUT_FILTERED + i$FALSE_NEGATIVE_NOT_CALLED_BUT_LOW_COVERAGE + i$FALSE_NEGATIVE_NOT_CALLED_AT_ALL)))
i <- cbind(i, Specificity=as.numeric( false_positives / (false_positives + i$TRUE_POSITIVE )))
m2 <- melt(i, id.vars=c("Tech", "Bases", "Coverage", "VariantType", "Name"), measure.vars=c("Sensitivity", "Specificity"))

qplot(Coverage, 100-value, group=Tech, facets = variable ~ ., colour=Tech, data=m, geom="line", ylab="% bases covered") + geom_hline(yintercept = 80, linetype = "dashed") + scale_x_continuous(breaks=seq(0,max(d$Coverage),10))
qplot(Bases/1e9, 100-value, group=Tech, facets = variable ~ ., colour=Tech, data=m, geom="line", xlab = "gigabases produced", ylab="% bases covered") + geom_hline(yintercept = 80, linetype = "dashed") + scale_x_continuous(breaks=seq(0,max(d$Bases)/1e9, 2))
qplot(Coverage, value, group=interaction(Tech,Name), data=subset(m2, variable == "Sensitivity"), facets = VariantType ~ ., geom="line", color=interaction(Tech,Name), ylab = "sensitivity") + scale_x_continuous(breaks=seq(0, max(d$Coverage), 10))
qplot(Bases/1e9, value, group=interaction(Tech, Name), data=subset(m2, variable == "Sensitivity"), facets = VariantType ~ ., geom="line", color=interaction(Tech, Name), xlab = "gigabases produced", ylab = "sensitivity") + scale_x_continuous(breaks=seq(0,max(d$Bases)/1e9, 2))
qplot(Coverage, value, group=interaction(Tech, Name), data=subset(m2, variable == "Specificity"), facets = VariantType ~ ., geom="line", color=interaction(Tech, Name), ylab = "false positive rate") + scale_x_continuous(breaks=seq(0, max(d$Coverage), 10))
qplot(Bases/1e9, value, group=interaction(Tech, Name), data=subset(m2, variable == "Specificity"), facets = VariantType ~ ., geom="line", color=interaction(Tech, Name), xlab = "gigabases produced", ylab = "false positive rate") + scale_x_continuous(breaks=seq(0,max(d$Bases)/1e9, 2))