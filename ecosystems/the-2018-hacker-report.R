#
# the-2018-hacker-report.R, 26 May 19
# Data from:
# The 2018 Hacker Report
# HackerOne
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG bug_bounties faults country money


source("ESEUR_config.r")


library("riverplot")

pal_col=rainbow(2)

plot_layout(1, 1, default_height=12)

par(mar=MAR_default+c(0, 0.6, 0, 0.4))


hr=read.csv(paste0(ESEUR_dir, "ecosystems/the-2018-hacker-report.csv.xz"), as.is=TRUE)

# Append space to stop numbers disappearing off the plot area
edges=data.frame(N1=c(paste0(hr$from_country, " $", hr$from_amount),
			 rep(" ", length(hr$to_country))),
		 N2=c(rep(" ", length(hr$from_country)),
			 paste(hr$to_country, " $", hr$to_amount, "            ")),
		 Value=c(hr$from_amount, hr$to_amount),
		 stringsAsFactors=FALSE)

# edges$edgecol="col"

# Need one 'space' node
nodes=data.frame(ID=c(edges$N1[1:nrow(hr)], " ", edges$N2[-(1:nrow(hr))]),
				stringsAsFactors=FALSE)
nodes$x=c(rep(1, length(hr$from_country)), 2, rep(3, length(hr$to_country)))
nodes$srt=45

rownames(nodes)=nodes$ID

# rep(list(col="red", srt=45), ...) does not work as expected
cr=list(col=pal_col[1], srt=45, textpos=2)
from_country=rep(list(cr), length(hr$from_country))
names(from_country)=edges$N1[1:nrow(hr)]
cb=list(col=pal_col[2], srt=-45, textpos=4)
to_country=rep(list(cb), length(hr$to_country))
names(to_country)=edges$N2[-(1:nrow(hr))]

styles=c(from_country, " "=list(col="black"), to_country)

rp=list(nodes=nodes, edges=edges, styles=styles)
class(rp)=c(class(rp), "riverplot")

# plot(rp, srt=0, col="yellow")
plot(rp, xscale=0.8)

