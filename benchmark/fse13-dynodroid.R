#
# fse13-dynodroid.R, 13 Mar 16
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


dh=read.csv(paste0(ESEUR_dir, "benchmark/fse13-dynohuman.csv"), as.is=TRUE)
dm=read.csv(paste0(ESEUR_dir, "benchmark/fse13-dynomonkey.csv"), as.is=TRUE)

# Dynodroid vs human

dyno_geom=prod(100*(dh$LOC.covered.by.both.Dyno.and.Human+dh$LOC.covered.exclusively.by.Dyno)/dh$Total.App.LOC)^(1/nrow(dh))
dyno_arith=sum(100*(dh$LOC.covered.by.both.Dyno.and.Human+dh$LOC.covered.exclusively.by.Dyno)/dh$Total.App.LOC)/nrow(dh)

human_geom=prod(100*(dh$LOC.covered.by.both.Dyno.and.Human+dh$LOC.covered.exclusively.by.Human)/dh$Total.App.LOC)^(1/nrow(dh))
human_arith=sum(100*(dh$LOC.covered.by.both.Dyno.and.Human+dh$LOC.covered.exclusively.by.Human)/dh$Total.App.LOC)/nrow(dh)

length(which(dh$LOC.covered.exclusively.by.Dyno..D.> dh$LOC.covered.exclusively.by.Human..H.))/nrow(dh)

sum(dh$LOC.covered.exclusively.by.Dyno..D.) / sum(dh$LOC.covered.exclusively.by.Human..H.)

dh_ex=prod(100*dh$LOC.covered.exclusively.by.Dyno/dh$Total.App.LOC)


# Dynodroid vs Monkey

dyno_geom=prod(100*(dm$LOC.covered.by.both.Dyno.and.Monkey+dm$LOC.covered.exclusively.by.Dyno)/dm$Total.App.LOC)^(1/nrow(dm))
dyno_arith=sum(100*(dm$LOC.covered.by.both.Dyno.and.Monkey+dm$LOC.covered.exclusively.by.Dyno)/dm$Total.App.LOC)/nrow(dm)

monkey_geom=prod(100*(dm$LOC.covered.by.both.Dyno.and.Monkey+dm$LOC.covered.exclusively.by.Monkey)/dm$Total.App.LOC)^(1/nrow(dm))
monkey_arith=sum(100*(dm$LOC.covered.by.both.Dyno.and.Monkey+dm$LOC.covered.exclusively.by.Monkey)/dm$Total.App.LOC)/nrow(dm)

length(which(dm$LOC.covered.exclusively.by.Dyno..D.> dm$LOC.covered.exclusively.by.Monkey..M.))/nrow(dm)

sum(dm$LOC.covered.exclusively.by.Dyno..D.) / sum(dm$LOC.covered.exclusively.by.Monkey..M.)

dm_ex=prod(100*dm$LOC.covered.exclusively.by.Dyno/dm$Total.App.LOC)


plot(dh$Total.App.LOC..T., dh$LOC.covered.by.both.Dyno.and.Human..C., log="xy",
		col=pal_col[1])
points(dh$Total.App.LOC..T., dh$LOC.covered.exclusively.by.Dyno..D.,
		col=pal_col[2])
points(dh$Total.App.LOC..T., dh$LOC.covered.exclusively.by.Human..H.,
		col=pal_col[3])


