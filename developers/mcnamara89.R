#
# mcnamara89.R,  7 Dec 19
# Data from:
# Subjective Hierarchies in Spatial Memory
# Timothy P. McNamara and James K. Hardy and Stephen C. Hirtle
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human human_memory memory_organization


source("ESEUR_config.r")


plot_layout(2, 1)
par(mar=c(1, 1, 1, 1)+0.1)


pal_col=rainbow(2)


place_item=function(item_str, x, y)
{
text(x, y, item_str, cex=1.2, col=pal_col[1])
}


plot(0, type="n", bty="o", fg="grey",
	xaxt="n", yaxt="n",
	xlim=c(0, 125), ylim=c(0, 125),
	xlab="", ylab="")
place_item("gun", 15, 9)
place_item("ball", 31, 13)
place_item("shoe", 79, 8)
place_item("knife", 57, 20)
place_item("scissors", 83, 18)
place_item("button", 30, 32)
place_item("ring", 101, 30)
place_item("egg", 13, 38)
place_item("pen", 89, 40)
place_item("ruler", 44, 50)
place_item("coin", 50, 45)
place_item("cup", 14, 54)
place_item("rubberband", 66, 55)
place_item("screw", 101, 55)
place_item("eraser", 30, 65)
place_item("cork", 10, 75)
place_item("envelope", 69, 72)
place_item("truck", 91, 75)
place_item("flashlight", 24, 90)
place_item("book", 47, 84)
place_item("can", 36, 104)
place_item("cufflink", 58, 97)
place_item("lock", 80, 99)
place_item("thimble", 20, 114)
place_item("lighbulb", 67, 115)
place_item("glue", 106, 109)
place_item("cigarettes", 54, 120)
place_item("radio", 84, 121)


plot(0, type="n", bty="n",
	xaxt="n", yaxt="n",
	xlim=c(0, 3.7), ylim=c(-1.9, 1.8),
	xlab="", ylab="")

x_base=0
y_base=0
x_cur_pos=0
y_cur_pos=0

root_branch=function(x, y)
{
lines(c(x_base, x_base+x/2.0),
      c(y_base, y_base+x*(14.5-y)/14.5), col=pal_col[2])
x_cur_pos<<-x_base+x/2.0
y_cur_pos<<-y_base+x*(14.5-y)/14.5
}

sub_branch=function(x, y)
{
lines(c(x_cur_pos, x_cur_pos + x/2.0),
      c(y_cur_pos, y_cur_pos + x*(14.5-y)/29), col=pal_col[2])
x_cur_pos<<-x_cur_pos+x/2.0
y_cur_pos<<-y_cur_pos+x*(14.5-y)/29
}

leaf=function(str, y)
{
lines(c(x_cur_pos, 2.5),
      c(y_cur_pos, 2-y/7), col=pal_col[2])
text(2.5, 2-y/7, str, pos=4, cex=1.1, col=pal_col[1])
}

leaf("screw", 16)
leaf("truck", 17)
leaf("glue", 18)
leaf("lock", 19)
leaf("radio", 20)

root_branch(2, 2.5)
leaf("egg", 1)
leaf("cup", 2)
leaf("eraser", 3)
leaf("cork", 4)

root_branch(2, 6.0)
leaf("shoe", 5)
leaf("ball", 6)
leaf("gun", 7)

root_branch(1, 12.0)
leaf("ring", 8)
leaf("scissors", 9)
leaf("pen", 15)
sub_branch(2, 12)
leaf("knife", 10)
leaf("button", 11)
leaf("ruler", 12)
leaf("coin", 13)
leaf("rubberband", 14)

root_branch(1, 22.0)
leaf("cigarettes", 21)
sub_branch(2, 22.5)
leaf("cufflink", 22)
leaf("lightbulb", 23)

root_branch(2, 25.0)
leaf("thimble", 24)
leaf("can", 25)
leaf("flashlight", 26)

root_branch(2, 27.5)
leaf("envelope", 27)
leaf("book", 28)

