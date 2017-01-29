#
# text-rot.R, 24 Jan 17
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot(0, type="n", bty="n", xaxt="n", yaxt="n",
        xlim=c(0, 1), ylim=c(0, 1),
        xlab="", ylab="")

text(0.5, 0.5, srt=60, label="Easier to use a hardware rotation, than a software rotation")

