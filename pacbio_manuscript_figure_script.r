library("ggplot2")

d = read.csv("/Volumes/Lothlorien/Dropbox/GSA members/Slide Archive/carneiro/Manuscripts/PacbioPerspective/figure_data.csv")
p = ggplot(d, aes(Context, Qempirical, colour=ReadGroup)) + geom_point(aes(size=2))
p = p + labs( x = "Sequencing context preceding insertion", 
              y = "Empirical insertion quality score", 
         colour = "Sequencing Platform", 
          title = "Empirical insertion quality of sequencing context")

p = p + scale_colour_discrete(labels=c("Illumina HiSeq 2000", "Pacific Biosciences RS")) + scale_size(guide = "none")

p + theme(     axis.text.x = element_text(angle = 90, hjust = 1), 
              panel.border = element_rect(color = "black", fill = NA),
          panel.background = element_rect(fill = NA), 
                      text = element_text(size = 15), 
               legend.text = element_text(size = 13),
                 axis.text = element_text(color = "black"),
                panel.grid = element_blank(),
           legend.position = c(0.92, 0.35),
          legend.background = element_rect(linetype = 1, fill = "white", color = "black")
)

