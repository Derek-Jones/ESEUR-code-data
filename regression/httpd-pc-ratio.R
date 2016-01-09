#
# httpd-pc-ratio.R,  2 Dec 15
#
# Data from:
# Intensive Metrics for the Study of the Evolution of Open Source Projects: Case studies from Apache Software Foundation projects
# Santiago Gala-P\'{e}rez and Gregorio Robles and Jes\'{u}s M. Gonz\'{a}lez-Barahona and Israel Herraiz
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

httpd=read.csv(paste0(ESEUR_dir, "regression/httpd.csv.xz"), as.is=TRUE)

pal_col=rainbow(4)

xbounds=c(1, nrow(httpd))
ybounds=c(1, max(httpd$total))

plot(httpd$total, type="l", col=pal_col[1],
	xlim=xbounds, ylim=ybounds,
        xlab="Months", ylab="Activity per month\n")

lines(httpd$commits, col=pal_col[2])


pc_ratio=100*httpd$total/(httpd$commits+0.5)

lines(pc_ratio, col=pal_col[3])

lines(runmed(pc_ratio, k=31), col=pal_col[4])


