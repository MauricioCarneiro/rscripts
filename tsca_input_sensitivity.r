library("ggplot2")
EXPECTED_SNPS <- 716
EXPECTED_INDELS <- 68
d <- read.table("/humgen/gsa-hpprojects/dev/carneiro/tsca_input/aggregate.tbl", quote="\"")
names(d) <- c("condition", "variant", "status", "count")

plot <- function(p) {
  p + theme(axis.text.x = element_text(angle=90))
}

snps_plot <- qplot(condition, count/EXPECTED_SNPS, 
      data=subset(d, status=="TRUE_POSITIVE" & variant == "SNPS"), 
      group=condition, 
      facets=.~variant, 
      geom="point",
      ylab="sensitivity") + 
  geom_hline(yintercept=0.82, linetype="dashed")

indels_plot <- qplot(condition, count/EXPECTED_INDELS, 
      data=subset(d, status=="TRUE_POSITIVE" & variant == "INDELS"), 
      group=condition, 
      facets=.~status, 
      geom="point",
      ylab="sensitivity") + 
  geom_hline(yintercept=0.88, linetype="dashed")

plot(snps_plot)
plot(indels_plot)

