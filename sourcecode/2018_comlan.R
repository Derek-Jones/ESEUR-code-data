#
# 2018_comlan.R, 29 Jun 18
# Data from:
# How Do Developers Use Dynamic Features? {The} Case of {Ruby}
# Elder {Rodrigues Jr.} and Ricardo Terra
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG Ruby source-code dynamic method LOC statement


source("ESEUR_config.r")


pal_col=rainbow(3)


dyn=read.csv(paste0(ESEUR_dir, "sourcecode/2018_comlan.csv.xz"), as.is=TRUE)

plot(dyn$Total_stmt, dyn$Dyn_stmt, log="xy", col=pal_col[3],
	xlim=range(c(dyn$Total_methods, dyn$Total_stmt)),
	ylim=range(c(dyn$Dyn_methods, dyn$Dyn_stmt)),
	xlab="Total", ylab="Dynamic\n")

s_mod=glm(log(Dyn_stmt) ~ log(Total_stmt), data=dyn)
# summary(s_mod)
pred=predict(s_mod)
s_ord=order(dyn$Total_stmt)
lines(dyn$Total_stmt[s_ord], exp(pred[s_ord]), col=pal_col[3])

points(dyn$Total_LOC, dyn$Dyn_LOC, col=pal_col[2])
L_mod=glm(log(Dyn_LOC) ~ log(Total_LOC), data=dyn)
# summary(L_mod)
pred=predict(L_mod)
L_ord=order(dyn$Total_LOC)
lines(dyn$Total_LOC[L_ord], exp(pred[L_ord]), col=pal_col[2])

points(dyn$Total_methods, dyn$Dyn_methods, col=pal_col[1])
m_mod=glm(log(Dyn_methods) ~ log(Total_methods), data=dyn)
# summary(m_mod)
pred=predict(m_mod)
m_ord=order(dyn$Total_methods)
lines(dyn$Total_methods[m_ord], exp(pred[m_ord]), col=pal_col[1])

legend(x="bottomright", legend=c("Methods", "LOC", "Statements"), bty="n", fill=pal_col, cex=1.2)


