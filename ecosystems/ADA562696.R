#
# ADA562696.R, 27 Mar 17
# Data from:
# Sustaining {Air Force} Aging Aircraft into the $21^{st}$ Century
# Alan Eckbreth and Charles Saff and Kevin Connolly and Natalie Crawford and Chris Eick and Mark Goorsky and Neil Kacena and David Miller and Robert Schafrik and Douglas Schmidt and Daniel Stein and Michael Stroscio and Gregory Washington and John Zolper
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("reshape2")


plot_layout(1, 1, default_height=10)
pal_col=rainbow(3)


aircraft=read.csv(paste0(ESEUR_dir, "ecosystems/ADA562696.csv.xz"), as.is=TRUE)

# Clean up data
t=melt(aircraft, "Status", variable.name="Year")
aircraft=subset(t, value != "")
aircraft$Year=as.numeric(substring(aircraft$Year, 2))


dis_vec=function(vec, y_off, col_str)
{
if (nrow(vec) <= 8)
   text(5, y_off, paste(vec$value, collapse=", "), col=col_str)
else
   {
   text(5, y_off+0.5, paste(vec$value[1:8], collapse=", "), col=col_str)
   text(5, y_off-2.5, paste(vec$value[9:nrow(vec)], collapse=", "), col=col_str)
   }
}


dis_decade=function(decade)
{
ac=subset(aircraft, Year == decade)

cur=subset(ac, Status == "Current")
dis_vec(cur, decade+2, pal_col[2])

out=subset(ac, Status == "Out")
dis_vec(out, decade-2, pal_col[3])

fut=subset(ac, Status == "Future")
dis_vec(fut, decade-2, pal_col[1])

text(5, decade+5, decade, cex=0.9)
lines(c(0, 4), c(decade+5, decade+5), col="grey", lwd=0.4)
lines(c(6, 10), c(decade+5, decade+5), col="grey", lwd=0.4)
}


plot(0, type="n", bty="n", xaxt="n", yaxt="n", xaxs="i", yaxs="i",
        xlim=c(0, 10), ylim=c(1945, 2030),
        xlab="", ylab="")

decades=seq(1950, 2020, by=10)

dummy=sapply(seq(1950, 2020, by=10), function(X) dis_decade(X))

legend(x="topright", legend=c("Planned", "Flying", "Withdrawn"), bty="n", fill=pal_col, cex=1.2)

