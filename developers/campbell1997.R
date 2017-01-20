#
# campbell1997.R,  9 Dec 16
# Data from:
# On the Relation Between Skilled Performance of Simple Division and Multiplication
# Jamie I. D. Campbell
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 1)

pal_col=rainbow(2)


arith=read.csv(paste0(ESEUR_dir, "developers/campbell1997.csv.xz"), as.is=TRUE)

mult=subset(arith, operation=="mult")
mult$result=mult$L*mult$R

# plot(pmin(mult$L, mult$R), mult$errors, col=point_col,
# 	xlab="Minimum operand value", ylab="Errors")
plot(mult$L, mult$errors, col=pal_col[1],
	xlab="Operand value", ylab="Errors\n")
points(mult$R, mult$errors, col=pal_col[2])
legend(x="topleft", legend=c("Left operand", "Right operand"), bty="n", fill=pal_col, cex=1.2)
lines(loess.smooth(mult$L, mult$errors, span=0.3), col=loess_col)
lines(loess.smooth(mult$R, mult$errors, span=0.3), col=loess_col)


plot(mult$result, mult$errors, col=point_col,
	xlab="Result value", ylab="Errors\n")
squares=subset(mult, L == R)
points(squares$result, squares$errors, col=pal_col[2])

# lines(loess.smooth(mult$L*mult$R, mult$errors, span=0.3), col=loess_col)

# mult$min_op=pmin(mult$L, mult$R)
# 
# m_mod=glm(errors ~ result+min_op, data=mult)
# summary(m_mod)
# 
# # Squares have much lower error rates
# 
# no_squares=subset(mult, L != R)
# m_mod=glm(errors ~ result+min_op, data=no_squares)
# summary(m_mod)
# 

