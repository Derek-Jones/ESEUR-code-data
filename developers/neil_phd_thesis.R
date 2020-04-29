#
# neil_phd_thesis.R, 21 Apr 20
# Example based on figures appearing in:
# Constructing the world: {Active} causal learning in cognition
# Neil Robert Bramley
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example experiment_human

source("ESEUR_config.r")


par(mar=MAR_default-c(2.7, 2.7, 0, 0.8))

pal_col=rainbow(3)


draw_circle=function(x, y, rad)
{
angles<-seq(0, 2*pi, by=0.01)
xt<-x+cos(angles)*rad
yt<-y+sin(angles)*rad
polygon(xt, yt, border="grey", col="grey")
}


three_circles=function(x, y, col_str="white")
{
xs=x-c_rad*2.5
xe=x+c_rad*2.5
ys=y-c_rad*2.5
ye=y+c_rad*2.5

polygon(c(xs-0.5, xe+0.5, xe+0.5, xs-0.5, xs-0.5), c(ye, ye, ys-1, ys-1, ye),
		border="white", col=col_str)
draw_circle(x, y, c_rad)
draw_circle(x-0.5, y-1, c_rad)
draw_circle(x+0.5, y-1, c_rad)
}


triange_line=function(y, cb)
{
three_circles(1, y, ifelse(!cb, "white", "pale green"))
three_circles(1+1*tri_xoff, y, ifelse(cb, "white", "pale green"))
three_circles(1+2*tri_xoff, y, ifelse(!cb, "white", "pale green"))
}


intervention=function(from, to, x, y)
{
# node numbering starts at the top: 1, bottom left:2, bottom right: 3
# x/y is the triange coordinates.  Bottom left is 0/0

n1_x=1+x*tri_xoff
n1_y=1+y*tri_yoff
x_node=c(0, -0.5, 0.5)
y_node=c(0, -1, -1)

x_from_off=ifelse(from+to == 5, ifelse(from==2, c_rad, -c_rad), 0)
x_to_off=-x_from_off
y_from_off=ifelse(from+to == 5, 0, ifelse(from==1, -c_rad, c_rad))
y_to_off=-y_from_off

arrows(n1_x+x_node[from]+x_from_off, n1_y+y_node[from]+y_from_off,
		n1_x+x_node[to]+x_to_off, n1_y+y_node[to]+y_to_off,
		length=0.05)
}



c_rad=0.1
tri_xoff=1.7
tri_yoff=1.6

plot(0, type="n", bty="n",
	xaxs="i", yaxs="i",
	xaxt="n", yaxt="n",
	xlim=c(0.3, 5.2), ylim=c(-0.2, 4.4),
	xlab="", ylab="")

triange_line(1, 0)
triange_line(1+1*tri_yoff, 1)
triange_line(1+2*tri_yoff, 0)

intervention(3, 2, 0, 0)
intervention(3, 1, 0, 1)
intervention(1, 2, 0, 2)

intervention(1, 3, 1, 0)
intervention(3, 2, 1, 0)
# intervention(3, 1, 1, 1)
intervention(2, 1, 1, 2)
intervention(1, 3, 1, 2)

intervention(3, 2, 2, 0)
intervention(3, 1, 2, 0)
intervention(2, 1, 2, 1)
intervention(2, 3, 2, 1)
intervention(1, 2, 2, 2)
intervention(1, 3, 2, 2)
intervention(3, 2, 2, 2)


