#
# blockrot.R, 24 Jan 17
# Data from:
# Mental Rotation of Three-dimensional Objects
# Roger N. Shepard and Jacqueline Metzler
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

top_sq=function(x, y)
{
polygon(c(x, x+xl[1], x+xl[1]+yl[1], x+yl[1], x),
      c(y, y+xl[2], y+xl[2]+yl[2], y+yl[2], y), col="yellow", border="pink")
}


left_sq=function(x, y)
{
polygon(c(x, x+xl[1], x+xl[1]+zl[1], x+zl[1], x),
      c(y, y+xl[2], y+xl[2]+zl[2], y+zl[2], y), col="yellow", border="pink")
}

right_sq=function(x, y)
{
polygon(c(x, x+yl[1], x+yl[1]+zl[1], x+zl[1], x),
      c(y, y+yl[2], y+yl[2]+zl[2], y+zl[2], y), col="yellow", border="pink")
}

start_shape=function()
{
xl<<-c(0.1, -0.045)
yl<<-c(0.05, 0.08)
zl<<-c(0.024, -0.045)

top_sq(base_x, base_y)
left_sq(base_x, base_y)
#right_sq(base_x, base_y)
top_sq(base_x+xl[1], base_y+xl[2])
left_sq(base_x+xl[1], base_y+xl[2])
left_sq(base_x+xl[1]+zl[1], base_y+xl[2]+zl[2])
left_sq(base_x+xl[1]+2*zl[1], base_y+xl[2]+2*zl[2])
left_sq(base_x+xl[1]+3*zl[1], base_y+xl[2]+3*zl[2])

top_sq(base_x+xl[1]+3*zl[1]+yl[1], base_y+xl[2]+3*zl[2]+yl[2])
top_sq(base_x+xl[1]+3*zl[1]+2*yl[1], base_y+xl[2]+3*zl[2]+2*yl[2])
top_sq(base_x+xl[1]+3*zl[1]+3*yl[1], base_y+xl[2]+3*zl[2]+3*yl[2])
top_sq(base_x+xl[1]+3*zl[1]+3*yl[1]+xl[1], base_y+xl[2]+3*zl[2]+3*yl[2]+xl[2])
top_sq(base_x+xl[1]+3*zl[1]+3*yl[1]+2*xl[1], base_y+xl[2]+3*zl[2]+3*yl[2]+2*xl[2])

right_sq(base_x+2*xl[1], base_y+2*xl[2])
right_sq(base_x+2*xl[1]+zl[1], base_y+2*xl[2]+zl[2])
right_sq(base_x+2*xl[1]+2*zl[1], base_y+2*xl[2]+2*zl[2])
right_sq(base_x+2*xl[1]+3*zl[1], base_y+2*xl[2]+3*zl[2])

right_sq(base_x+2*xl[1]+3*zl[1]+yl[1], base_y+2*xl[2]+3*zl[2]+yl[2])
right_sq(base_x+2*xl[1]+3*zl[1]+2*yl[1], base_y+2*xl[2]+3*zl[2]+2*yl[2])

left_sq(base_x+2*xl[1]+3*zl[1]+2*yl[1]+yl[1], base_y+2*xl[2]+3*zl[2]+2*yl[2]+yl[2])
left_sq(base_x+2*xl[1]+3*zl[1]+2*yl[1]+yl[1]+xl[1], base_y+2*xl[2]+3*zl[2]+2*yl[2]+yl[2]+xl[2])

right_sq(base_x+2*xl[1]+3*zl[1]+2*yl[1]+yl[1]+2*xl[1], base_y+2*xl[2]+3*zl[2]+2*yl[2]+yl[2]+2*xl[2])
}


# bench=read.csv(paste0(ESEUR_dir, "developers/blockrot.csv"), as.is=TRUE)

# base=subset(bench, x < 1.0)

plot(0, type="n", bty="n", xaxt="n", yaxt="n",
	xlim=c(0, 1.4), ylim=c(0, 1.4),
	xlab="", ylab="")

lines(c(0, 1.4), c(0.75, 0.75), col="grey", lwd=0.3)

# plot(base, type="b")

base_x=0.0 ; base_y=0.5
start_shape()

base_x=0.0 ; base_y=1.2
start_shape()


# base=subset(bench, x > 1 & x < 2.0)

# plot(0, type="n", bty="n", xaxt="n", yaxt="n",
# 	xlim=c(0, 0.9), ylim=c(0, 0.9),
# 	xlab="", ylab="")

# plot(base, type="b")

base_x=0.9 ; base_y=0.3

xl=c(0.1, -0.027)
yl=c(0.051, 0.084)
zl=c(0.024, -0.064)

