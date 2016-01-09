#
# Leemis-chart.R,  28 Aug 15
#
# Data from:
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# A simpler approach that using graphviz
library("igraph")
library("sna")

plot_dot=function(dot_file)
{
interest=read.dot(paste0(ESEUR_dir, "probability/Leemis-chart/", dot_file))

interest_gr=graph.adjacency(interest, mode="directed")

# V(interest_gr)[names(in_deg)]$size=3+in_deg^0.7
V(interest_gr)$size=1
# V(interest_gr)$color=brew_col[4]
V(interest_gr)$label.cex=0.8
E(interest_gr)$arrow.size=0.2

plot(interest_gr)
}



plot_dot("prob-dist.dot")
plot_dot("interest.dot")

