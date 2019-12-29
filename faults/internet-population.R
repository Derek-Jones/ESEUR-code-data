#
# internet-population.R, 21 Nov 19
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG internet_population


source("ESEUR_config.r")


pal_col=rainbow(2)

# year, Developed,World,Developing
i_users=read.csv(paste0(ESEUR_dir, "faults/itu-internet-users.csv.xz"), as.is=TRUE)
i_users$year=as.Date(i_users$year)

ybounds=c(min(i_users$World), max(i_users$Developed))

plot(i_users$year, i_users$Developed, col=pal_col[1],
	ylim=ybounds,
	xlab="Year", ylab="Internet users per 100 head of population\n")

dev_mod=lm(Developed ~ year, data=i_users)
abline(reg=dev_mod, col=pal_col[1])

text(x=i_users$year[4], y=60, labels="Developed world", cex=1.3)

points(i_users$year, i_users$World, col=pal_col[2])

wor_mod=lm(World ~ year, data=i_users)
abline(reg=wor_mod, col=pal_col[2])

text(x=i_users$year[4], y=22, labels="World", cex=1.3)