# These have to appear here to prevent overlap appearing
right_sq(base_x+3*yl[1]+xl[1]+zl[1], base_y+3*yl[2]+xl[2]+zl[2])
left_sq(base_x+3*yl[1]      +zl[1], base_y+3*yl[2]      +zl[2])
right_sq(base_x+3*yl[1]+xl[1]+2*zl[1], base_y+3*yl[2]+xl[2]+2*zl[2])
left_sq(base_x+3*yl[1]      +2*zl[1], base_y+3*yl[2]      +2*zl[2])

right_sq(base_x+yl[1]+xl[1], base_y+yl[2]+xl[2])

top_sq(base_x, base_y)
left_sq(base_x, base_y)
#right_sq(base_x, base_y)
top_sq(base_x+xl[1], base_y+xl[2])
left_sq(base_x+xl[1], base_y+xl[2])
top_sq(base_x+2*xl[1], base_y+2*xl[2])
left_sq(base_x+2*xl[1], base_y+2*xl[2])
left_sq(base_x+3*xl[1], base_y+3*xl[2])
left_sq(base_x+3*xl[1]-zl[1], base_y+3*xl[2]-zl[2])
top_sq(base_x+3*xl[1]-zl[1], base_y+3*xl[2]-zl[2])

right_sq(base_x+4*xl[1], base_y+4*xl[2])
right_sq(base_x+4*xl[1]-zl[1], base_y+4*xl[2]-zl[2])

top_sq(base_x+yl[1], base_y+yl[2])
# right_sq(base_x+yl[1]+xl[1], base_y+yl[2]+xl[2])
top_sq(base_x+2*yl[1], base_y+2*yl[2])
right_sq(base_x+2*yl[1]+xl[1], base_y+2*yl[2]+xl[2])
top_sq(base_x+3*yl[1], base_y+3*yl[2])
right_sq(base_x+3*yl[1]+xl[1], base_y+3*yl[2]+xl[2])


# base=subset(bench, x > 2.5)

# plot(0, type="n", bty="n", xaxt="n", yaxt="n",
# 	xlim=c(0.9, 1.9), ylim=c(0, 0.9),
#  	xlab="", ylab="")

# plot(base, type="b")

base_x=0.9 ; base_y=1.2

xl=c(0.07, 0.01)
yl=c(0.046, 0.085)
zl=c(0.074, -0.07)

# These have to appear here to prevent overlap appearing
top_sq(base_x+3*zl[1]-xl[1]+3*yl[1], base_y+3*zl[2]-xl[2]+3*yl[2])
left_sq(base_x+3*zl[1]-xl[1]+3*yl[1], base_y+3*zl[2]-xl[2]+3*yl[2])
top_sq(base_x+3*zl[1]-2*xl[1]+3*yl[1], base_y+3*zl[2]-2*xl[2]+3*yl[2])
left_sq(base_x+3*zl[1]-2*xl[1]+3*yl[1], base_y+3*zl[2]-2*xl[2]+3*yl[2])

top_sq(base_x+3*zl[1]      +yl[1], base_y+3*zl[2]      +yl[2])

top_sq(base_x, base_y)
left_sq(base_x, base_y)
left_sq(base_x+zl[1], base_y+zl[2])
right_sq(base_x+zl[1]+xl[1], base_y+zl[2]+xl[2])
left_sq(base_x+2*zl[1], base_y+2*zl[2])
right_sq(base_x+2*zl[1]+xl[1], base_y+2*zl[2]+xl[2])
left_sq(base_x+3*zl[1], base_y+3*zl[2])
right_sq(base_x+3*zl[1]+xl[1], base_y+3*zl[2]+xl[2])

top_sq(base_x+xl[1], base_y+xl[2])
left_sq(base_x+xl[1], base_y+xl[2])
right_sq(base_x+2*xl[1], base_y+2*xl[2])

right_sq(base_x+3*zl[1]+xl[1]+yl[1], base_y+3*zl[2]+xl[2]+yl[2])
# top_sq(base_x+3*zl[1]      +yl[1], base_y+3*zl[2]      +yl[2])
right_sq(base_x+3*zl[1]+xl[1]+2*yl[1], base_y+3*zl[2]+xl[2]+2*yl[2])
top_sq(base_x+3*zl[1]      +2*yl[1], base_y+3*zl[2]      +2*yl[2])
right_sq(base_x+3*zl[1]+xl[1]+3*yl[1], base_y+3*zl[2]+xl[2]+3*yl[2])
top_sq(base_x+3*zl[1]      +3*yl[1], base_y+3*zl[2]      +3*yl[2])

