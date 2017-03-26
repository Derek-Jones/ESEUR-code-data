#
# accounting.R,  6 Feb 17
# Data from:
# Software Economics: How Do the Results of Intellectual Efforts Enter the Global Market Place
# Gio Wiederhold
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(7)


text_box=function(x_1, x_2, y_1, y_2, col_str, words, rotate=0)
{
polygon(c(x_1, x_2, x_2, x_1, x_1),
	c(y_1, y_1, y_2, y_2, y_1), col=col_str)
text((x_1+x_2)/2, (y_1+y_2)/2, words, cex=1.2, srt=rotate)
}


plot(0, type="n", bty="n", xaxt="n", yaxt="n", xaxs="i", yaxs="i",
        xlim=c(0, 8), ylim=c(0, 8),
        xlab="", ylab="")

text_box(0, 8, 6, 7, pal_col[1], "Sales = units sold X unit price")
text_box(1, 8, 5, 6, pal_col[2], "SW company revenue")
text_box(2, 8, 4, 5, pal_col[3], "Gross Income")
text_box(3, 8, 3, 4, pal_col[4], "Operating Income")
text_box(4, 8, 2.1, 3, pal_col[5], "Net Income")
text_box(5, 8, 1.2, 2.1, pal_col[6], "Earnings")
text_box(6, 8, 0, 1.2, pal_col[7], "Profit")

text_box(0, 1, 0, 6, pal_col[1], "Distributor markup", 90)
text_box(1, 2, 0, 5, pal_col[2], "Production cost", 90)
text_box(2, 3, 0, 4, pal_col[3], "Admin overhead", 90)
text_box(3, 4, 0, 3, pal_col[4], "Research", 90)
text_box(4, 5, 0, 2.1, pal_col[5], "Capital cost", 90)
text_box(5, 6, 0, 1.2, pal_col[6], "Taxes", 90)

