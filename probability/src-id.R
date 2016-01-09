#
# src-id.R, 14 Dec 15
#
# Data from:
#
# The New {C Standard}: {An} Economic and Cultural Commentary
# Derek M. Jones
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


id_cnt=read.csv(paste0(ESEUR_dir, "probability/src-id.csv.xz"), as.is=TRUE)

pal_col=rainbow(ncol(id_cnt))
id_cnt$rank=1:nrow(id_cnt)

# Filter the number of point to reduce plotting time
plot_sub=subset(id_cnt, (rank < 1000) | ((rank %% 20) == 0))

plot(plot_sub$rank, plot_sub$linux, log="xy", col=pal_col[1], pch=18, cex=0.5,
	xlab="Rank", ylab="Occurrences\n")
points(plot_sub$rank, plot_sub$gcc, col=pal_col[2], pch=18, cex=0.5)
points(plot_sub$rank, plot_sub$netscape, col=pal_col[3], pch=18, cex=0.5)
points(plot_sub$rank, plot_sub$openAFS, col=pal_col[4], pch=18, cex=0.5)

legend(x="topright", legend=c("Linux", "gcc", "Netscape", "OpenAFS"),
				bty="n", fill=pal_col, cex=1.3)

