d <- read.delim("/humgen/gsa-hpprojects/dev/carneiro/tsca_input/coverage.tbl", header=F)
names(d) <- c("condition", "count")
qplot(condition, count/4458, 
      data=d,
      ylab="% targets passing filters") +
  theme(axis.text.x = element_text(angle=90))