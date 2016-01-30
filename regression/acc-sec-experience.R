#
# acc-sec-experience.R.R, 29 Jan 16
#
# Data from:
# An empirical study on the effectiveness of security code review
# Anne Edmundson and Brian Holtkamp and Emanuel Rivera and Matthew Finifter and Adrian Mettler and David Wagner
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

# accuracy,years.in.security
rev_acc=read.csv(paste0(ESEUR_dir, "regression/coderev-acc_years.csv.xz"))

# Convert to percentage
rev_acc$accuracy=rev_acc$accuracy*100

# Some outliers
#rev_acc=rev_acc[-c(1, 4, 24), ]


plot(rev_acc$years.in.security, rev_acc$accuracy, col=point_col,
	xlab="Years working in security",
	ylab="Percentage of vulnerabilities detected\n")

year_span=0:8

loess_mod=loess(accuracy ~ years.in.security, data=rev_acc, span=0.9)
loess_pred=predict(loess_mod, newdata=data.frame(years.in.security=year_span))
lines(year_span, loess_pred, col="blue")

gl_mod=glm(accuracy ~ years.in.security, data=rev_acc)

y_pred=predict(gl_mod, newdata=list(years.in.security=year_span), type="response", se.fit=TRUE)

lines(year_span, y_pred$fit, col=pal_col[1])
# lines(year_span, y_pred$fit+1.96*y_pred$se.fit, col=pal_col[2])
# lines(year_span, y_pred$fit-1.96*y_pred$se.fit, col=pal_col[2])

