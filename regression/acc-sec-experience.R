#
# acc-sec-experience.R.R, 23 Apr 20
#
# Data from:
# An empirical study on the effectiveness of security code review
# Anne Edmundson and Brian Holtkamp and Emanuel Rivera and Matthew Finifter and Adrian Mettler and David Wagner
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG human_experiment fault-detection employment


source("ESEUR_config.r")


pal_col=rainbow(3)

# accuracy,years.in.security
rev_acc=read.csv(paste0(ESEUR_dir, "regression/coderev-acc_years.csv.xz"))

# Convert to percentage
rev_acc$accuracy=rev_acc$accuracy*100

# Remove some outliers
#rev_acc=rev_acc[-c(1, 4, 24), ]


plot(rev_acc$years.in.security, rev_acc$accuracy, col=pal_col[2],
	yaxs="i",
	xlab="Years working in security",
	ylab="Percentage of vulnerabilities detected\n")

year_span=0:8

loess_mod=loess(accuracy ~ years.in.security, data=rev_acc, span=0.9)
loess_pred=predict(loess_mod, newdata=data.frame(years.in.security=year_span))
lines(year_span, loess_pred, col=pal_col[3])

gl_mod=glm(accuracy ~ years.in.security, data=rev_acc)

y_pred=predict(gl_mod, newdata=list(years.in.security=year_span), type="response", se.fit=TRUE)

lines(year_span, y_pred$fit, col=pal_col[1])
# lines(year_span, y_pred$fit+1.96*y_pred$se.fit, col=pal_col[3])
# lines(year_span, y_pred$fit-1.96*y_pred$se.fit, col=pal_col[3])

