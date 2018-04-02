#
# Wason.R, 16 Jan 17
# Data from:
# Reasoning
# P. C. Wason
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(1, 1, default_width=11, default_height=5)

mk_card=function(x_pos, sym_str)
{
polygon(c(x_pos, x_pos+x_wid, x_pos+x_wid, x_pos, x_pos),
	c(0, 0, 1, 1, 0), col=point_col)
text(x_pos+x_wid/2, 0.5, sym_str, cex=3)
}


x_wid=0.7

plot(0, type="n", bty="n", xaxt="n", yaxt="n", col=point_col,
        xlim=c(0.9, 4.1+x_wid), ylim=c(0, 1.5),
        xlab="", ylab="")

mk_card(1, "A")
mk_card(2, "K")
mk_card(3, "4")
mk_card(4, "7")

