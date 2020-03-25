#
# dimarco93.R,  5 Mar 20
# Data from:
# The semantic and stylistic differentiation of synonyms and near-synonyms
# Chrysanne DiMarco and Graeme Hirst and Manfred Stede
# Example in paper
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG language_similarity


source("ESEUR_config.r")


par(mar=MAR_default-c(0.0, 3.7, 0.0, 0.7))

pal_col=rainbow(2)


word_divide=function(x_start, x_end, y_pos, name_str)
{
lines(c(x_end    , x_end-0.1), c(y_pos, y_pos-0.1), col=pal_col[2])
lines(c(x_end-0.1, x_end+0.1), c(y_pos-0.1, y_pos-0.3), col=pal_col[2])
lines(c(x_end+0.1, x_end-0.1), c(y_pos-0.3, y_pos-0.5), col=pal_col[2])
lines(c(x_end-0.1, x_end+0.1), c(y_pos-0.5, y_pos-0.7), col=pal_col[2])
lines(c(x_end+0.1, x_end-0.1), c(y_pos-0.7, y_pos-0.9), col=pal_col[2])
lines(c(x_end-0.1, x_end    ), c(y_pos-0.9, y_pos-1.0), col=pal_col[2])

text(x_start+(x_end-x_start)/2, y_pos-0.5, name_str, cex=1.2, col=pal_col[1])
}


lang_wood=function(y_pos, lang_str, names, x_pos)
{
x_pos=4*c(0, x_pos, 1.05)
lines(c(0, 4), c(y_pos, y_pos), col="grey")
text(-1.15, y_pos-0.5, lang_str, cex=1.3, pos=4)
d=sapply(1:length(names), function(X)
			 word_divide(x_pos[X], x_pos[X+1], y_pos, names[X]))
}



plot(0, type="n", bty="n",
	xaxs="i", yaxs="i",
	xaxt="n", yaxt="n",
	xlim=c(-1.2, 4), ylim=c(0, 5),
	xlab="", ylab="")

lines(c(0, 4), c(0, 0), col="grey")
lines(c(0, 0), c(0, 5), col="grey")
lines(c(0, 4), c(5, 5), col="grey")
lines(c(4, 4), c(0, 5), col="grey")

lang_wood(5, "English", c("tree", "wood", "forest"), c(0.23, 0.7))
lang_wood(4, "French", c("abre", "bois", iconv(paste0("for", rawToChar(as.raw(234)), "t"), from="latin1", to="UTF-8")), c(0.23, 0.7))
lang_wood(3, "Dutch", c("boom", "hout", "bos", "woud"), c(0.23, 0.45, 0.7))
lang_wood(2, "German", c("baum", "holz", "wald"), c(0.23, 0.45))
lang_wood(1, "Danish", c(iconv(paste0("tr", rawToChar(as.raw(230))), from="latin1", to="UTF-8"), "skov"), c(0.30))


