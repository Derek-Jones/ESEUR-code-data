#
# WSPP.R,  25 Aug 15
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

plot_layout(1, 2)

plot_dot=function(dot_file)
{
interest=read.dot(paste0(ESEUR_dir, "communicating/WSPP/", dot_file))
dimnames(interest)[[1]]=gsub("\"", "", dimnames(interest)[[1]])
dimnames(interest)[[2]]=gsub("\"", "", dimnames(interest)[[2]])
dimnames(interest)[[1]]=gsub("MS-", "", dimnames(interest)[[1]])
dimnames(interest)[[2]]=gsub("MS-", "", dimnames(interest)[[2]])

interest_gr=graph.adjacency(interest, mode="directed")

# V(interest_gr)[names(in_deg)]$size=3+in_deg^0.7
V(interest_gr)$size=1
# V(interest_gr)$color=brew_col[4]
V(interest_gr)$label.cex=0.75
E(interest_gr)$arrow.size=0.3

plot(interest_gr)
}


plot_dot("all.dot")
plot_dot("interest.dot")

