#
# dataset6_N.R, 20 Oct 18
# Data from:
# Approximating the Evolution History of Software from Source Code
# Tetsuya Kanda and Takashi Ishio and Katsuro Inoue
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG evolution file-similarity FreeBSD NetBSD OpenBSD LOC-added LOC-deleted

source("ESEUR_config.r")


library("phangorn")


# Used to prevent clicking on left/right
plot_layout(1, 1, default_width=ESEUR_default_width+1.0)


# d6=read.csv(paste0(ESEUR_dir, "odds-and-ends/dataset6_N_diff.csv.xz"), as.is=TRUE)
d6=read.csv(paste0(ESEUR_dir, "odds-and-ends/dataset6_N_pairs.csv.xz"), as.is=TRUE)

d6_mat=matrix(nrow=16, ncol=16, data=0)

# Convert similarity to distance
d6_mat[cbind(d6$to, d6$from)]=1.5*max(d6$sim)-d6$sim

rownames(d6_mat)=c("freeBSD_2.0", "freeBSD_2.0.5", "freeBSD_2.1",
			"freeBSD_2.2", "freeBSD_3.0",
			"BSD-lite", "BSD-lite2",
			"netBSD_0.8", "netBSD_0.9", "netBSD_1.0", "netBSD_1.1",
			"netBSD_1.2.1", "netBSD_1.2", "netBSD_1.3",
			"openBSD_2.0", "openBSD_2.1")

d6_dist=as.dist(d6_mat)


# dUPGMA=upgma(d6_dist)
# plot(dUPGMA)
dNJ=NJ(d6_dist)
plot(dNJ, "unrooted", cex=1.2, edge.color="grey", tip.color=point_col)

