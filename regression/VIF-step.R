#
# VIF-step.r, 18 Jan 14
#
# Data from:
# Predicting Defects for Eclipse" (dataset version 2.0a)
# Thomas Zimmermann and Rahul Premraj and Andreas Zeller
# http://www.st.cs.uni-saarland.de/softevo/bug-data/eclipse/
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("car")
library("MASS")

VIF_maximum=10

# Remove the column having the greatest VIF
step_VIF = function(eclipse_data)
{
eclipse_model=glm((post > 0) ~ . ,
                   family=binomial(link="logit"),
                   data=eclipse_data)
v=vif(eclipse_model)
t=which.max(v)

if (v[t] < VIF_maximum)
   return(eclipse_model)

# print(names(t))
# Remove column having given name
eclipse_data=subset(eclipse_data, select=!(colnames(eclipse_data) %in% names(t)))
return(step_VIF(eclipse_data))
}


all_VIF = function(eclipse_data)
{
eclipse_model=glm((post > 0) ~ . ,
                   family=binomial(link="logit"),
                   data=eclipse_data)
v=vif(eclipse_model)
t=which(v >= VIF_maximum)

# print(names(t))
# Remove columns having given names
subset_data=subset(eclipse_data, select=!(colnames(eclipse_data) %in% names(t)))

# Build model again
eclipse_model=glm((post > 0) ~ . ,
                   family=binomial(link="logit"),
                   data=subset_data)
return(eclipse_model)
}


# Read metrics from the Eclipse dataset
ecl_2_0=read.csv(paste0(ESEUR_dir, "faults/eclipse/eclipse-metrics-files-2.0.csv.xz"), sep=";", as.is=TRUE)

# Extract the columns we are interested in
# Pre-release defects (PRE)
# Post-release defects (POST)
# Total Lines of Code (TLOC)
# Fan out (FOUT)
# Method Lines of Code (MLOC)
# Nested Block Depth (NBD)
# Number of Parameters (PAR)
# McCabe Cyclomatic Complexity (VG)
# Number of Fields (NOF)
# Number of Methods (NOM)
# Number of Static Fields (NSF)
# Number of Static Methods (NSM)
# Anonymous Type Declarations (ACD)
# Number of Interfaces (NOI)
# Number of Classes (NOT)
model_data=subset(ecl_2_0, select=(colnames(ecl_2_0) %in% c(
					"pre",
					"post",
					"ACD",
					"FOUT_avg", "FOUT_max", "FOUT_sum",
					"MLOC_avg", "MLOC_max", "MLOC_sum",
					"NBD_avg", "NBD_max", "NBD_sum",
					"NOF_avg", "NOF_max", "NOF_sum",
					"NOI",
					"NOM_avg", "NOM_max", "NOM_sum",
					"NOT",
					"NSF_avg", "NSF_max", "NSF_sum",
					"NSM_avg", "NSM_sum",
					"PAR_avg", "PAR_max", "PAR_sum",
					"TLOC",
					"VG_avg", "VG_max", "VG_sum")))

# Build a model using 32 of the metrics as predictors
m2_stepVIF=step_VIF(model_data)
m2_allVIF=all_VIF(model_data)

eclipse_data=ecl_2_0
subset_data=ecl_2_0

# remove trace=0 to monitor progress
m2_stepAIC=stepAIC(m2_stepVIF, trace=0)
m2_allAIC=stepAIC(m2_allVIF, trace=0)

print(summary(m2_stepAIC))
print(summary(m2_allAIC))


# Remove columns with p-value < 0.05 (ignoring bonferroni)
#t_m2=update(m2_stepAIC, . ~ . -NOT -FOUT_sum -VG_sum -FOUT_avg)
#summary(t_m2)

