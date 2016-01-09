#
# halstead-akiyama.R, 22 Dec 14
#
# Data from:
# A Software Physics Analysis of Akiyama's Debugging Data
# Yasao Funami and M. H. Halstead
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


akiyama=read.csv(paste0(ESEUR_dir, "faults/akiyama.csv.xz"), as.is=TRUE)

N2=akiyama$Program_Steps
# Halstead assumes every assembly language instruction is one operand+one operator
N=2*akiyama$Program_Steps

# Some decisions involve jumps to the same location as other decisions.
# Halstead decided that scaling by 1/3 would allow for this.
eta1=akiyama$Decisions/3 + akiyama$Calls + 64

# N = eta1 log2(eta1) + eta2 log2(eta2)
#
# x^x = y written in terms of x is x = e^W(ln(y))
# where W is the Lambert W function
#
# eta2 = exp(W(log(2^(N - eta1*log2(eta1)))))
# rewrite in case 2^(...) overflows

if (require("LambertW"))
   {
   eta2 = exp(lambert_W0(log(2)*(N - eta1*log2(eta1))))
   }
else
   {
   eta2=c(441.75204, 175.95329, 574.11478, 200.60237, 138.50007, 286.67298, 76.59819, 603.70682, 357.78677)
   }

Effort=N*log2(eta1+eta2)/(2*eta2/(eta1*N2))

# Duplicate Halstead's calculation
cor.test(akiyama$Program_Steps, akiyama$Number_of_Bugs)
cor.test(Effort, akiyama$Number_of_Bugs)

# Are the samples drawn from a population having a normal distribution?
shapiro.test(akiyama$Program_Steps)

# Correlation of non-normally distributed data

cor.test(akiyama$Program_Steps, akiyama$Number_of_Bugs,
         method="spearman", conf.level=0.95)
cor.test(Effort, akiyama$Number_of_Bugs,
         method="spearman", conf.level=0.95)

# DJ's plucked numbers
# Decisions and calls have one operator+operand, everything else has two operands
N2=1*(akiyama$Calls+akiyama$Decisions)+
   2*(akiyama$Program_Steps-(akiyama$Calls+akiyama$Decisions))
N=2*(akiyama$Calls+akiyama$Decisions)+
  3*(akiyama$Program_Steps-(akiyama$Calls+akiyama$Decisions))

# A factor of three is two large to account for duplicate locations, true two
eta1=akiyama$Decisions/2 + akiyama$Calls + 64

require("LambertW")

eta2 = exp(lambert_W0(log(2)*(N - eta1*log2(eta1))))

Effort=N*log2(eta1+eta2)/(2*eta2/(eta1*N2))

cor.test(akiyama$Program_Steps, akiyama$Number_of_Bugs,
         method="spearman", conf.level=0.95)
cor.test(Effort, akiyama$Number_of_Bugs,
         method="spearman", conf.level=0.95)
