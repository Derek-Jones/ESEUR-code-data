#
# censoring.R, 23 Mar 20
# Data from:
# Example
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example data-censored survival_example


source("ESEUR_config.r")


library("diagram")

plot_wide(w_height=ESEUR_default_height*0.6)


pal_col=rainbow(2)


plot(0, bty="n", xaxt="n", yaxt="n",
        xlim=c(0.5, 3), ylim=c(-0.2, 1),
        xlab="", ylab="")


straightarrow(c(0, 0), c(3, 0), arr.type="curved", arr.pos=1, lcol=pal_col[2])
text(2.8, 0.05, "Time", cex=1.3)

straightarrow(c(1.0, 0.3), c(2.2, 0.3), arr.type="curved", arr.pos=1, lcol=pal_col[2])
text(0.9, 0.3, "Right-censored\nsubject", pos=2, cex=1.3)
text(2.25, 0.3, "Subject\nexperiences event", pos=4, cex=1.3)

straightarrow(c(1.0, 0.6), c(1.3, 0.6), arr.type="curved", arr.pos=1, lcol=pal_col[2])
text(0.9, 0.6, "Uncensored\nsubject", pos=2, cex=1.3)
text(1.35, 0.6, "Subject\nexperiences event", pos=4, cex=1.3)

straightarrow(c(1.3, 0.95), c(1.05, 0.95), arr.type="curved", arr.pos=1, lcol=pal_col[2])
text(1.5, 1.02, "Observation\nperiod", pos=1, cex=1.3)
straightarrow(c(1.7, 0.95), c(1.95, 0.95), arr.type="curved", arr.pos=1, lcol=pal_col[2])

straightarrow(c(2.3, 0.75), c(2.05, 0.75), arr.type="curved", arr.pos=1, lcol=pal_col[2])
text(2.5, 0.82, "Subjects not\nobserved", pos=1, cex=1.3)
straightarrow(c(2.7, 0.75), c(3, 0.75), arr.type="curved", arr.pos=1, lcol=pal_col[2])

lines(c(1, 1), c(-0.05, 1), col=pal_col[1])
text(1.03, -0.1, "Started measuring", pos=3, cex=1.3)
text(1, -0.15, "t=0", pos=3, cex=1.3)
lines(c(2, 2), c(-0.05, 1), col=pal_col[1])
text(2.03, -0.1, "Stopped measuring", pos=3, cex=1.3)


