#
# alaris.R, 17 Dec 19
#
# Data from:
# Devices, Errors and Improving Interaction Design - A case study using an Infusion Pump
# Patrick Oladimeji
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG errors user-interface hardware


source("ESEUR_config.r")

library(igraph)
library(jsonlite)
library(plyr)


plot_wide()


#    {
#        "stateName":"Show_Volume_Infused",
#        "stateType":"single",
#        "neighbours":[{"stateName":"SetRate","button":"Opt3"},
#                                  {"stateName":"Off","button":"Power"},
#                      {"stateName":"SetRate","button":"Opt2"}]
#    },

get_transition=function(df)
{
t=ldply(df$neighbours, function(n) data.frame(stateName=n["stateName"], button=n["button"]))

# The call to igraph needs the first two columns to have specific names
res=data.frame(from=df$stateName, to=t$stateName, button=t$button)

# print(res)

return(res)
}


alaris=fromJSON(paste0(ESEUR_dir, "probability/Patrick_Oladimeji-alaris.json"))


t_fsm=adply(alaris$"device spec", 1, get_transition)
# graph.data.frame requires that from/to be the first and second columns :-|
fsm=data.frame(from=t_fsm$from, to=t_fsm$to, button=t_fsm$button)

fsm_graph=graph.data.frame(fsm, directed=TRUE)

V(fsm_graph)$frame.color=NA
V(fsm_graph)$color="yellow"
V(fsm_graph)$size=3
V(fsm_graph)$label.cex=0.9

E(fsm_graph)$color="red"
E(fsm_graph)$arrow.size=0.2

par(cex=0.9)
plot(fsm_graph, edge.width=0.3, edge.curved=TRUE)

# average.path.length(fsm_graph)

# path.length.hist(fsm_graph)

# Graph has a singular matrix
# alpha.centrality(fsm_graph)

