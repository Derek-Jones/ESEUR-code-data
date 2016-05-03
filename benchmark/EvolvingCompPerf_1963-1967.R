#
# EvolvingCompPerf_1963-1967.R, 30 Apr 16
# Data from:
# Kenneth E. Knight
# Evolving Computer Performance 1963-1967
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lubridate")


bench=read.csv(paste0(ESEUR_dir, "benchmark/EvolvingCompPerf_1963-1967.csv.xz"), as.is=TRUE)

# %y for dates before 68 prefixes 20, not 19
bench$Date.introduced=as.Date(paste0("1 ", sub("/", "/19", bench$Date.introduced)),
			origin="1900-01-01", format="%d %m/%Y")
bench$year=year(round_date(bench$Date.introduced, "year"))

# Only Com.Sec.Dol in the dataset, i.e., no Sci.Sec.Dol
plot(bench$Sci.Ops.Sec, bench$Com.Sec.Dol, log="xy")

# Knight treated year as a factor
sp_mod=glm(Com.Sec.Dol ~ log(Sci.Ops.Sec)+as.factor(year), data=bench, family=gaussian(link="log"))

cp_mod=glm(Com.Sec.Dol ~ log(Com.Ops.Sec)+as.factor(year), data=bench, family=gaussian(link="log"))

summary(cp_mod)

# Treating it as a continuous variable does not work very well
sp_mod=glm(Com.Sec.Dol ~ log(Sci.Ops.Sec)+Date.introduced, data=bench, family=gaussian(link="log"))

summary(sp_mod)

