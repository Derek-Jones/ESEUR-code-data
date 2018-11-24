#
# gcc-power.R,  5 Nov 18
#
# Data from:
# Identifying Compiler Options to Minimise Energy Consumption for Embedded Platforms
# James Pallister and Simon Hollis and Jeremy Bennett
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment gcc options


source("ESEUR_config.r")


library("DoE.base")
library("FrF2")


main_effects=function(file_str)
{
print(file_str)
cubic=read.csv(paste0(dir_path, file_str), as.is=TRUE)

c_mod=lm(power ~ (.)^2, data=cubic)

MEPlot(c_mod)
# IAPlot(c_mod)
}

dir_path=paste0(ESEUR_dir, "experiment/pallister/")

# files=list.files(dir_path, pattern="*.csv.xz")
# a_ply(files, 1, main_effects)

# main_effects("2dfir.csv.xz")
# main_effects("cubic.csv.xz")
# main_effects("float_matmult.csv.xz")
# main_effects("rijndael.csv.xz")
# main_effects("blowfish.csv.xz")
# main_effects("dijkstra.csv.xz")
# main_effects("sha.csv.xz")
# main_effects("crc32.csv.xz")
# main_effects("fdct.csv.xz")
# main_effects("int_matmult.csv.xz")



cubic=read.csv(paste0(ESEUR_dir, "experiment/pallister/cubic.csv.xz"), as.is=TRUE)

c_mod=lm(power ~ (.)^2, data=cubic)

# Main effects
MEPlot(c_mod) # Fails because partial aliases exist

# Interactive effects (also fails)
IAPlot(c_mod)


# halfnormal, from DoE.base, can handle partial aliases
c_hn=halfnormal(c_mod, ME.partial=TRUE)

