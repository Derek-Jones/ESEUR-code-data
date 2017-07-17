#
# ESEUR-config.r,  6 Jun 17

# Assume the current directory unless told otherwise
ESEUR_dir=paste0(getwd(), "/")
#ESEUR_dir="/usr1/rbook/examples/"


library("colorspace")


# Outer Margin Area, default: par(oma=c(3, 3, 3, 3))
# Figure Margin, default: par(mar=c(5, 4, 4, 2)+0.1)
ESEUP_set_par=function(OMA=OMA_default, MAR=MAR_default)
{
# par(col="brown")
# par(col.axis="black")
par(bty="l")
par(las=1)
par(pch=point_pch)
# Length of tick marks as a fraction of the height of a line of text
par(tcl=-0.2)
par(xaxs="r")
par(yaxs="r")
ESEUR_global_cex=0.55
par(cex=ESEUR_global_cex)
par(cex.axis=0.67/ESEUR_global_cex)
par(cex.lab=0.7/ESEUR_global_cex)
ESEUR_legend_cex=1.2

#
# Do we want plotting clipped at the figure region?
# par(xpd=TRUE)

# Margin line for the title and axis
par(mgp=c(1.5, 0.45, 0))

# Outer Margin Area, default: par(oma=c(3, 3, 3, 3))
par(oma=OMA)

# Figure Margin, default: par(mar=c(5, 4, 4, 2)+0.1)
par(mar=MAR)
}

plot_layout=function(num_down, num_across,
		default_width=ESEUR_default_height, default_height=ESEUR_default_height,
		max_width=ESEUR_max_width, max_height=ESEUR_max_height)
{
if (num_across > 1)
   {
   if (num_down == 1)
      {
      layout(matrix(1:num_across, nrow=1), widths=rep(max_width/num_across, num_across), heights=default_height, TRUE)
      }
   else
      {
      layout(matrix(1:(num_down*num_across), nrow=num_down), widths=rep(max_width/num_across, num_across), heights=rep(max_height/num_down, num_down), TRUE)
      }
   }
else if (num_down > 1)
   {
   if (num_across == 1)
      {
      layout(matrix(1:num_down, nrow=num_down), widths=default_width, heights=rep(max_height/num_down, num_down), TRUE)
      }
   else
      {
      layout(matrix(1:(num_down*num_across), nrow=num_down), widths=rep(max_width/num_across, num_across), heights=rep(max_height/num_down, num_down), TRUE)
      }
   }
else
   par(fin=c(default_width/2.54, default_height/2.54)) # cm -> inches
ESEUP_set_par()
}


plot_wide=function()
{
layout(matrix(1:1, nrow=1), widths=ESEUR_default_width*1.3, heights=ESEUR_default_height*0.8, TRUE)
ESEUP_set_par()
}


OMA_default=c(2, 2, 1, 1)
MAR_default=c(3, 4.2, 1, 1)+0.1

# In centemeters
ESEUR_max_width=16
ESEUR_max_height=14
ESEUR_default_width=7
ESEUR_default_height=7

set_width_height=function(
		max_width=ESEUR_max_width,
		max_height=ESEUR_max_height,
		default_width=ESEUR_default_width,
		default_height=ESEUR_default_height)
{
ESEUR_max_width <<- max_width
ESEUR_max_height <<- max_height
ESEUR_default_width <<- default_width
ESEUR_default_height <<- default_height
}


point_pch=3
point_col="salmon3"
loess_col="yellow"

# Settings for slides
# ESEUR_max_width=20
# ESEUR_max_height=17
# ESEUR_default_width=10
# ESEUR_default_height=10
# point_col="tan"
# loess_col="yellow"

# In inches
# par(fin=c(4.5, 4.5))

# In inches, not cm
par(fin=c(ESEUR_default_width/2.54, ESEUR_default_height/2.54))
# Layout behaves oddly in this case:
# layout(matrix(1:1, ncol=1), widths=default_width, heights=default_height, TRUE)

# nf = layout(matrix(1), widths = lcm(5), heights = lcm(5))
# layout.show(nf)

# Printed line width, matched to book text width in courier font
options(width=75)

ESEUP_set_par()
