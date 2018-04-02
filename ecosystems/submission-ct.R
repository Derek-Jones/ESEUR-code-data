#
# submission-ct.R, 15 Mar 18
# Data from:
# Exploring Network Modelling and Strategy in the {Dutch} Product Software Ecosystem
# Wesley Crooymans and Priyanka Pradhan and Slinger Jansen
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library(igraph)


plot_layout(1, 1, default_width=ESEUR_default_width+2,
                        default_height=ESEUR_default_height+2)


cust_sup=read.csv(paste0(ESEUR_dir, "ecosystems/submission-ct.csv.xz"), as.is=TRUE)

t=as.data.frame(table(cust_sup$Target))
cust_sup$in_weight=t$Freq[t$Var1[cust_sup$Target]]


cust_sup$Source[which(table(cust_sup$Source) > 10)]

cust_graph=graph.data.frame(cust_sup, directed=TRUE)

V(cust_graph)$frame.color=NA
V(cust_graph)$color="red"
V(cust_graph)$size=2
t=as.data.frame(table(cust_sup$Target))
V(cust_graph)[t$Var1]$size=(3+t$Freq)^0.8 # suck it and see
V(cust_graph)$label.cex=0.1

E(cust_graph)$width=E(cust_graph)$in_weight/max(E(cust_graph)$in_weight)
E(cust_graph)$weight=1/(4+E(cust_graph)$in_weight) # more s-i-a-s
E(cust_graph)$color="grey"
E(cust_graph)$arrow.size=0.1

par(cex=0.9)

plot(cust_graph)

