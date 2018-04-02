#
# the-2018-hacker-report.R,  6 Feb 18
# Data from:
# The 2018 Hacker Report
# HackerOne
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("riverplot")


plot_layout(1, 1, default_height=12)


hr=read.csv(paste0(ESEUR_dir, "ecosystems/the-2018-hacker-report.csv.xz"), as.is=TRUE)

# Append space to stop numbers disappearing off the plot area
edges=data.frame(N1=c(paste0(hr$from_country, " $", hr$from_amount),
			 rep(" ", length(hr$to_country))),
		 N2=c(rep(" ", length(hr$from_country)),
			 paste(hr$to_country, " $", hr$to_amount, "            ")),
		 Value=c(hr$from_amount, hr$to_amount),
		 stringsAsFactors=FALSE)

# Need to ensure there is only one 'space' node
nodes=data.frame(ID=c(unique(edges$N1), unique(edges$N2)[-1]), stringsAsFactors=FALSE)
nodes$x=c(rep(1, length(hr$from_country)), 2, rep(3, length(hr$to_country)))

rownames(nodes)=nodes$ID

rp=list(nodes=nodes, edges=edges)
class(rp)=c(class(rp), "riverplot")

plot(rp, srt=0, col="yellow")


