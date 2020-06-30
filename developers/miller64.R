#
# miller64.R, 26 Jun 20
# Data from:
# Free Recall of Self-Embedded {English} Sentences
# George A. Miller and Stephen Isard
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example sentence_parsing


source("ESEUR_config.r")


plot_layout(2, 1)
par(mar=c(1.6, 0, 1, 0))


pal_col=rainbow(3)


move_left=function()
{
lines(c(x_cur, x_cur-2*llen), c(y_cur, y_cur-2*dlen), col=pal_col[2])

x_cur <<- x_cur-2*llen
y_cur <<- y_cur-2*dlen
}

move_right=function()
{
lines(c(x_cur, x_cur+2*llen), c(y_cur, y_cur-2*dlen), col=pal_col[2])

x_cur <<- x_cur+2*llen
y_cur <<- y_cur-2*dlen
}

node=function(phrase, str, str_pos=2)
{
points(x_cur, y_cur, pch=16, col=pal_col[3])
text(x_cur, y_cur, phrase, pos=3, cex=1.2, col=pal_col[3])
lines(c(x_cur, x_cur-llen), c(y_cur, y_cur-dlen), col=pal_col[2])
text(x_cur-llen, y_cur-dlen, str, pos=str_pos, cex=1.2, col=pal_col[1])
lines(c(x_cur, x_cur+llen), c(y_cur, y_cur-dlen), col=pal_col[2])

x_cur <<- x_cur+llen
y_cur <<- y_cur-dlen
}

right_vp=function(str)
{
move_right()
points(x_cur, y_cur, pch=16, col=pal_col[3])
text(x_cur, y_cur, " vp", pos=3, cex=1.2, col=pal_col[3])
lines(c(x_cur, x_cur+llen), c(y_cur, y_cur-dlen), col=pal_col[2])
text(x_cur+llen, y_cur-dlen, str, pos=4, cex=1.2, col=pal_col[1])
x_cur <<- x_cur-2*llen
y_cur <<- y_cur+2*dlen
}


dlen=1.0
rlen=1.0
llen=1.2

x_cur=3
y_cur=15

plot(0, type="n", bty="n", xaxt="n", yaxt="n", xaxs="i", yaxs="i",
	xlim=c(-1, 22), ylim=c(0, y_cur+1.1),
	xlab="", ylab="")

text(x_cur, y_cur, "S 1", pos=3, cex=1.2, col=pal_col[3])

node("", "she")
node(" vp", "liked")
node(" np", "the man")
node(" cl", "that")
node(" vp", "visited")
node(" np", "the jeweller")
node(" cl", "that")
node(" vp", "made")
node(" np", "the ring")
node(" cl", "that")
node(" vp", "won")
node(" np", "the prize")
node(" cl", "that")
node(" vp", "was given")
text(x_cur, y_cur, "  at the fair", pos=1, cex=1.2, col=pal_col[1])

x_cur=5.8
y_cur=16.5

plot(0, type="n", bty="n", xaxt="n", yaxt="n", xaxs="i", yaxs="i",
	xlim=c(0, 11), ylim=c(0, y_cur+1),
	xlab="", ylab="")

text(x_cur, y_cur, "S 4", pos=3, cex=1.2, col=pal_col[3])
points(x_cur, y_cur, pch=16, col=pal_col[3])

move_left()
node(" np", "the prize")
node(" cl", "that")
right_vp("won")

points(x_cur, y_cur, pch=16, col=pal_col[3])
text(x_cur, y_cur, "s", pos=3, cex=1.2, col=pal_col[3])
move_left()
node(" np", "the ring")
node(" cl", "that")
right_vp("made")

points(x_cur, y_cur, pch=16, col=pal_col[3])
text(x_cur, y_cur, "s", pos=3, cex=1.2, col=pal_col[3])

move_left()
node(" np", "the jeweller")
node(" cl", "that")
right_vp("visited")

points(x_cur, y_cur, pch=16, col=pal_col[3])
text(x_cur, y_cur, "s", pos=3, cex=1.2, col=pal_col[3])
move_left()
node(" np", "the man")
node(" cl", "that")
text(x_cur, y_cur, "she liked", pos=4, cex=1.2, col=pal_col[1])

x_cur=5.8
y_cur=16.5

move_right()
node(" vp", "  was given", str_pos=1)
text(x_cur, y_cur, "  at the fair", pos=1, cex=1.2, col=pal_col[1])

