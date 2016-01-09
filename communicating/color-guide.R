#
# color-guide.R,  5 Jan 16
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_sq=function(x, y, sq_col)
{
x_sq=c(x, x+1, x+1, x)
y_sq=c(y, y, y+0.5, y+0.5)

polygon(x_sq, y_sq, col=sq_col)
}

plot_colset=function(x_start, y_start, col_func, num_col)
{

pal_col=col_func(num_col)

lapply(0:(num_col-1), function(x) plot_sq(x_start+x, y_start, pal_col[x+1]))

}


plot(0, 0, bty="n", xaxt="n", yaxt="n",
	xlab="", ylab="",
	xlim=c(1, 28), ylim=c(1, 4))

t=plot_colset(1, 1, rainbow, 3)
t=plot_colset(6, 1, rainbow, 7)
t=plot_colset(15, 1, rainbow, 12)
text(15, 0.92, label="rainbow", cex=1.3)

t=plot_colset(1, 1.8, rainbow_hcl, 3)
t=plot_colset(6, 1.8, rainbow_hcl, 7)
t=plot_colset(15, 1.8, rainbow_hcl, 12)
text(15, 1.72, label="rainbow_hcl", cex=1.3)

t=plot_colset(1, 2.6, sequential_hcl, 3)
t=plot_colset(6, 2.6, sequential_hcl, 7)
t=plot_colset(15, 2.6, sequential_hcl, 12)
text(15, 2.52, label="sequential_hcl", cex=1.3)

t=plot_colset(1, 3.4, diverge_hcl, 3)
t=plot_colset(6, 3.4, diverge_hcl, 7)
t=plot_colset(15, 3.4, diverge_hcl, 12)
text(15, 3.32, label="diverge_hcl", cex=1.3)

