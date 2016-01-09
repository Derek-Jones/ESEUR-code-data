#
# stake-priority.R, 16 Apr 13
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

# Source	Stakeholder	Priority
# Aaron Toms	Andy Hicks	10
closed_rec=read.csv(paste0(ESEUR_dir, "projects/requirements/ClosedR.txt.xz"), as.is=TRUE, sep="\t")
open_rec=read.csv(paste0(ESEUR_dir, "projects/requirements/OpenR.txt.xz"), as.is=TRUE, sep="\t")


closed_graph=graph.data.frame(closed_rec)
open_graph=graph.data.frame(open_rec)

# The edge attribute has to have the name 'weights' for it to
# be implicitly used, otherwise the paramater has to be specified
closed_p_r=page.rank(closed_graph, weights=closed_rec$Priority)
open_p_r=page.rank(open_graph, weights=open_rec$Priority)

t=order(closed_p_r$vector, decreasing=TRUE)
closed_names=V(closed_graph)$name
closed_ord=closed_names[t]
t=order(open_p_r$vector, decreasing=TRUE)
open_names=V(open_graph)$name
open_ord=open_names[t]

# Some names are unique to each list
cor.test(order(open_ord[open_ord %in% closed_ord]),
         order(closed_ord[closed_ord %in% open_ord]), method="spearman") 

name_info=data.frame(names=unique(c(open_names, closed_names)),
                     closed_rank=NA, open_rank=NA)
rownames(name_info)=name_info$names
name_info[closed_names, ]$closed_rank=closed_p_r$vector
name_info[open_names, ]$open_rank=open_p_r$vector
shared_name_info=subset(name_info, !is.na(closed_rank) & !is.na(open_rank))

# Alternative solution using %in%
# shared_closed_vec=closed_names %in% open_names
# shared_open_vec=open_names %in% closed_names
# 
# closed_p_r_ord=closed_p_r$vector[shared_closed_vec][order(closed_names[shared_closed_vec])]
# open_p_r_ord=open_p_r$vector[shared_open_vec][order(open_names[shared_open_vec])]
# 
# open_closed_ratio=open_p_r_ord / closed_p_r_ord

open_closed_ratio=shared_name_info$open_rank / shared_name_info$closed_rank


plot(sort(open_closed_ratio), log="y",
     xlab="Stakeholder", ylab="Open/closed page rank ratio")

