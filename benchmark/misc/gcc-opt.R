#
# gcc-opt.R, 18 Mar 16
#
# SPEC2000 results for various versions of gcc, obtained from:
# Vladimir N. Makarow http://vmakarov.fedorapeople.org/spec/index.html
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lattice")
library("lme4")
library("reshape2")


# Roughly 20 significant releases and 20 years elapsed since
# the first gcc version tested by Marakov.
base.release.seq=20

fp2k=read.csv(paste0(ESEUR_dir, "benchmark/gcc-opt-fp2k.csv.xz"), as.is=TRUE)
int2k=read.csv(paste0(ESEUR_dir, "benchmark/gcc-opt-int2k.csv.xz"), as.is=TRUE)
int2k.64=read.csv(paste0(ESEUR_dir, "benchmark/gcc-opt-int2k-64.csv.xz"), as.is=TRUE)

# Extract those values we are going to use
fc=fp2k[fp2k$Kind == "Bench.Change", ]
fsc=fp2k[fp2k$Kind == "Size.Change", ]
bc=int2k[int2k$Kind == "Bench.Change", ]
sc=int2k[int2k$Kind == "Size.Change", ]
bc.64=int2k.64[int2k.64$Kind == "Bench.Change", ]
sc.64=int2k.64[int2k.64$Kind == "Size.Change", ]

# Plot one set of data
O3.64=bc.64[bc.64$Opt == "O3", ]
colnames(O3.64)=c(colnames(O3.64)[1:3],substr(colnames(O3.64[, 4:9]), 2, 10))
lp=melt(O3.64[,3:9], id="Name")

xyplot(value ~ variable | Name, data=lp[lp$Name != "SPECint2000", ],
	xlab="gcc version", ylab="Performance change",
	scales=list(x=list(cex.lab=0.2)),
	col=point_col, pch=point_pch, type="b",
	panel=function(...) {panel.abline(0, 0, col="red"); panel.xyplot(...)})


# restructure the data and build three models
#    mixed-effects with random on the intercept
#    mixed-effects with random on the slope
#    mixed-effects with random on the intercept+slope, does not converge
#    linear model based on the average
lme.model=function(gcc.bc, av.str)
{
mO2=melt(gcc.bc, id="Name")

lme.O2=mO2[mO2$Name!=av.str, ]

# variable is a factor at this point, so convert and add in sequence base
lme.O2$variable=as.integer(lme.O2$variable)+base.release.seq

t=lmList(value ~ variable | Name, data=lme.O2)
#coef(t)

# Something to look at
plot(intervals(t))

# Name/variable is an idea that did not improve AIC etc
t_lme=lmer(value ~ gcc.version+(1 | Name), data=lme.O2)

t_lme.slope=lmer(value ~ gcc.version+(gcc.version-1 | Name), data=lme.O2)

print(summary(t.lme))
print(summary(t.lme.slope))

lmO2=mO2[mO2$Name==av.str, ]

lmO2$variable=as.integer(lmO2$variable)+base.release.seq

t.lm=glm(value ~ variable, lmO2)
print(summary(t.lm))

return(t.lme)
}

# Extract C programs and call lme.models
float.lme.model=function(gcc.fc, av.str)
{
# FP2000 C programs 177.mesa, 179.art, 183.equake, 188.ammp
# The average in the csv file is based on results from all programs,
# not just the C ones (which appear to improve more than the Fortran ones).
c.only=gcc.fc[gcc.fc$Name == "177.mesa" |
              gcc.fc$Name == "179.art" |
              gcc.fc$Name == "183.equake.mesa" |
              gcc.fc$Name == "188.amp" |
              gcc.fc$Name == av.str, ]

return(lme.model(c.only, av.str))
}


# Integer models, all cominations of O2/O3 and 32/64 bit
O2=lme.model(bc[bc$Opt == "O2", 3:12], "SPECint2000")
O3=lme.model(bc[bc$Opt == "O3", 3:12], "SPECint2000")
O2.size=lme.model(sc[sc$Opt == "O2", 3:12], "Average")
O3.size=lme.model(sc[sc$Opt == "O3", 3:12], "Average")

O2.64=lme.model(bc.64[bc.64$Opt == "O2", 3:9], "SPECint2000")
O3.64=lme.model(bc.64[bc.64$Opt == "O3", 3:9], "SPECint2000")
O2.64.size=lme.model(sc.64[sc.64$Opt == "O2", 3:9], "Average")
O3.64.size=lme.model(sc.64[sc.64$Opt == "O3", 3:9], "Average")

# Floating-point models
# All programs, i.e., Fortran and C
fO2=lme.model(fc[fc$Opt == "O2", 3:9], "SPECFP2000")

# Now just consider C programs
fO2=float.lme.model(fc[fc$Opt == "O2", 3:9], "SPECFP2000")
fO3=float.lme.model(fc[fc$Opt == "O3", 3:9], "SPECFP2000")
fO2.64=float.lme.model(fc[fc$Opt == "O2.64", 3:9], "SPECFP2000")
fO3.64=float.lme.model(fc[fc$Opt == "O3.64", 3:9], "SPECFP2000")

fO2.size=lme.model(fsc[fsc$Opt == "O2", 3:9], "Average")
fO3.size=lme.model(fsc[fsc$Opt == "O3", 3:9], "Average")
fO2.size.64=lme.model(fsc[fsc$Opt == "O2.64", 3:9], "Average")
fO3.size.64=lme.model(fsc[fsc$Opt == "O3.64", 3:9], "Average")

plot(compareFits(coef(O2), coef(O3)))


# Build a O3/O2 difference model

# Compute SPEC integer percentage difference and build a model
diff.model=function(orig.data, cols, SPEC_av)
{
diff.bench=(orig.data[orig.data$Opt == "O3", cols] -
                                       orig.data[orig.data$Opt == "O2", cols]) /
                                          orig.data[orig.data$Opt == "O2", cols]
diff.bench=cbind(Name=orig.data[orig.data$Opt == "O2", 3], diff.bench)

return(lme.model(diff.bench, SPEC_av))
}


# Size is only available as a percentage difference
diff.size.model=function(orig.data, cols, SPEC_av)
{
diff.bench=(orig.data[orig.data$Opt == "O3", cols] -
                                       orig.data[orig.data$Opt == "O2", cols])
diff.bench=cbind(Name=orig.data[orig.data$Opt == "O2", 3], diff.bench)

return(lme.model(diff.bench, SPEC_av))
}

bench=int2k[int2k$Kind == "Bench", ]
bench.64=int2k.64[int2k.64$Kind == "Bench", ]

diff.O=diff.model(bench, 4:12, "SPECint2000")
diff.O.64=diff.model(bench.64, 4:9, "SPECint2000")

diff.size=diff.size.model(sc, 4:12, "Average")
diff.size.64=diff.size.model(sc.64, 4:9, "Average")

