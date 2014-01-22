d <- read.delim("/humgen/gsa-hpprojects/dev/carneiro/tsca_input/gigabases.tbl", header=F)
names(d) <- c("condition", "count")
qplot(condition, count/1000000000, 
      data=d,
      ylab="gigabases produced") +
  theme(axis.text.x = element_text(angle=90)) +
  geom_hline(yintercept=mean(d$count/1000000000), linetype="dashed")