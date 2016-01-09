#
# fuzzer-mod.R, 17 Jun 15
#
# Data from:
# Comparative Language Fuzz Testing: Programming Languages vs. Fat Fingers
# Diomidis Spinellis and Vassilios Karakoidas and Panos Louridas
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("plyr")


prog_len=function(df)
{
df$prog_len=prog_lang_len[unique(df$program), unique(df$language)]
return(df)
}


fuzz=read.csv(paste0(ESEUR_dir, "reliability/fuzzer/fuzzer.csv.xz"), as.is=TRUE)
prog_lang_len=read.csv(paste0(ESEUR_dir, "reliability/fuzzer/prog_len.csv.xz"),
			as.is=TRUE, row.names=1)

fuzz$comp_status=as.factor(fuzz$comp_status)
fuzz$run_status=as.factor(fuzz$run_status)
fuzz$out_status=as.factor(fuzz$out_status)

fuzz=ddply(fuzz, .(program, language), prog_len)

comp_fuzz=subset(fuzz, fuzz_status == "OK")

comp_mod=glm(comp_status ~ language+operation+log(prog_len)
				+language:prog_len,
				data=comp_fuzz,
				family=binomial)
comp_mod=glm(comp_status ~ language + operation + log(prog_len)
				+program:language 
    				+operation:(program+log(prog_len)),
				data=comp_fuzz,
				family=binomial)

# comp_mod=glm(comp_status ~ (program+language+operation+log(prog_len))^2
# 				-program:log(prog_len)-program,
# 				data=comp_fuzz,
# 				family=binomial)
# comp_mod=glm(comp_status ~ program+language+operation, data=comp_fuzz,
# 				family=binomial)


summary(comp_mod)


run_fuzz=subset(fuzz, comp_status == "OK")

run_mod=glm(run_status ~ language + operation + log(prog_len)
				+program:language 
    				+operation:(program+log(prog_len)),
				data=run_fuzz,
				family=binomial)
# run_mod=glm(run_status ~ (program+language+operation+log(prog_len))^2
# 				-program:log(prog_len)-program,
# 				data=run_fuzz,
# 				family=binomial)
# min_mod=stepAIC(run_mod)

summary(run_mod)

# run_mod=glm(run_status ~ language+operation+prog_len:language, data=run_fuzz,
# 				family=binomial)

exe_fuzz=subset(fuzz, run_status == "OK")

exe_mod=glm(out_status ~ language + operation + log(prog_len)
				+program:language 
    				+operation:(program+log(prog_len)),
				data=exe_fuzz,
				family=binomial)
#exe_mod=glm(out_status ~ (program+language+operation+log(prog_len))^2
#				-program:log(prog_len)-program,
#				data=exe_fuzz,
#				family=binomial)
#min_mod=stepAIC(exe_mod)

summary(exe_mod)


library("car")

Anova(exe_mod)

