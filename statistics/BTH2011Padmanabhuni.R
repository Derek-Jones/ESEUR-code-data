#
# BTH2011Padmanabhuni.R,  6 Jan 16
#
# Data from:
# Javad Mohammadian Amiri Venkata Vinod Kumar Padmanabhuni
# A Comprehensive Evaluation of Conversion Approaches for Different Function Points
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("plyr")


plot_who=function(who, line_col)
{
points(who$CFP, who$FP, col=who$col)
lines(loess.smooth(who$CFP, who$FP, span=0.5, family="gaussian"), col=line_col)
}



bench=read.csv(paste0(ESEUR_dir, "statistics/BTH2011Padmanabhuni.csv.xz"), as.is=TRUE)

# conv_mod=glm(FP ~ (who_FP+CFP)^2+kind+Dataset, data=bench)
# conv_mod=glm(FP ~ (who_FP+CFP)^2+kind, data=bench)
# summary(conv_mod)

no_students=subset(bench, Dataset != "Cuadtado_jj07" & Dataset != "Cuadtado_jj06")
no_Cuadtado=subset(no_students, Dataset != "Cuadtado_2007")

# table(no_students$who_CFP, no_students$who_FP)

conv_mod=glm(FP ~ (who_FP+CFP)^2+kind+Dataset, data=no_students)

conv_mod=glm(FP ~ (who_FP+who_CFP+log(CFP))^2-who_FP:who_CFP+kind, family=poisson, data=no_students)
# summary(conv_mod)

pal_col=rainbow(4)
D_names=unique(no_students$Dataset)
D_cols=rainbow(length(D_names))
no_students$col=mapvalues(no_students$Dataset, D_names, D_cols)

ind=subset(no_students, who_CFP == "ind")
aca=subset(no_students, who_CFP != "ind")

plot(1, type="n", log="xy",
	xlim=range(no_students$CFP), ylim=range(no_students$FP),
	xlab="COSMIC", ylab="FPA\n")

plot_who(ind, pal_col[1])
plot_who(aca, pal_col[3])

legend(x="topleft", legend=D_names, bty="n", fill=D_cols, cex=1.2)

# Remove what data that has a different slope to everything else
aca=subset(no_Cuadtado, who_CFP != "ind")

