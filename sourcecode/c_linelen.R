#
# c_linelen.R,  3 Aug 16
#
# Data from:
#
# Derek M. Jones
# The New {C Standard}: {An} Economic and Cultural Commentary
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 1)

pal_col=rainbow(2)

c_lines=read.csv(paste0(ESEUR_dir, "sourcecode/c_linelen.csv.xz"), as.is=TRUE)
h_lines=read.csv(paste0(ESEUR_dir, "sourcecode/h_linelen.csv.xz"), as.is=TRUE)

plot(c_lines$length, c_lines$occurrences, log="y", col=pal_col[1],
	xlab="Characters on line", ylab="Occurrences\n",
	xlim=c(0, 250))

points(h_lines$length, h_lines$occurrences, col=pal_col[2])

legend(x="topright", legend=c(".c files", ".h files"), bty="n", fill=pal_col)


c_toks=read.csv(paste0(ESEUR_dir, "sourcecode/c_linetok.csv.xz"), as.is=TRUE)
h_toks=read.csv(paste0(ESEUR_dir, "sourcecode/h_linetok.csv.xz"), as.is=TRUE)

plot(c_toks$tokens, c_toks$occurrences, log="y", col=pal_col[1],
	xlab="Tokens on line", ylab="Occurrences",
	xlim=c(0, 100))

points(h_toks$tokens, h_toks$occurrences, col=pal_col[2])


