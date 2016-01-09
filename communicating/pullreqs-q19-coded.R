#
# pullreqs-q19-coded.R,  8 May 15
#
# Data from:
# Work Practices and Challenges in Pull-Based Development: {The} Integrator's Perspective
# Georgios Gousios and Andy Zaidman and Margaret-Anne Storey and Arie van Deursen
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


# From github
library("alluvial")
library("plyr")


pullreqs=read.csv(paste0(ESEUR_dir, "communicating/pullreqs-q19-coded.csv.xz"), as.is=TRUE)


to.plot = subset(pullreqs, tag1 != "")
to.plot = subset(to.plot, tag1 !="no prioritization")
to.plot = subset(pullreqs, tag2 != "")

to.plot = ddply(to.plot[,-1], .(tag1,tag2,tag3), nrow) 
to.plot = rename(to.plot, replace=c("V1"="Freq"))
to.plot = rename(to.plot, replace=c("tag1"="Q 1"))
to.plot = rename(to.plot, replace=c("tag2"="Q 2"))
to.plot = rename(to.plot, replace=c("tag3"="Q 3"))

# top_15=head(sort(to.plot$Freq, decreasing=TRUE), n=15)

colour = function(line) {
    if (line[3] == "") {
      if (line[2] == "") {
        "yellow"
      } else {
        "grey"
      }
    } else {
      "red"
    }
  }

alluvial(to.plot[, 1:3],
           freq=to.plot$Freq,
           border=NA,
	   hide = to.plot$Freq < quantile(to.plot$Freq, .50),
#           hide = to.plot$Freq < min(top_15),
           col= apply(to.plot, 1, colour))
#           col= rainbow_hcl(nrow(to.plot)))


