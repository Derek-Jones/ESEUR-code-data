#
# paper-npm.R, 25 May 18
# Data from:
# On the impact of security vulnerabilities in the npm package dependency network
# Alexandre Decan and Tom Mens and Eleni Constantinou
#
# Data obtained by executing the first 178 lines of Vulnerabilities.py
# (nbconvert of original Vulnerabilities.ipynb) followed by the assignment to
# kmp_df at line 1428 (not the one at 1533), followed by kmp_df.to_csv(...).
# Removing the divide by 30 (days to months) causes odd things to happen,
# which I did not track down.  So column output was multiplied by 30; also
# the first (unused) column was deleted.
# 
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")
library("survival")


pal_col=rainbow(4)


severity_km=function(df, col_num=1)
{
base=subset(df, Kind == "base")
depend=subset(df, Kind == "dependent")

depend_s=survfit(Surv(depend$duration, depend$observed) ~ 1)
lines(depend_s, col=pal_col[col_num])

base_s=survfit(Surv(base$duration, base$observed) ~ 1)
lines(base_s, col=pal_col[col_num+1])

# text(50, 0.2, df$Severity[1])
}


npm=read.csv(paste0(ESEUR_dir, "reliability/paper-npm.csv.xz"), as.is=TRUE)

# npm$observed=(npm$observed == "True")

pos_npm=subset(npm, duration > 0)

# d_ply(pos_npm, .(Severity), severity_km)

s_high=subset(pos_npm, Severity == "high")
s_medium=subset(pos_npm, Severity == "medium")

plot(0, type="n",
	xaxs="i", yaxs="i",
	xlim=c(0, 1096), ylim=c(0, 1),
	xlab="Days", ylab="Survival\n")

severity_km(s_high, 1)
severity_km(s_medium, 3)

legend(x="topright", legend=c("high-Depend", "high-Base", "medium-Depend", "medium-Base"), bty="n", fill=pal_col, cex=1.2)

