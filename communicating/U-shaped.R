#
# U-shaped.R, 22 Aug 18
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones

source("ESEUR_config.r")


x=1:200

pal_col=rainbow(2)

plot(x, 30/x, type="l", col=pal_col[1],
	xlab="LOC", ylab="Faults/LOC\n")

lines(x, 20/x+0.02*x, col=pal_col[2])


# V. R. Basili and B. R. Perricone,
# ”Software errors and complexity“
# CACM, vol. 27, pp. 42-52, Jan. 1984.
# Module Size (max),Module count,Cyclomatic complexity,Defect density (/KLOC)
# 50 258 6 16
# 100 70 17.9 12.6
# 150 26 28.1 12.4
# 200 13 52.7 7.6
# 225 3 60 6.4
# 
# C. Withrow,
# ”Error density and size in Ada software”
# IEEE Software, pp. 26-30, Jan. 1990.
# Source lines,Modules,Defect Density
# 4-62 93 5.4
# 64-97 39 4.9
# 103-154 52 3.4
# 161-250 53 1.8
# 251-397 46 5.2
# 402-625 31 5.6
# 651-949 22 6.8
# 1050-5 160 26 8.3
#
 
