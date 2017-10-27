#
# stake-network-cent.R, 16 Oct 17
#
# Data from:
# Social Networks and Collaborative Filtering for Large-Scale Requirements Elicitation
# Soo Ling Lim
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("igraph")


pal_col=rainbow(2)

# Source	Stakeholder	Priority
# Aaron Toms	Andy Hicks	10
closed_rec=read.csv(paste0(ESEUR_dir, "projects/requirements/ClosedR.txt.xz"),
			as.is=TRUE, sep="\t")
open_rec=read.csv(paste0(ESEUR_dir, "projects/requirements/OpenR.txt.xz"),
			as.is=TRUE, sep="\t")

closed_graph=graph.data.frame(closed_rec)
open_graph=graph.data.frame(open_rec)

# The edge attribute has to have the name 'weights' for it to
# be implicitly used, otherwise the paramater has to be specified
closed_p_r=page.rank(closed_graph, weights=closed_rec$Priority)
open_p_r=page.rank(open_graph, weights=open_rec$Priority)

plot(sort(open_p_r$vector, decreasing=TRUE), log="y", col=pal_col[1],
		 xlab="Stakeholder", ylab="Salience\n")
points(sort(closed_p_r$vector, decreasing=TRUE), col=pal_col[2])

x=1:length(open_p_r$vector)
y=sort(open_p_r$vector, decreasing=TRUE)

pr_nls=nls(y ~ a*x^b, start=list(a=2, b=-1))

# summary(pr_nls)

lines(predict(pr_nls), col=pal_col[1])

# 36 looks like a reasonable value from the plot
x_boundary=36
x=1:x_boundary
y=sort(closed_p_r$vector, decreasing=TRUE)
y=y[x]

pr_nls=nls(y ~ a*exp(x*b), start=list(a=1e-2, b=-0.5))

# summary(pr_nls)

lines(predict(pr_nls), col=pal_col[2])

x=(x_boundary+1):length(closed_p_r$vector)
y=sort(closed_p_r$vector, decreasing=TRUE)
y=y[x]

pr_nls=nls(y ~ a*exp(x*b), start=list(a=1e-2, b=-0.05))

# summary(pr_nls)

lines(x, predict(pr_nls), col=pal_col[2])


