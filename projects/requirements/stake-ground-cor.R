#
# stake-ground-cor.R,  4 Jan 16
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# R code for processing data from:
# Social Networks and Collaborative Filtering for Large-Scale Requirements Elicitation
# by Soo Ling Lim
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
 
source("ESEUR_config.r")

library("igraph")

get_stake_list=function(graph_list)
{
# Sort by centrality value.
# Column names are the names of the nodes.
return(names(sort(graph_list, decreasing=TRUE)))
}

weighted_cor=function(r1, r2, wt)
{
# We want the same ranks to have the same weight
# Cannot do this for both r1 and r2, so pick r1
rank_wt=wt[rank(r1, ties="min")]

t=cov.wt(cbind(r1, r2), wt=rank_wt, cor=TRUE)

return(data.frame(estimate=t$cor[1,2]))
}


ground_network_cor=function(node_list, cor_kind)
{
# Remove any names not in node_list
stakeholder_roles=subset(all_stakeholder_roles,
                         subset=(Stakeholder %in% names(node_list)))
# Normalise node_list and ground_list to contain common subset of roles
node_roles=subset(stakeholder_roles,
                  subset=(Stakeholder.Role %in% ground_stake$Stakeholder.Role))
node_roles$Priority=node_list[node_roles$Stakeholder]
t_gr=subset(ground_stake,
            subset=(Stakeholder.Role %in% stakeholder_roles$Stakeholder.Role))

# Order roles, highest priority comes first
ordered_roles=node_roles[order(node_roles$Priority, decreasing=TRUE), ]

# Select the first instance of all Roles
ordered_roles=subset(ordered_roles,
                      subset=!duplicated(Stakeholder.Role))
t_gr=subset(t_gr,
                      subset=!duplicated(Stakeholder.Role))

# Now we need to compare the two orderings of roles
ordered_roles$Rank=rank(max(ordered_roles$Priority)-ordered_roles$Priority)
ord_node=order(ordered_roles$Stakeholder.Role)
ord_gr=order(t_gr$Stakeholder.Role)

# Remove comment to print confidence intervals + other stuff
# print(cor.test(t_gr$Role.Rank[ord_gr], ordered_roles$Rank[ord_node]))

if (cor_kind == "open_weight")
# (1:length(ord_gr)^(-0.5)) is pagerank salience distribution for OpenR 
   weighted_cor(t_gr$Role.Rank[ord_gr], ordered_roles$Rank[ord_node],
                          (1:length(ord_gr))^-0.5)
else if (cor_kind == "closed_weight")
# exp(-(1:length(ord_gr)/10)) is pagerank salience distribution for ClosedR 
   weighted_cor(t_gr$Role.Rank[ord_gr], ordered_roles$Rank[ord_node],
                          exp(-(1:length(ord_gr))/10))
else
   cor.test(t_gr$Role.Rank[ord_gr], ordered_roles$Rank[ord_node])
}


node_metric_cor=function(stake_graph, stake_priority, cor_kind="")
{
# Betweenness centrality
# Load centrality: not supported by igraph
# Closeness centrality
# Eigenvector centrality (not used in paper)
# In-degree centrality
# Out-degree centrality
# PageRank

between_list=betweenness(stake_graph, directed=TRUE, weights=stake_priority)
t=ground_network_cor(between_list, cor_kind)

metric_cor=c(betweenness=t$estimate)

# between_list=get_stake_list(between_list)

closeness_list=closeness(stake_graph, weights=stake_priority)
t=ground_network_cor(closeness_list, cor_kind)
metric_cor=c(metric_cor, closeness=t$estimate)

# closeness_list=get_stake_list(closeness_list)

degree_in_list=degree(stake_graph, mode="in")
t=ground_network_cor(degree_in_list, cor_kind)
metric_cor=c(metric_cor, "degree in"=t$estimate)

# degree_in_list=get_stake_list(degree_in_list)

degree_out_list=degree(stake_graph, mode="out")
t=ground_network_cor(degree_out_list, cor_kind)
metric_cor=c(metric_cor, "degree out"=t$estimate)

# degree_out_list=get_stake_list(degree_out_list)

evcent_list=evcent(stake_graph, directed=TRUE, weights=stake_priority)
t=ground_network_cor(evcent_list$vector, cor_kind)
metric_cor=c(metric_cor, eigenvector=t$estimate)


pagerank_list=page.rank(stake_graph, weights=stake_priority)
t=ground_network_cor(pagerank_list$vector, cor_kind)
metric_cor=c(metric_cor, pagerank=t$estimate)

return(metric_cor)
}


# Role Rank,Stakeholder Role,Stakeholder Rank,Stakeholder
# 1,Security and Access Systems,1,Mike Dawson
ground_stake=read.csv(paste0(ESEUR_dir, "projects/requirements/ground-stake.csv.xz"), as.is=TRUE)

# Stakeholder	Stakeholder Role
# Aaron Toms	Management Systems: UPI
all_stakeholder_roles=read.csv(paste0(ESEUR_dir, "projects/requirements/Stakeholders-and-roles.txt.xz"), sep="\t", as.is=TRUE)

# Source	Stakeholder	Priority
# Aaron Toms	Andy Hicks	10
closed_rec=read.csv(paste0(ESEUR_dir, "projects/requirements/ClosedR.txt.xz"),
			sep="\t", as.is=TRUE)
open_rec=read.csv(paste0(ESEUR_dir, "projects/requirements/OpenR.txt.xz"),
			sep="\t", as.is=TRUE)

closed_graph=graph.data.frame(closed_rec)
open_graph=graph.data.frame(open_rec)

open_cor=node_metric_cor(open_graph, open_rec$Priority)
closed_cor=node_metric_cor(closed_graph, closed_rec$Priority)
open_weight_cor=node_metric_cor(open_graph, open_rec$Priority, "open_weight")
closed_weight_cor=node_metric_cor(closed_graph, closed_rec$Priority, "closed_weight")

library("ascii")

print(ascii(rbind(open_cor, open_weight_cor,
                  closed_cor, closed_weight_cor),
      include.colnames=TRUE,
      colnames=gsub("([^.]*).*", "\\1", names(open_cor)),
      include.rownames=TRUE,
      rownames=c("Open", "Weighted Open", "Closed", "Weighted Closed")))

