#
# trel2019-linux_rgbugs.R, 22 Jun 20
# Data from:
# An Empirical Study of Regression Bug Chains in {Linux}
# Guanping Xiao and Zheng Zheng and Bo Jiang and Yulei Sui
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG fault-report Linux

source("ESEUR_config.r")


library("igraph")


pal_col=rainbow(3)


trel=read.csv(paste0(ESEUR_dir, "reliability/trel2019-linux_rgbugs.csv.xz"), as.is=TRUE)

# Bug.introducing.Commit.ID will be NA for the original bug.
# So need to copy over Bug.ID so there is something to pair up
trel$from=trel$Bug.introducing.Commit.ID
orig_bug=is.na(trel$Bug.introducing.Commit.ID)
trel$from[orig_bug]=trel$Bug.ID

trel_ft=data.frame(from=trel$from,
			to=trel$Bug.fixing.Commit.ID,
			bugID=trel$Bug.ID,
			orig_bug,
			stringsAsFactors=FALSE)

# 9998 is the example given in the paper
# trel_ft[which(trel_ft$bugID == 9998), ]

ft=subset(trel_ft, !is.na(to))

bug_graph=graph_from_data_frame(ft)

cl_bugs=decompose.graph(bug_graph)

num_vert=unlist(lapply(cl_bugs, gorder))

# table(num_vert)

biggest=cl_bugs[[which(num_vert == max(num_vert))]]

v_names=as.numeric(V(biggest)$name)

V(biggest)$frame.color=NA
V(biggest)$color=ifelse(is.na(v_names), pal_col[3], pal_col[1])
V(biggest)$label=substr(V(biggest)$name, 1, 5)

V(biggest)$size=20

E(biggest)$color=pal_col[2]
E(biggest)$arrow.size=0.5

plot(biggest)


