#
# fse13-dynodroid.R, 23 Sep 16
#
# Data from:
# Dynodroid: {An} Input Generation System for {Android} Apps
# Aravind Machiry and Rohan Tahiliani and Mayur Naik
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)
hcl_col=rainbow_hcl(4)

dh=read.csv(paste0(ESEUR_dir, "benchmark/fse13-dynohuman.csv.xz"), as.is=TRUE)
# dm=read.csv(paste0(ESEUR_dir, "benchmark/fse13-dynomonkey.csv.xz"), as.is=TRUE)

# Dynodroid vs human

dh$total_covered=dh$LOC.covered.by.both.Dyno.and.Human..C.+
			dh$LOC.covered.exclusively.by.Dyno..D.+
			dh$LOC.covered.exclusively.by.Human..H.

plot(dh$Total.App.LOC..T.,
		dh$LOC.covered.by.both.Dyno.and.Human..C./dh$total_covered,
		log="x", col=pal_col[1],
		xlab="Lines in Application", ylab="Percentage of covered lines\n")
points(dh$Total.App.LOC..T.,
		dh$LOC.covered.exclusively.by.Dyno..D./dh$total_covered,
		col=pal_col[2])
points(dh$Total.App.LOC..T.,
		dh$LOC.covered.exclusively.by.Human..H./dh$total_covered,
		col=pal_col[3])

legend(x="left", legend=c("Human & Dynodroid", "Dynodroid", "Human"),
				bty="n", fill=pal_col, cex=1.2)


