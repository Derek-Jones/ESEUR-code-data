#
# coderev.R, 22 Apr 20
#
# Data from:
# An empirical study on the effectiveness of security code review
# Anne Edmundson and Brian Holtkamp and Emanuel Rivera and Matthew Finifter and Adrian Mettler and David Wagner
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human code-review_security


source("ESEUR_config.r")


pal_col=rainbow(3)

# correct,false_report
rev_tf=read.csv(paste0(ESEUR_dir, "regression/coderev-cor_false.csv.xz"))
#rev_tf=rev_tf[-c(30), ]
#rev_tf=rev_tf[-c(28, 29, 30), ]
#rev_tf=rev_tf[-c(11, 22, 24, 25, 26, 27, 28, 29, 30), ]

plot(rev_tf$false_report, rev_tf$correct, col=pal_col[2],
	yaxs="i",
	ylim=c(-0.05, 5),
	xlab="False reports", ylab="Correct reports")

gl_mod=glm(correct ~ false_report, data=rev_tf, family=poisson(link="identity"))

# summary(gl_mod)

y_pred=predict(gl_mod, type="response", se.fit=TRUE)

lines(rev_tf$false_report, y_pred$fit, col=pal_col[1])
lines(rev_tf$false_report, y_pred$fit+1.96*y_pred$se.fit, col=pal_col[3])
lines(rev_tf$false_report, y_pred$fit-1.96*y_pred$se.fit, col=pal_col[3])


