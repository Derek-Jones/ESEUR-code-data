#
# fillmore77.R,  8 Dec 16
# Data from:
# Topics in Lexical Semantics
# Charles J. Fillmore
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


par(oma=c(0, 0, 0, 0))
par(mar=c(0, 0, 0, 0)+0.1)

draw_box=function(x, y, side, A_str="", B_str="", C_str="", D_str="", join_inf=0)
{
lines(c(x, x+side, x+side, x, x),
	c(y, y, y+side, y+side, y), lwd=0.5, col=point_col)

text(x+side*0.2, y+side*0.5, A_str)
text(x+side*0.5, y+side*0.8, B_str)
text(x+side*0.5, y+side*0.2, C_str)
text(x+side*0.8, y+side*0.5, D_str)

lines(c(x+join_inf[1]*side, x+join_inf[1]*side+join_inf[3]*side*0.3),
	c(y+join_inf[2]*side, y+join_inf[2]*side+side*0.3),
	col="green", lwd=0.6)
}

outer_len=2.6
center_len=2.0

plot(0, type="n", bty="n", xaxt="n", yaxt="n", xaxs="i", yaxs="i",
	xlim=c(0, 2*outer_len+center_len), ylim=c(-0.05, 0.1+2*outer_len+center_len),
	xlab="", ylab="")

draw_box(0, 0, outer_len,
			"A\nto", "B\nObj", "C\nfor", "D\nSubj",
			c(0.8, 0.5, -1))
draw_box(0, outer_len+center_len, outer_len,
			"A\nSubj", "B\nObj", "C\nfor", "D\nfrom",
			c(0.2, 0.5, 1))
draw_box(outer_len+center_len, 0, outer_len,
			"A\nObj", "B\nfor", "C\nsum", "D\nSubj",
			c(0.5, 0.2, 1))
draw_box(outer_len+center_len, outer_len+center_len, outer_len,
			"A\nSubj", "B\nfor", "C\nObj", "D\nto",
			c(0.5, 0.2, -1))
draw_box(outer_len, outer_len, center_len,
			"A\nbuyer", "B\ngoods", "C\nmoney", "D\nseller")

text(outer_len/2, outer_len+0.2, "Sell", font=2)
text(outer_len/2, outer_len+center_len-0.2, "Buy", font=2)

text(outer_len+center_len+outer_len/2, outer_len+0.2, "Charge", font=2)
text(outer_len+center_len+outer_len/2, outer_len+center_len-0.2, "Pay", font=2)

text(outer_len+center_len/2, outer_len+center_len+0.3, "Commercial\nEvent", font=2)

