#
# BSD-network.R, 29 Aug 16
#
# Data from:
# Social Interactions around Cross-System Bug Fixings: the Case of FreeBSD and OpenBSD
# Gerardo Canfora and Luigi Cerulo and Marta Cimitile and Massimiliano Di Penta
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("igraph")


plot_wide()


# Return entries that occur more than X times
top_subset=function(everything)
{
t=table(everything)

return (names(t[t > 3]))
}


connections=read.csv(paste0(ESEUR_dir, "social/BSD-fixing/network/committers-network.edges.csv.xz"), as.is=TRUE)

brew_col=rainbow_hcl(4)

# Data contains a few different names that are probably the same person,
# e.g., matthew dillon and matt dillon

# length(unique(connections$FROM))
# length(unique(connections$TO))
# nrow(connections)

# Hang onto most common FROM and TO entries
t=top_subset(connections$FROM)
sub_conn=subset(connections, FROM %in% t)
t=top_subset(connections$TO)
sub_conn=subset(sub_conn, TO %in% t)

# Which OSs is each developer connected to?
dev_OS=ddply(sub_conn, .(TO), function(df) paste0(sort(unique(df$SYS)), collapse=""))

dev_OS$col=brew_col[match(dev_OS$V1, unique(dev_OS$V1))]

# Build graph.  First two columns in expected format
conn_graph=graph.data.frame(sub_conn, directed=TRUE)

in_deg=degree(conn_graph, mode="in")

V(conn_graph)[names(in_deg)]$size=3+in_deg^0.7
V(conn_graph)[names(in_deg)]$color=brew_col[4]
V(conn_graph)[dev_OS$TO]$color=dev_OS$col
V(conn_graph)$label=NA

E(conn_graph)$arrow.size=0.4

plot(conn_graph)

os_col=unique(dev_OS[, c("V1", "col")])

# plot uses a randomise algorithm, so we don't know where things
# will appear (a legend option would be useful, but I guess they
# might not know where things are).
# So the legend has to go in the title.
# The following seems to be the only way of changing the color
# of text without doing string width calculations.
t=as.expression(substitute(os1 * phantom(paste0(" ", os2, " ", os3)),
		list(os1=os_col$V1[1], os2=os_col$V1[2], os3=os_col$V1[3])))
title(t, col.main=os_col$col[1])

t=as.expression(substitute(phantom(paste0(os1, " ")) * os2 *
			   phantom(paste0(" ", os3)),
		list(os1=os_col$V1[1], os2=os_col$V1[2], os3=os_col$V1[3])))
title(t, col.main=os_col$col[2])

t=as.expression(substitute(phantom(paste0(os1, " ", os2, " ")) * os3,
		list(os1=os_col$V1[1], os2=os_col$V1[2], os3=os_col$V1[3])))
title(t, col.main=os_col$col[3])


