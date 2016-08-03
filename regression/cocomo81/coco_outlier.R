#
# coco_outlier.R, 23 Jul 16
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


plot_layout(2, 1)
pal_col=rainbow(5)

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


# Fit lots of models to one of the COCOMO subsets
fit_dev_mode=function(df)
{
plot(df$loc, df$r_actual, log="xy",
	xlab="kSLOC", ylab="Man months\n")

#lines(loess.smooth(df$loc, df$r_actual, span=0.3), col=loess_col)

x_loc=log(1:max(df$loc))

# coc_llmod=lm(r_actual ~ loc, data=df)
coc_lmod=lm(log(r_actual) ~ l_loc, data=df)
pred=predict(coc_lmod, newdata=data.frame(l_loc=x_loc))
lines(exp(x_loc), exp(pred), col=pal_col[1])

coc_mod=glm(r_actual ~ l_loc, data=df, family=poisson)
pred=predict(coc_mod, newdata=data.frame(l_loc=x_loc), type="response")

lines(exp(x_loc), pred, col=pal_col[2])

coc_2mod=glm(r_actual ~ l_loc+I(l_loc^2), data=df, family=poisson)
pred=predict(coc_2mod, newdata=data.frame(l_loc=x_loc), type="response")

lines(exp(x_loc), pred, col=pal_col[3])

coc_1amod=glm(r_actual ~ loc, data=df)
pred=predict(coc_1amod, newdata=data.frame(loc=exp(x_loc)))
lines(exp(x_loc), pred, col=pal_col[4])
coc_2amod=glm(r_actual ~ loc+I(loc^2), data=df)
pred=predict(coc_2amod, newdata=data.frame(loc=exp(x_loc)))
lines(exp(x_loc), pred, col=pal_col[5])

# print(summary(coc_lmod))
# print(summary(coc_mod))
# print(summary(coc_2mod))
# print(summary(coc_1amod))
# print(summary(coc_2amod))

return(coc_mod)
}


embedded_mod=fit_dev_mode(embedded)
embedded_mod=fit_dev_mode(embedded[-c(2, 3, 12),])

# organic_mod=fit_dev_mode(organic)
# organic_mod=fit_dev_mode(organic[-c(1,  5,  7), ])

# semid_mod=fit_dev_mode(semid)
# semid_mod=fit_dev_mode(semid[-c(2, 6, 8), ])


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

