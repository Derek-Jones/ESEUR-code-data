#
# ist-scam08.R, 21 Feb 16
#
# Data from:
# The Life and Death of Statically Detected Vulnerabilities: an Empirical Study
# Massimiliano {Di Penta} and Luigi Cerulo and Lerina Aversano
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("cmprsk")

plot_layout(1, 2)

pal_col=rainbow(2)

#  ID: the unique ID
#  FILE: the file where it was detected
#  LINE: the source line where it was detected
#  CATEG: the vulnerability category according to our classification
#  START: snapshot where the vulnerability appeared
#  END: snapshot where the vulnerability disappeared or was removed (NA if live at the last snapshot analyzed)
#  WASREM: 1 if the vulnerability was removed, 0 otherwise
#  WASREMBUG: 1 if the vulnerability was removed because of a bug fixing, 0 otherwise
#  DISAP: 1 if the vulnerability disappeared, 0 otherwise
#  DISAPBUG: 1 if the vulnerability disappeared because of a bug fixing, 0 otherwise
#  HOWDISAP: NA if the vulnerability did not disappear, CHG if it disappeared because of a change in the source code line, COCHG if it disappeared because of a co-change
#  LONGDESCR: long vulnerability description as printed by the detection tool
#  SYSTEM: analyzed system
#rats=read.csv(paste0(ESEUR_dir, "survival/tool_rep/rats.csv.xz"), as.is=TRUE)
rats=read.csv(paste0(ESEUR_dir, "survival/tool_rep/splint.csv.xz"), as.is=TRUE)


rats$failtime=rats$END-rats$START
#rats$type=4*(rats$WASREM+2*rats$WASREMBUG)+rats$DISAP+2*rats$DISAPBUG
rats$type=rats$WASREM+2*rats$DISAP

plot_cif=function(sys_str)
{
# t=cuminc(rats$failtime, rats$CATEG, cencode=0,
t=cuminc(rats$failtime, rats$type, cencode=0,
	subset=(rats$SYSTEM == sys_str))

plot(t, col=pal_col, cex=1.25,
	curvlab=c("was removed", "disappeared"),
	xlab="Snapshot", ylab="Proportion flagged issues 'dead'\n")

text(max(t[[1]]$time)/1.5, 0.9, sys_str, cex=1.5)
}

plot_cif("samba")
plot_cif("squid")

