#
# dc-simex.R, 29 Oct 14
#
# Data from:
# github.com/gregkh/kernel-history
# Last updated Jun 2016
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("simex")


# version,date released,days,commits,number files,number lines,lines added,lines removed,lines modified,number developers,number employers,changes per day,changes per hour,% growth files,% growth lines,lines added per day,lines removed per day,lines changed per day,lines added per hour
ks=read.csv(paste0(ESEUR_dir, "regression/kernel_stats.csv.xz"), as.is=TRUE)

# Only lines in previous release can be counted as modified
#ks$percent_mod=100*c(NA, ks$lines.modified[-1]/ks$number.lines[-nrow(ks)])

#ks$percent_mod=ks$lines.modified/ks$number.lines

#ks$date.released=as.Date(ks$date.released, format="%d/%m/%y")


ks_na=na.omit(ks)

x = ks_na$number.developers
y = ks_na$commits

yx_line = glm(y ~ x, x=TRUE, y=TRUE) # Assume x values do not contain any error

# plot(y ~ x,
# 	xlab="Developers", ylab="Commits")
# abline(reg=yx_line, col="red")

sim_mod=simex(yx_line, SIMEXvariable="x",  measurement.error=41)

# abline(reg=sim_mod, col="green")

# summary(yx_line)
print(summary(sim_mod))

