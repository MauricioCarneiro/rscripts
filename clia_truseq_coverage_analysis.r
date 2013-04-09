require("ggplot2")

uncovered <- function(data, t) {
  data_points = length(data$POS)
  percent_uncovered <- length(data[data$AVG_INTERVAL_DP/12 < t,]$POS) / data_points
  cat(percent_uncovered, percent_uncovered * data_points)
}

load_downsampled_datasets = function (filename) {
  master = cbind("10%", read.delim(paste("/humgen/gsa-hpprojects/dev/carneiro/clia/analysis/illumina_exome/downsample/down-0.1/", filename, sep = "")))
  names(master) <- c("dataset", names(master)[-1])
  for (target in c(20, 30, 40, 50, 70, 80)) {
    tmp <- cbind(paste(target, "%", sep=""), read.delim(paste("/humgen/gsa-hpprojects/dev/carneiro/clia/analysis/illumina_exome/downsample/down-0.", target/10, "/", filename, sep = "")))
    names(tmp) <- names(master)
    master <- rbind(master, tmp)  
  }
  master
}


## individual datasets

original <- read.delim("/humgen/gsa-hpprojects/dev/carneiro/clia/analysis/illumina_exome/cds/master_cds_gencodeV15.intervals.tbl")
#d <- read.delim("/Volumes/Lothlorien/Dropbox/sandbox/clia/untargeted.tbl")
#d <- read.delim("/humgen/gsa-hpprojects/dev/carneiro/clia/analysis/illumina_exome/cancer/cancer.tbl")

qplot(AVG_INTERVAL_DP/12, data=d, geom="density", fill="red", xlab="Average depth per sample", ylab="% targets") + geom_vline(xintercept=20, linetype="dashed") + scale_fill_discrete(guide = "none")
qplot(FILTER, data=subset(d, FILTER != "PASS")) + theme(axis.text.x = element_text(angle=90, hjust=1))


#Downsampled datasets
d = load_downsampled_datasets("master_cds_gencodeV15.intervals.vcf.tbl")
uncovered(d=subset(d, dataset=="10%"), 20)
uncovered(d=subset(d, dataset=="20%"), 20)
uncovered(d=subset(d, dataset=="30%"), 20)
uncovered(d=subset(d, dataset=="40%"), 20)
uncovered(d=subset(d, dataset=="50%"), 20)
uncovered(d=subset(d, dataset=="70%"), 20)
uncovered(d=subset(d, dataset=="80%"), 20)

qplot(AVG_INTERVAL_DP/12, data=genetest, geom="density", fill=dataset, alpha=0.2, group=dataset, xlab="Average depth per sample", ylab="% targets") + geom_vline(xintercept=20, linetype="dashed") + scale_alpha(guide="none")
