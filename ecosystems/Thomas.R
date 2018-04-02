#
# Thomas.R, 17 Mar 18
# Data from:
# Security metrics for computer systems
# Daniel R. Thomas
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("diagram")


plot_layout(1, 1, default_width=ESEUR_default_width+1,
		default_height=ESEUR_default_height+3)

elpos=coordinates (c(4, 2, 3, 1, 2, 1))

# Nodes appear left to right, starting top left, finish bottom right
names=c("   ", "OpenSSL ", " BouncyCastle\n(176)", "    ",
	"Other\nprojects", "Linux",
	" ", "Google", "Hardware\ndeveloper",
	"Device manufacturer\n(402)",
	"  ", "Network operator\n(1,650)",
	"Device\n(24,600)")

M=matrix(data=0, nrow=length(names), ncol=length(names))
colnames(M)=names
rownames(M)=names

#
M["OpenSSL ", "Google"]="52"; M[" BouncyCastle\n(176)", "Google"]="6"
M["Other\nprojects", "Google"]=""; M["Linux", "Google"]="602"
M["Google", "Device manufacturer\n(402)"]="30"; M["Hardware\ndeveloper", "Device manufacturer\n(402)"]=""
M["Hardware\ndeveloper", "Linux"]=""
M["Device manufacturer\n(402)", "Network operator\n(1,650)"]=""
M["Device manufacturer\n(402)", "Device\n(24,600)"]=""
M["Network operator\n(1,650)", "Device\n(24,600)"]="1650"

plotmat(t(M), pos=elpos, lwd=1, arr.lcol="green", arr.pos=0.6, arr.length=0.15, cex=1.2,
         box.lcol="white", box.prop=0.5, box.size=0.05, box.cex=1.2, shadow.size=0)

