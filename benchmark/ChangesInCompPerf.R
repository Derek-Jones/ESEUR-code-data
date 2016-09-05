#
# ChangesInCompPerf.R, 31 Aug 16
# Data from:
# Kenneth E. Knight
# Changes in Computer Performance
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

pal_col=rainbow(3)


plot_year=function(model, year_rel, col_str)
{
pred=predict(model, newdata=data.frame(Com.l.ops.sec=ops_sec, year=year_rel), type="response")
lines(exp(ops_sec), pred, col=col_str)
year_pts=subset(fifties, year == year_rel)
points(year_pts$Com.ops.sec, year_pts$Com.sec.dol, col=col_str)
}


bench=read.csv(paste0(ESEUR_dir, "benchmark/ChangesInCompPerf.csv.xz"), as.is=TRUE)

# Scientific operations
# plot(bench$Sci.ops.sec, bench$Sci.sec.dol, log="xy", col=point_col,
# 	xlab="Operations per second", ylab="Seconds per dollar\n")

bench$Sci.l.ops.sec=log(bench$Sci.ops.sec)
bench$Com.l.ops.sec=log(bench$Com.ops.sec)
bench$year=as.numeric(substring(bench$Date.introduced, nchar(bench$Date.introduced)-3))

fifties=subset(bench, year > 1952 && year < 1962)
# fifties$year=fifties$year-1952
over_30=subset(fifties, Sci.sec.dol > 30)

# sci_mod=glm(Sci.sec.dol ~ Sci.l.ops.sec+I(Sci.l.ops.sec^2), data=bench, family=gaussian(link="log"))

# Quandratic is a slightly better fit
sci_mod=glm(Sci.sec.dol ~ Sci.l.ops.sec+I(Sci.l.ops.sec^2)+year, data=fifties, family=gaussian(link="log"))
# Remove the largest outliers
# sci_mod=glm(Sci.sec.dol ~ Sci.l.ops.sec+year, data=fifties[-c(111, 179, 158),], family=gaussian(link="log"))
sci_mod=glm(Sci.sec.dol ~ Sci.l.ops.sec+year, data=fifties, family=gaussian(link="log"))
# What Knight did...
# sci_mod=lm(log(Sci.sec.dol) ~ Sci.l.ops.sec+year, data=fifties)

# summary(sci_mod)

ops_sec=seq(log(min(bench$Sci.ops.sec)), log(max(bench$Sci.ops.sec)), length.out=10)

pred=predict(sci_mod, newdata=data.frame(Sci.l.ops.sec=ops_sec, year=1962), type="response")
# lines(exp(ops_sec), exp(pred), col="green")


# Commercial operations
plot(bench$Com.ops.sec, bench$Com.sec.dol, log="xy", col=point_col,
	xlab="Operations per second", ylab="Seconds per dollar\n")

com_mod=glm(Com.sec.dol ~ Com.l.ops.sec+year, data=fifties, family=gaussian(link="log"))

# summary(com_mod)

plot_year(com_mod, 1953, pal_col[1])
plot_year(com_mod, 1957, pal_col[2])
plot_year(com_mod, 1961, pal_col[3])

legend(x="bottomleft", legend=rev(c(1953, 1957, 1961)), bty="n", fill=rev(pal_col), cex=1.2)

