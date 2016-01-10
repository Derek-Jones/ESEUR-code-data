#
# web-sec-review.R,  9 Jan 16
#
# Data from:
# An empirical study on the effectiveness of security code review
# Anne Edmundson and Brian Holtkamp and Emanuel Rivera and Matthew Finifter and Adrian Mettler and David Wagner
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


# s/S used to select which line transition is used.
plot_pred=function(fit_mod, line_col, conf_col, up_conf="S", low_conf="s")
{
y_pred=predict(fit_mod, newdata=list(web_sec_reviews=x_bnd), type="response", se.fit=TRUE)

lines(x_bnd, y_pred$fit, col=line_col, type=up_conf)
lines(x_bnd, y_pred$fit+1.96*y_pred$se.fit, col=conf_col, type=up_conf)
lines(x_bnd, y_pred$fit-1.96*y_pred$se.fit, col=conf_col, type=low_conf)
}


pal_col=rainbow(4)

# correct,web_sec_reviews
cor_web=read.csv(paste0(ESEUR_dir, "regression/coderev-cor_rev.csv.xz"))

# Remove outliers
cor_web=cor_web[-c(2, 11, 13), ]

x_bnd=min(cor_web$web_sec_reviews):max(cor_web$web_sec_reviews)

plot(jitter(cor_web$web_sec_reviews), cor_web$correct, col=point_col,
	xlab="Previous web security reviews", ylab="Correct reports")

l_mod=glm(correct ~ web_sec_reviews, data=cor_web)
plot_pred(l_mod, pal_col[2], pal_col[3], "c", "c")

# gl_mod=glm(correct ~ web_sec_reviews, data=cor_web, family=poisson)
gl_mod=glm(correct ~ web_sec_reviews, data=cor_web,
		family=poisson(link="identity"),
		start=c(1,1))
plot_pred(gl_mod, pal_col[1], pal_col[4])

