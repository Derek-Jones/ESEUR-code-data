#
# false-positive.R,  6 Jan 16
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

# Equations taken from:
# www.mathpages.com/home/kmath341.htm equation 2
#
run_prob=function(k, q, m)
{
# Equation is zero based and R is one based
n=m+1
p_v=vector(length=k+1)
# Initial values
p_v[1:(n-1)]=0
p_v[n]=q^m

q_m=q^m*(1-q)

# Pr(k, q, n) = Pr(k-1, q, n) + (q^n)(1-q) (1 - Pr(k-n-1, q, n))
for (i in (n+1):(k+1))
   p_v[i]=p_v[i-1]+q_m*(1-p_v[i-m-1])

return(p_v)
}


plot_run_prob=function(k, q, m, prob_col)
{
t=1-run_prob(k, q, m)

lines(t, col=prob_col)

text_off=23-2*m
text(text_off, t[text_off], q, cex=1.2)
}

max_warnings=30

plot(1, type="n",
	xlim=c(3, max_warnings), ylim=c(0, 1),
	xlab="Number of warnings", ylab="Probability\n")

t=sapply(seq(0.2, 0.5, by=0.1), function(X) plot_run_prob(max_warnings, X, 3, pal_col[1]))
t=sapply(seq(0.2, 0.5, by=0.1), function(X) plot_run_prob(max_warnings, X, 4, pal_col[2]))

legend(x="bottomleft", legend=c("3 false positives", "4 false positives"), bty="n", fill=pal_col, cex=1.3)

