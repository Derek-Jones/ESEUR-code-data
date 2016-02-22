#
# feat-duration-7dig.R, 14 Feb 16
#
# Various analysis of http://www.7digital.com feature data
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_layout(2, 1)
par(mai=c(1, 0.8, 0.0, 0.1))

# Fit a power law and draw it to an existing plot
plot_pow=function(y, x, line_color)
{
pow_equ=nls(y~ a*x^b, start=list(a=1200, b =-2))

y=predict(pow_equ, x)
lines(x, y, col=line_color)

# print(coef(pow_equ))

text(x[2]*2.5, y[2], paste("days ^ ", signif(as.numeric(coef(pow_equ)[2]), digits=3)))
}


# Plot sum of data values and fit various equations to parts of it
plot_pow_exp=function(day.info)
{
ct=table(day.info)
all.x=x=as.integer(dimnames(ct)[[1]])

plot(ct, log="xy", type="p", col=point_col,
	xlim=c(1, 90), ylim=c(1, 1200),
	xlab="Implementation duration (working days)", ylab="Features")

cv=as.vector(ct[1:16])
x=as.integer(dimnames(ct)[[1]][1:16])
plot_pow(cv, x, "red")

cv2=as.vector(ct[17:length(ct)])
x2=as.integer(dimnames(ct)[[1]][17:length(ct)])
plot_pow(cv2, x2, "blue")

# Build an exponential model
#expr_start=list(a=10000, b=-2.0, c=0.4)
# exp_mod=nls(as.vector(ct) ~ a*exp(b*all.x^c), start=expr_start, trace=TRUE)
#exp_mod=nls(as.vector(ct) ~ a*exp(b*all.x^c), start=expr_start)
#
#y=predict(exp_mod, all.x)
#par(col="green")
#lines(all.x, y)
#
#print(coef(exp_mod))
}


# Which of the 'common' distributions is a good fit?
library("fitdistrplus")

fit_equ=function(day_count)
{
#descdist(day_count, discrete=TRUE, boot=100)

fd=fitdist(day_count, "nbinom", method="mme")
#summary(fd)
#gofstat(fd, print.test=TRUE)
#gofstat(fd, print.test=TRUE)$chisqtable
size.ct=fd$estimate[1]
mu.ct=fd$estimate[2]

# Calculate distribution parameters the approximate way
# mu.ct=desc.ct$mean
# size.ct=desc.ct$mean^2/(desc.ct$sd^2-desc.ct$mean)

#plot(table(day_count), xlim=c(1, 90), ylim=c(1, 1200), log="xy", type="p",
#            xlab="Elapsed working days", ylab="Features")

lines(dnbinom(1:93, size=size.ct,  mu=mu.ct)*length(day_count), col="green",
	type="l")
}



source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


Done_day=as.integer(p$Done)-base_day
plot_pow_exp(p$Cycle.Time[Done_day > 650])
fit_equ(p$Cycle.Time[Done_day > 650])

plot_pow_exp(p$Cycle.Time[Done_day <= 650])
fit_equ(p$Cycle.Time[Done_day <= 650])


