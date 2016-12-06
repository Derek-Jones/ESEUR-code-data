#
# klahr83.R,  4 Nov 16
# Data from:
# Structure and Process in Alphabetic Retrieval
# David Klahr and William G. Chase and Eugene A.  Lovelace
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("diagram")


elpos=coordinates (c(6, 6, 6, 6, 6, 6, 6, 6))

names=c("1", "2", "3", "4", "5", "6",
	"A", "H", "L", "Q", "U", "W",
	"B", "I", "M", "R", "V", "X",
	"C", "J", "N", "S", "",  "Y",
	"D", "K", "O", "T", "",  "Z",
	"E", "",  "P", "",  "",  "",  
	"F", "",  "",  "",  "",  "",  
	"G", "",  "",  "",  "",  "")

M=matrix(data=0, nrow=length(names), ncol=length(names))
colnames(M)=names
rownames(M)=names

# 
M["1", "2"]=""
M["1", "A"]=""
M["2", "3"]=""
M["2", "H"]=""
M["3", "4"]=""
M["3", "L"]=""
M["4", "5"]=""
M["4", "Q"]=""
M["5", "6"]=""
M["5", "U"]=""
M["6", "W"]=""
M["A", "B"]="" ; M["B", "C"]="" ; M["C", "D"]="" ;
M["D", "E"]="" ; M["E", "F"]="" ; M["F", "G"]="" ;
M["H", "I"]="" ; M["I", "J"]="" ; M["J", "K"]="" ;
M["L", "M"]="" ; M["M", "N"]="" ; M["N", "O"]="" ;
M["O", "P"]="" ;
M["Q", "R"]="" ; M["R", "S"]="" ; M["S", "T"]="" ;
M["U", "V"]="" ;
M["W", "X"]="" ; M["X", "Y"]="" ; M["Y", "Z"]="" ;

plotmat(t(M), pos=elpos, lwd=1, arr.lcol="green", arr.pos=0.6, arr.length=0.15, cex=1.2,
	 box.lcol="white", box.prop=0.5, box.size=0.05, box.cex=1.2, shadow.size=0)


