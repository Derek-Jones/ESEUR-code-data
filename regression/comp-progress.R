#
# comp-progress.R,  5 Jun 19
#
# Data from:
# The Progress of Computing
# William D. Nordhaus
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG cost_date operations_cost


source("ESEUR_config.r")


library("plyr")

bench=read.csv(paste0(ESEUR_dir, "regression/comp-progress.csv.xz"), as.is=TRUE)

tech_vec=unique(bench$technology)

pal_col=0
pal_col[tech_vec]=rainbow(length(tech_vec))

plot(0, type="n", log="y",
	xlim=range(bench$Date), ylim=range(bench$total_cost_mill_ops),
	xlab="Date", ylab="Cost per million ops\n")

d_ply(bench, .(technology), function(df)
			points(df$Date, df$total_cost_mill_ops,
				col=pal_col[df$technology]))

legend(x="bottomleft", legend=tech_vec, bty="n", fill=pal_col[tech_vec], cex=1.2)

