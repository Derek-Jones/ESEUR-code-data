#
# ESEUR-config.r,  6 Mar 16

# Assume the current directory unless told otherwise
ESEUR_dir=paste0(getwd(), "/")
#ESEUR_dir="/usr1/rbook/examples/"


library("colorspace")


# Outer Margin Area, default: par(oma=c(3, 3, 3, 3))
# Figure Margin, default: par(mar=c(5, 4, 4, 2)+0.1)
ESEUP_set_par=function(OMA=c(2, 2, 1, 1), MAR=c(3, 4.2, 1, 1)+0.1)
{
# par(col="brown")
# par(col.axis="black")
par(bty="l")
par(las=1)
par(pch=3)
# Length of tick marks as a fraction of the height of a line of text
par(tcl=-0.2)
par(xaxs="r")
par(yaxs="r")
ESEUR_global_cex=0.5
par(cex=ESEUR_global_cex)
par(cex.axis=0.7/ESEUR_global_cex)
par(cex.lab=0.8/ESEUR_global_cex)

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

plot_layout=function(num_down, num_across)
{
if (num_across > 1)
   {
   if (num_down == 1)
      {
      layout(matrix(1:num_across, nrow=1), widths=rep(ESEUR_max_width/num_across, num_across), heights=ESEUR_default_height, TRUE)
      }
   else if (num_down == 2)
      {
      layout(matrix(1:(num_down*num_across), nrow=2), widths=rep(ESEUR_max_width/num_across, num_across), heights=rep(ESEUR_max_height/2, 2), TRUE)
      }
   }
else if (num_down != 1)
   {
   layout(matrix(1:num_down, nrow=num_down), widths=ESEUR_max_width/1.5, heights=rep(ESEUR_max_height/num_down, num_down), TRUE)
   }
else
   par(fin=c(3.0, 3.0))
ESEUP_set_par()
}


plot_wide=function()
{
layout(matrix(1:1, nrow=1), widths=ESEUR_default_width*1.4, heights=ESEUR_default_height, TRUE)
ESEUP_set_par()
}


# In centemeters
ESEUR_max_width=16
ESEUR_max_height=14
ESEUR_default_width=7
ESEUR_default_height=7
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

# In inches
par(fin=c(3.0, 3.0))
# Layout behaves oddly in this case:
# layout(matrix(1:1, ncol=1), widths=default_width, heights=default_height, TRUE)

# nf = layout(matrix(1), widths = lcm(5), heights = lcm(5))
# layout.show(nf)

ESEUP_set_par()
