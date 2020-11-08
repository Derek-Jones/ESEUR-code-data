#
# CALGO.R, 24 Oct 20
# Data from:
# Data extracted from collected algorithms of Transactions on Mathematical Software
# Dreek M. Jones
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG LOC_algorithms mathematics_source-code

source("ESEUR_config.r")


pal_col=rainbow(2)


adl=read.csv(paste0(ESEUR_dir, "sourcecode/CALGO.csv.xz"), as.is=TRUE)

adl$date=as.Date(paste0("01 ", adl$date), format="%d %b %Y")

plot(adl$date, adl$length/1e3, log="y", col=pal_col[2],
	ylim=c(1e-1, 1e2),
	xlab="Date", ylab="KLOC\n")

adl_mod=glm(log(length) ~ date, data=adl)
# summary(adl_mod)

# Annual growth
# exp(coef(adl_mod)[2]*365.25)

u_date=sort(unique(adl$date))

pred=predict(adl_mod, newdata=data.frame(date=u_date))

lines(u_date, exp(pred)/1e3, col=pal_col[1])


