#
# usa-infra.R,  6 Dec 19
#
# Data from:
# Long Waves, Technology Diffusion, and Substitution
# Arnulf Gr{\"u}bler and Neboj\u{s}a Naki{\'c}enovi{\'c}
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG evolution infrastructure

source("ESEUR_config.r")


pal_col=rainbow(6)

# year,canals,railways,surfaced roads,oil pipelines,gas pipelines,telegraph wire
infra=read.csv(paste0(ESEUR_dir, "ecosystems/usa-infra.csv.xz"), as.is=TRUE)

plot(infra$year, 100*infra$canals/max(infra$canals), type="l", col=pal_col[1],
	yaxs="i",
	xlab="Year", ylab="Percentage of known maximum\n",
	xlim=c(1805,1995), ylim=c(0, 100))
lines(infra$year, 100*infra$railways/max(infra$railways, na.rm=TRUE),
	col=pal_col[2])
lines(infra$year, 100*infra$surfaced.roads/max(infra$surfaced.roads, na.rm=TRUE),
	col=pal_col[5])

lines(infra$year, 100*infra$telegraph.wire/max(infra$telegraph.wire, na.rm=TRUE),
	col=pal_col[3])
lines(infra$year, 100*infra$oil.pipelines/max(infra$oil.pipelines, na.rm=TRUE),
	col=pal_col[4])
lines(infra$year, 100*infra$gas.pipelines/max(infra$gas.pipelines, na.rm=TRUE),
	col=pal_col[6])

legend(x="topleft", legend=c("canals", "railways", "telegraph wire", "oil pipelines", "surfaced roads", "gas pipelines"),
			bty="n", fill=pal_col, cex=1.2)

