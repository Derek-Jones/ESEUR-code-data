#
# Coverage-Combin.R, 29 Nov 19
# Data from:
# On Use of Coverage Metrics in Assessing Effectiveness of Combinatorial Test Designs
# Jacek Czerwonka
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG coverage_branch coverage_statement tests_combinatorial

source("ESEUR_config.r")


cc=read.csv(paste0(ESEUR_dir, "reliability/Coverage-Combin.csv.xz"), as.is=TRUE)

att=subset(cc, File == "attrib-summary")
fc=subset(cc, File == "fc-summary")
fstr=subset(cc, File == "findstr-summary")
find=subset(cc, File == "find-summary")

bc_mod=glm(Branch.Cov ~ log(Combinatorial.Order)*log(Test.Case.Count)+File, data=cc)
summary(bc_mod)

sc_mod=glm(Statement.Cov ~ log(Combinatorial.Order)*log(Test.Case.Count)+File, data=cc)
summary(sc_mod)


