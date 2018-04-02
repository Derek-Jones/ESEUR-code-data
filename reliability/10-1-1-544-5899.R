#
# 10.1.1.544.5899.R, 29 Mar 18
# Data from:
# A Mathematical Model of the Finding of Usability Problems
# Jakob Nielsen and Thomas K. Landauer
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


plot_fit=function(df)
{
points(df$subjects, df$prob_percent, col=pal_col[df$system])
f_mod=nls(prob_percent ~ a*(1-(1-b)^subjects), data=df,
			start=list(a=1.0, b=0.4))
pred=predict(f_mod)
lines(df$subjects, pred, col=pal_col[df$system])

# print(summary(f_mod))

return(f_mod)
}


ui_prob=read.csv(paste0(ESEUR_dir, "reliability/10-1-1-544-5899.csv.xz"), as.is=TRUE)

pal_col=rainbow(max(ui_prob$system))

plot(ui_prob$subjects, ui_prob$prob_percent, type="n",
	xlab="Number of subjects/evaluations", ylab="Problems found (fraction)\n")

d_ply(ui_prob, .(system), plot_fit)

# df=subset(ui_probs, system == 1)

# f_mod=nls(prob_percent ~ a*(1-(1-b)^subjects), data=df,
#                         start=list(a=1, b=0.5))

