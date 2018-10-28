#
# RJ-2017_reg.R, 21 Oct 18
# Data from:
#
# Figure 3 from:
# Implementing a Metapopulation {Bass} Diffusion Model using the {{\sf R}} Package {deSolve}
# Jim Duggan
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example Bass-model sales

source("ESEUR_config.r")


link_4=function(start_row)
{
lines(c(0, 1), c(start_row, start_row), lty=2, col="grey")
lines(c(0, 1), c(start_row, start_row-1), lty=2, col="grey")
lines(c(0, 0), c(start_row, start_row-1), lty=2, col="grey")
lines(c(1, 1), c(start_row, start_row-1), lty=2, col="grey")
lines(c(0, 1), c(start_row-1, start_row), lty=2, col="grey")
rect(0-0.1, start_row-0.2, 0+0.1, start_row+0.2, col=point_col)
rect(1-0.1, start_row-0.2, 1+0.1, start_row+0.2, col=point_col)
text(0, start_row, pop_reg[start_row*2])
text(1, start_row, pop_reg[start_row*2-1])
}


pop_reg=c(0.10, 0.01, 0.21, 0.08, 0.17, 0.04, 0.05, 0.25, 0.03, 0.06)

plot(c(0-0.1, 1+0.1), c(1-0.2, 5+0.2), type="n", bty="n",
	xaxt="n", yaxt="n",
	xlab="", ylab="")

link_4(5)
link_4(4)
link_4(3)
link_4(2)
lines(c(0, 1), c(1, 1), lty=2, col="grey")
start_row=1
rect(0-0.1, start_row-0.2, 0+0.1, start_row+0.2, col=point_col)
rect(1-0.1, start_row-0.2, 1+0.1, start_row+0.2, col=point_col)
text(0, start_row, pop_reg[start_row*2])
text(1, start_row, pop_reg[start_row*2-1])


