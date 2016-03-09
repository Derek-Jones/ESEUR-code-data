#
# usa-infra.R, 21 Feb 16
#
# Data from:
#
# Long Waves, Technology Diffusion, and Substitution
# Arnulf Gr{\"u}bler and Neboj\u{s}a Naki{\'c}enovi{\'c}
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_wide()
pal_col=rainbow(7)

# year,canals,railways,surfaced roads,oil pipelines,gas pipelines,telegraph wire
infra=read.csv(paste0(ESEUR_dir, "ecosystem/usa-infra.csv.xz"), as.is=TRUE)

plot(infra$year, infra$canals/max(infra$canals),
	col=pal_col[1],
	xlab="Year", ylab="Percentage of known maximum\n",
	xlim=c(1805,1995), ylim=c(0, 1.0))
points(infra$year, infra$railways/max(infra$railways, na.rm=TRUE),
	col=pal_col[2])
points(infra$year, infra$surfaced.roads/max(infra$surfaced.roads, na.rm=TRUE),
	col=pal_col[5])

points(infra$year, infra$telegraph.wire/max(infra$telegraph.wire, na.rm=TRUE),
	col=pal_col[3])
points(infra$year, infra$oil.pipelines/max(infra$oil.pipelines, na.rm=TRUE),
	col=pal_col[4])
points(infra$year, infra$gas.pipelines/max(infra$gas.pipelines, na.rm=TRUE),
	col=pal_col[6])

legend(x="bottomright", legend=c("canals", "railways", "telegraph wire", "oil pipelines", "surfaced roads", "gas pipelines"),
			bty="n", fill=pal_col, cex=1.3)

