require("ggplot2")

uncovered <- function(data, t) {
  data_points = length(data$POS)
  percent_uncovered <- length(data[data$AVG_INTERVAL_DP/12 < t,]$POS) / data_points
  percent_uncovered * data_points
}

load_downsampled_datasets = function (filename) {
  z <- data.frame()  
  master <- cbind("100%", read.delim("/humgen/gsa-hpprojects/dev/carneiro/clia/analysis/illumina_exome/cds/master_cds_gencodeV15.intervals.tbl"))  
  names(master) <- c("dataset", names(master)[-1])
  for (target in c(90, 80, 70, 60, 50, 40, 30, 25, 20, 17, 15, 12, 10)) {
    tmp <- cbind(paste(target, "%", sep=""), read.delim(paste("/humgen/gsa-hpprojects/dev/carneiro/clia/analysis/illumina_exome/downsample/down-0.", target, "/", filename, sep = "")))
    names(tmp) <- names(master)
    master <- rbind(tmp, master)  
    z <- rbind(z, c((target/100) * median(original$AVG_INTERVAL_DP/12), uncovered(tmp, 20)))
  }
  names(z) = c("ds", "uncovered")
  list(master, z)
}


## individual datasets

original <- read.delim("/humgen/gsa-hpprojects/dev/carneiro/clia/analysis/illumina_exome/cds/master_cds_gencodeV15.intervals.tbl")
cser <- read.delim("/humgen/gsa-hpprojects/dev/carneiro/clia/analysis/illumina_exome/cser-genetest/GeneTest-transcripts-130221.intervals.vcf.tbl")
canseq <- read.delim("/humgen/gsa-hpprojects/dev/carneiro/clia/analysis/illumina_exome/cancer/canseq_genes.tbl")

qplot(AVG_INTERVAL_DP/12, data=original, geom="density", fill="red", xlab="Average depth per sample", ylab="% targets") + geom_vline(xintercept=20, linetype="dashed") + scale_fill_discrete(guide = "none")
qplot(FILTER, data=subset(d, FILTER != "PASS")) + theme(axis.text.x = element_text(angle=90, hjust=1))


#Downsampled datasets
x = load_downsampled_datasets("master_cds_gencodeV15.intervals.vcf.tbl")
d = x[[1]]
z = x[[2]]
rm(x)

uncovered(d=subset(d, dataset=="10%"), 20)
uncovered(d=subset(d, dataset=="20%"), 20)
uncovered(d=subset(d, dataset=="30%"), 20)
uncovered(d=subset(d, dataset=="40%"), 20)
uncovered(d=subset(d, dataset=="50%"), 20)
uncovered(d=subset(d, dataset=="60%"), 20)
uncovered(d=subset(d, dataset=="70%"), 20)
uncovered(d=subset(d, dataset=="80%"), 20)
uncovered(d=subset(d, dataset=="90%"), 20)

qplot(AVG_INTERVAL_DP/12, data=subset(d, dataset=="10%" | dataset=="20%" | dataset=="30%" | dataset=="40%" | dataset=="50%"| dataset=="60%" | dataset=="70%" | dataset =="80%" | dataset == "90%" | dataset == "100%"), geom="density", fill=dataset, alpha=0.1, group=dataset, xlab="Average depth per target", ylab="% targets", xlim = c(0, 600)) + geom_vline(xintercept=20, linetype="dashed") + scale_alpha(guide="none") + scale_fill_hue(name="target coverage", labels=signif(seq(0.1, 1, 0.1) * median(original$AVG_INTERVAL_DP/12), digits=2))
qplot(ds, uncovered, data=z, ylab="# targets under 20x coverage", xlab="target median coverage") + geom_smooth()