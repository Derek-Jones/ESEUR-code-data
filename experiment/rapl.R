#
# rapl.R, 10 Nov 18
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG

source("ESEUR_config.r")


# bench=read.csv(paste0(ESEUR_dir, "sourcecode/gtx480.csv"), as.is=TRUE)
rapl=read.csv(paste0("/home/data-rbook/rapl_DAT-19Jun2014/", "all-c.csv"), as.is=TRUE)

# $ Running         : chr  "static" "static" "static" "static" ...
# $ Hostname        : chr  "both" "both" "both" "both" ...
# $ pkg0_lim        : chr  "cab100" "cab100" "cab100" "cab100" ...
# $ pkg1_lim        : num  115 115 115 115 115 115 115 115 115 115 ...
# $ TimeStamp       : num  115 115 115 115 115 115 115 115 115 115 ...

table(rapl$Running)
#            EP     MG static 
#      9 212943 230826   5970 

table(rapl$Hostname)
#          both     s1     s2 
#      9  98491 183922 167326 

table(rapl$pkg1_lim)
#     30     40     50     65     80     95    115 
# 129506  59437  60910  50446  47828  47819  53793 

MG=subset(rapl, Running == "MG")
MG_s1=subset(MG, Hostname == "s1")

plot(MG_s1$pkg1_lim, MG_s1$execTime_Seconds, log="y", col=point_col,
	xlab="Power (Watts)", ylab="Time (seconds)\n")

plot(MG_s1$coreT1, MG_s1$execTime_Seconds, log="y", col=point_col,
	xlab="Power (Watts)", ylab="Time (seconds)\n")


