#
# gcc-opt-lme-64O2.R,  1 Jun 14
#
# SPEC2000 results for various versions of gcc, obtained from:
# Vladimir N. Makarow http://vmakarov.fedorapeople.org/spec/index.html
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lme4")
library("reshape2")


# Roughly 20 significant releases and 20 years elapsed since
# the first gcc version tested by Marakov.
base_release_seq=20

int2k_64=read.csv(paste0(ESEUR_dir, "benchmark/gcc-opt-int2k-64.csv.xz"), as.is=TRUE)

bc_64=subset(int2k_64, Kind == "Bench.Change")


lme_model=function(gcc_bc, av_str)
{
mO2=melt(gcc_bc, variable.name="gcc_version", id="Name")

lme_O2=subset(mO2, Name!=av_str)

# Convert factor to integer and add offset from 'base' version
lme_O2$gcc_version=as.integer(lme_O2$gcc_version)+base_release_seq

t=lmList(value ~ gcc_version | Name, data=lme_O2)
#coef(t)

#plot(intervals(t))

t_lme=lmer(value ~ gcc_version+(1 | Name), data=lme_O2)

t_lme_slope=lmer(value ~ gcc_version+(gcc_version | Name), data=lme_O2)

#print(summary(t_lme))
print(summary(t_lme_slope))
#print(c(AIC(t_lme), AIC(t_lme_slope)))

return(t_lme_slope)
}

O3_64=lme_model(bc_64[bc_64$Opt == "O3", 3:9], "SPECint2000")

