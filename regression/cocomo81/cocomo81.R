#
# cocomo81.R, 19 May 16
# Data from:
# Software Engineering Economics
# Barry W. Boehm
# by way of the PROMISE repository
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("foreign")


# coc81=read.arff(paste0(ESEUR_dir, "regression/cocomo81/coc81.arff"))
coc81=read.csv(paste0(ESEUR_dir, "regression/cocomo81/coc81.csv"), as.is=TRUE)

# An outlier for the dataset taken as a whole and for the embedded subset
coc81=coc81[-19,]
coc81$l_loc=log(coc81$loc)
# Two values are not integers, which Poisson error regression requires
coc81$r_actual=round(coc81$actual)

embedded=subset(coc81, dev_mode == "embedded")
organic=subset(coc81, dev_mode == "organic")
semid=subset(coc81, dev_mode == "semidetached")

pal_col=rainbow(3)

# Plot and fit the data as a whole
# plot(coc81$loc, coc81$r_actual)
plot(coc81$loc, coc81$r_actual, log="xy", type="n",
	xlab="kSLOC", ylab="Man months\n")

points(embedded$loc, embedded$r_actual, col=pal_col[1])
points(organic$loc, organic$r_actual, col=pal_col[2])
points(semid$loc, semid$r_actual, col=pal_col[3])

lines(loess.smooth(coc81$loc, coc81$r_actual, span=0.3), col=loess_col)

x_loc=log(1:max(coc81$loc))

# coc_llmod=lm(r_actual ~ loc, data=coc81)
coc_lmod=lm(log(r_actual) ~ l_loc, data=coc81)
pred=predict(coc_lmod, newdata=data.frame(l_loc=x_loc))
lines(exp(x_loc), exp(pred), col="red")

coc_mod=glm(r_actual ~ l_loc, data=coc81, family=poisson)
pred=predict(coc_mod, newdata=data.frame(l_loc=x_loc), type="response")

lines(exp(x_loc), pred, col="green")

coc_2mod=glm(r_actual ~ l_loc+I(l_loc^2), data=coc81, family=poisson)
pred=predict(coc_2mod, newdata=data.frame(l_loc=x_loc), type="response")

lines(exp(x_loc), pred, col="blue")



lines(loess.smooth(coc81$loc, coc81$r_actual, span=0.3), col=loess_col)

coc_1amod=glm(r_actual ~ loc, data=coc81)
#coc_2amod=glm(r_actual ~ loc+I(loc^2), data=coc81)
pred=predict(coc_1amod, newdata=data.frame(loc=exp(x_loc)))
lines(exp(x_loc), pred, col="red")


# Fit using the technique probably used by Boehm and plot
plot_dev_mode=function(df, col_str, line_lty=1)
{
#lines(loess.smooth(df$loc, df$r_actual, span=0.3), col=loess_col)
coc_lmod=lm(log(r_actual) ~ l_loc, data=df)
pred=predict(coc_lmod, newdata=data.frame(l_loc=x_loc))

lines(exp(x_loc), exp(pred), col=col_str, lty=line_lty)

coc_mod=glm(r_actual ~ l_loc, data=df, family=poisson)
pred=predict(coc_mod, newdata=data.frame(l_loc=x_loc), type="response")

#lines(exp(x_loc), pred, col=col_str)

# print(summary(coc_lmod))

return(coc_lmod)
}

pal_col=rainbow(3)

plot(coc81$loc, coc81$r_actual, log="xy", type="n",
	xlab="kSLOC", ylab="Man months\n")

points(embedded$loc, embedded$r_actual, col=pal_col[1])
points(organic$loc, organic$r_actual, col=pal_col[2])
points(semid$loc, semid$r_actual, col=pal_col[3])

embedded_mod=plot_dev_mode(embedded, pal_col[1])
embedded_c_mod=plot_dev_mode(embedded[-c(2, 3, 12),], pal_col[1], 2)

organic_mod=plot_dev_mode(organic, pal_col[3])
organic_c_mod=plot_dev_mode(organic[-c(1,  5,  7), ], pal_col[3], 2)

semid_mod=plot_dev_mode(semid, pal_col[2])
semid_c_mod=plot_dev_mode(semid[-c(2, 6, 8), ], pal_col[2], 2)


legend(x="bottomright", legend=c("Embedded", "Semidetached", "Organic"), bty="n", fill=pal_col, cex=1.3)

