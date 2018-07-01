#
# TR_DCC-overExposure.R, 25 Apr 18
# Data from:
# Understanding and Addressing Exhibitionism in Java Empirical Research about Method Accessibility
# Santiago A. Vidal and Alexandre Bergel and Claudia Marcos and J. Andrés Diaz-Pace
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(6, 5)

pal_col=rainbow(2)


plot_overexposure=function(file_str)
{
print(file_str)
t=read.csv(file_str, as.is=TRUE)
# t=subset(t, Over.exposed.methods < 30)
t_trunc=subset(t, Over.exposed.methods > 0)

plot(t$Methods-t$Over.exposed.methods, t$Over.exposed.methods, log="x",
	col=point_col,
	xlab="", ylab="")

try(
lines(loess.smooth(t$Methods-t$Over.exposed.methods, t$Over.exposed.methods, span=0.9), col=pal_col[1])
   )
lines(loess.smooth(t_trunc$Methods-t_trunc$Over.exposed.methods, t_trunc$Over.exposed.methods, span=0.9), col=pal_col[2])

return(NULL)
}


files=list.files(paste0(ESEUR_dir, "sourcecode/TR_DCC-overExposure"),
		pattern=".*.csv.xz", full.names=TRUE)

dummy=sapply(files, plot_overexposure)

t=read.csv(files[6], as.is=TRUE)

# t=subset(t, Over.exposed.methods < 30)
t_trunc=subset(t, Over.exposed.methods > 0)

plot(t$Methods-t$Over.exposed.methods, t$Over.exposed.methods,
	xlab="", ylab="")

lines(loess.smooth(t$Methods-t$Over.exposed.methods, t$Over.exposed.methods, span=0.6), col=loess_col)
lines(loess.smooth(t_trunc$Methods-t_trunc$Over.exposed.methods, t_trunc$Over.exposed.methods, span=0.4), col=loess_col)

over_mod=glm(Over.exposed.methods ~ Methods, data=t, family=poisson)

over2_mod=glm(Over.exposed.methods ~ Methods+I(Methods^2), data=t, family=poisson)

over3_mod=glm(Over.exposed.methods ~ Methods+I(Methods^2)+I(Methods^3), data=t, family=poisson)


