#
# fse2018.R, 10 Mar 20
# Data from:
# How Well Are Regular Expressions Tested in the Wild?
# Peipei Wang and Kathryn T. Stolee
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG testing_coverage regular-expression_testing

source("ESEUR_config.r")


library("vioplot")


pal_col=rainbow(4)


sc=read.csv(paste0(ESEUR_dir, "reliability/fse2018.csv.xz"), as.is=TRUE)

# regex_index refers to 13,632 syntactically unique regexes;
# type 1 coverage data for matching inputs
#      2 coverage for failing inputs
#      0 combining all testing inputs
# count the number of testing inputs used for testing coverage.
# t_node, t_edge, t_epair  represents the total nodes, edges, and edge pairs of the regex's DFA
# c_node, c_edge, c_epair  represents the covered nodes, edges, and edge pairs in the regex's DFA

sc$node_perc=100*sc$c_node/sc$t_node
sc$edge_perc=100*sc$c_edge/sc$t_edge

mfi=subset(sc, type != 0)

coverage=data.frame(cov_perc=c(mfi$node_perc, mfi$edge_perc),
		    type=c(mfi$type, mfi$type+2))

vioplot(cov_perc ~ type, data=coverage, col=pal_col,
	horizontal=TRUE,
	names=c("Node-Match", "Node-Fail", "Edge-Match", "Edge-Fail"),
	xaxs="i",
	xlab="Coverage", ylab="")

# mean(subset(sc, type == 1)$node_perc)
# mean(subset(sc, type == 2)$node_perc)

