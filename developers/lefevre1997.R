#
# lefevre1997.R, 25 Feb 19
# Data from:
# The Role of Experience in Numerical Skill: {Multiplication} Performance in Adults from {Canada} and {China}
# Jo-Anne LeFevre and Jing Liu
# Data kindly provided by LeFevre and Liu
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human arithmetic performance


source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(2)


operand_family=function(df)
{
lval=count(df$Lvalue)
rval=count(df$Rvalue)

family=lval
family$freq=rval$freq

return(family)
}


family_error=function(df, col_str)
{
df_family=operand_family(df)

df_inc=subset(df, correct == 0)

df_inc_fam=operand_family(df_inc)

df_inc_perc=df_inc_fam
df_inc_perc$perc=df_inc_fam$freq/df_family$freq

points(df_inc_perc$x, 100*df_inc_perc$perc, type="b", col=col_str)
}

family_RT=function(df, col_str)
{
df=subset(df, correct == 1)

Lmean_RT=ddply(df, .(Lvalue), function(df)
				data.frame(mean=mean(df$RT), sd=sd(df$RT)))
Rmean_RT=ddply(df, .(Rvalue), function(df)
				data.frame(mean=mean(df$RT), sd=sd(df$RT)))

a_RT=Lmean_RT
a_RT$a_mean=(Lmean_RT$mean+Rmean_RT$mean)/2
a_RT$a_sd=sqrt((Lmean_RT$sd^2+Rmean_RT$sd^2)/2)

points(a_RT$Lvalue, a_RT$a_mean, type="b", col=col_str)
arrows(a_RT$Lvalue, a_RT$mean,
	a_RT$Lvalue, a_RT$mean+a_RT$sd,
	col=col_str,
        length=0.1, angle=90)
arrows(a_RT$Lvalue, a_RT$mean,
	a_RT$Lvalue, a_RT$mean-a_RT$sd,
	col=col_str,
        length=0.1, angle=90)

}


lef=read.csv(paste0(ESEUR_dir, "developers/lefevre1997.csv.xz"), as.is=TRUE)

# Notes and code kindly provided by LeFevre and Liu
# In the original paper, incorrect trials as well as "0x" and "1x" were excluded from the analysis
# lef <- subset(lef, correct==1 & type!='Zeros' & type!='TimeOne')

# Also, response times below 250 ms are deemed impossible and may be excluded from the analysis
lef <- subset(lef, RT > 250)

# Minimum is a better predictor than maximum (around 25% of the Canadian variance)
# lef$min_op=apply(cbind(lef$Lvalue, lef$Rvalue), 1, min)
# lef$max_op=apply(cbind(lef$Lvalue, lef$Rvalue), 1, max)
# lef_mod=glm(RT ~ min_op+max_op, data=lef)

# It's easier to see the culture effect without interactions.
# lef_mod=glm(RT ~ (Lvalue+Rvalue+type)^2+culture+log(session), data=lef)
# lef_mod=glm(RT ~ (Lvalue+Rvalue+culture+type)^2+log(session)-Lvalue:Rvalue, data=lef)
# summary(lef_mod)

canada=subset(lef, culture == "CA")
china=subset(lef, culture == "CH")

# Lots of between subjects variance.
# plot(0, type="n",
# 	xlim=c(0, 9), ylim=c(750, 2250),
# 	xlab="Operand family", ylab="Response time (msec)\n")
# 
# family_RT(canada, pal_col[1])
# family_RT(china, pal_col[2])
# 
# legend(x="topleft", legend=c("Canadian", "Chinese"), bty="n", fill=pal_col, cex=1.2)

plot(0, type="n",
	xlim=c(0, 9), ylim=c(0, 7),
	xlab="Operand family", ylab="Incorrect (%)")

family_error(canada, pal_col[1])
family_error(china, pal_col[2])

legend(x="topleft", legend=c("Canadian", "Chinese"), bty="n", fill=pal_col, cex=1.2)

