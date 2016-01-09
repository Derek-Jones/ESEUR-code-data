#
# generalized_lm.R, 29 Jul 12
#
# Data from:
# Understanding the Impact of Code and Process Metrics on Post-release Defects: A Case Study on the Eclipse Project
# Data source: "Predicting Defects for Eclipse" (dataset version 2.0a) by
#              Thomas Zimmermann and Rahul Premraj and Andreas Zeller
#              http://www.st.cs.uni-saarland.de/softevo/bug-data/eclipse/
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


read_data = function(filename)
{
eclipse_data=read.csv(filename, sep=";", as.is=TRUE)

return (eclipse_data)
}

model_data = function(eclipse_data, eclipse_formula)
{
eclipse_model=glm(eclipse_formula,
                   family=binomial(link="logit"),
                   data=eclipse_data)
summary(eclipse_model)
#vif(eclipse_model)

return(eclipse_model)
}

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


# Read metrics from the Eclipse dataset
ecl_2.0=read.csv(paste0(ESEUR_dir, "faults/eclipse/eclipse-metrics-files-2.0.csv.xz"), as.is=TRUE, sep=";")
# Build a model using 32 of the metrics as predictors
m2.0=model_data(ecl_2.0,
              (post > 0) ~ pre+ ACD+ NOI+ NOT+ TLOC+
                            FOUT_avg+FOUT_max+FOUT_sum+
                            MLOC_avg+MLOC_max+MLOC_sum+
                            NBD_avg+NBD_max+NBD_sum+
                            NOF_avg+NOF_max+NOF_sum+
                            NOM_avg+NOM_max+NOM_sum+
                            NSF_avg+NSF_max+NSF_sum+
                            NSM_avg+NSM_max+NSM_sum+
                            PAR_avg+PAR_max+PAR_sum+
                            VG_avg+VG_max+VG_sum)
# model_data(ecl_2.0,
#               (post > 0) ~ pre+ ACD+
#                             FOUT_max+FOUT_sum+
#                             MLOC_max+
#                             NBD_avg+NBD_max+
#                             NOM_avg+
#                             NSF_max+NSF_sum+
#                             PAR_avg+PAR_max+
#                             VG_max)

m2.0=model_data(ecl_2.0,
              (post > 0) ~ pre+ ACD+
                            MLOC_max+
                            NBD_avg+NBD_max+
                            NOM_avg+
                            NSF_max+NSF_sum+
                            PAR_avg+PAR_max+
                            VG_max)

ecl_2.1=read.csv(paste0(ESEUR_dir, "faults/eclipse/eclipse-metrics-files-2.1.csv.xz"), as.is=TRUE, sep=";")
m2.1=model_data(ecl_2.1,
              (post > 0) ~ pre+ ACD+ NOI+ NOT+ TLOC+
                            FOUT_avg+FOUT_max+FOUT_sum+
                            MLOC_avg+MLOC_max+MLOC_sum+
                            NBD_avg+NBD_max+NBD_sum+
                            NOF_avg+NOF_max+NOF_sum+
                            NOM_avg+NOM_max+NOM_sum+
                            NSF_avg+NSF_max+NSF_sum+
                            NSM_avg+NSM_max+NSM_sum+
                            PAR_avg+PAR_max+PAR_sum+
                            VG_avg+VG_max+VG_sum)
# model_data(ecl_2.1,
#               (post > 0) ~ pre+ TLOC+
#                             FOUT_avg+FOUT_sum+
#                             MLOC_avg+MLOC_sum+
#                             PAR_avg+PAR_max+
#                             VG_avg)

m2.1=model_data(ecl_2.1,
              (post > 0) ~ pre+ TLOC+
                            FOUT_avg+
                            MLOC_avg+MLOC_sum+
                            PAR_avg+PAR_max+
                            VG_avg)


ecl_3.0=read.csv(paste0(ESEUR_dir, "faults/eclipse/eclipse-metrics-files-3.0.csv.xz"), as.is=TRUE, sep=";")

m3.0=model_data(ecl_3.0,
              (post > 0) ~ pre+ ACD+ NOI+ NOT+ TLOC+
                            FOUT_avg+FOUT_max+FOUT_sum+
                            MLOC_avg+MLOC_max+MLOC_sum+
                            NBD_avg+NBD_max+NBD_sum+
                            NOF_avg+NOF_max+NOF_sum+
                            NOM_avg+NOM_max+NOM_sum+
                            NSF_avg+NSF_max+NSF_sum+
                            NSM_avg+NSM_max+NSM_sum+
                            PAR_avg+PAR_max+PAR_sum+
                            VG_avg+VG_max+VG_sum)
# model_data(ecl_3.0,
#               (post > 0) ~ pre+ TLOC+
#                             FOUT_sum+
#                             NBD_max+NBD_sum+
#                             NSM_avg+
#                             PAR_avg+PAR_max)

m3.0=model_data(ecl_3.0,
              (post > 0) ~ pre+
                            FOUT_sum+
                            NBD_max+
                            PAR_avg+PAR_max)


# Now remove predictors with high multicolinearity

library("car") # Needed for vif function


vif(m2.0)
m2.0=model_data(ecl_2.0,
              (post > 0) ~ pre+ ACD+
                            NOM_avg+
                            PAR_avg+PAR_max)
vif(m2.0)


vif(m2.1)
m2.1=model_data(ecl_2.1,
              (post > 0) ~ pre+
                            PAR_avg+PAR_max)
vif(m2.1)

vif(m3.0)


test_predictor = function(eclipse_data, eclipse_formula, test_data, test_bound)
{
# Build model using eclipse_data
eclipse_model=glm(eclipse_formula,
                   family=binomial(link="logit"),
                   data=eclipse_data)

# Test performance of model on test_data
eclipse_predict = predict(eclipse_model, test_data, type="response")
# Take 0.5 as the dividing line for YES/NO
test_outcome = table(factor(test_data$post > test_bound, levels=c(F, T)),
                     factor(eclipse_predict >= 0.5, levels=c(F, T)))
TN = test_outcome[1, 1]
FN = test_outcome[2, 1]
FP = test_outcome[1, 2]
TP = test_outcome[2, 2]
precision = if (TP + FP ==0) { 1 } else { TP / (TP + FP) }
recall = TP / (TP + FN)
accuracy = (TP + TN) / (TN + FN + FP + TP)
defects = (TP + FN) / (TN + FN + FP + TP)

print (c(precision, recall, accuracy, defects))
}


test_version = function(version_str, version_data, version_formula,
                        test_str, test_data, test_bound=0)
{
print(paste("Eclipse ", version_str, " test data ", test_str))
test_predictor(version_data, 
               version_formula,
               test_data, test_bound)
test_predictor(version_data,
               (post > test_bound) ~ pre+ ACD+ NOI+ NOT+ TLOC+
                            FOUT_avg+FOUT_max+FOUT_sum+
                            MLOC_avg+MLOC_max+MLOC_sum+
                            NBD_avg+NBD_max+NBD_sum+
                            NOF_avg+NOF_max+NOF_sum+
                            NOM_avg+NOM_max+NOM_sum+
                            NSF_avg+NSF_max+NSF_sum+
                            NSM_avg+NSM_max+NSM_sum+
                            PAR_avg+PAR_max+PAR_sum+
                            VG_avg+VG_max+VG_sum,
               test_data, test_bound)
}

test_version("2.0", ecl_2.0, 
               (post > 0) ~ pre+ ACD+
                            NOM_avg+
                            PAR_avg+PAR_max,
               "2.0", ecl_2.0)

test_version("2.1", ecl_2.1,
               (post > 0) ~ pre+ 
                            PAR_avg+PAR_max,
               "2.1", ecl_2.1)
test_version("2.0", ecl_2.0, 
               (post > 0) ~ pre+ ACD+
                            NOM_avg+
                            PAR_avg+PAR_max,
               "2.1", ecl_2.1)

test_version("3.0", ecl_3.0,
               (post > 0) ~ pre+   
                            FOUT_sum+
                            NBD_max+
                            PAR_avg+PAR_max,
               "3.0", ecl_3.0)
test_version("2.1", ecl_2.1,
               (post > 0) ~ pre+ 
                            PAR_avg+PAR_max,
               "3.0", ecl_3.0)
test_version("2.0", ecl_2.0, 
               (post > 0) ~ pre+ ACD+
                            NOM_avg+
                            PAR_avg+PAR_max,
               "3.0", ecl_3.0)

#### post > 3
test_version("3.0", ecl_3.0,
               (post > 3) ~ pre+
                            FOUT_sum+
                            NBD_max+
                            PAR_avg+PAR_max,
               "3.0", ecl_3.0, 3)
test_version("2.1", ecl_2.1,
               (post > 3) ~ pre+
                            PAR_avg+PAR_max,
               "3.0", ecl_3.0, 3)
test_version("2.0", ecl_2.0,
               (post > 3) ~ pre+ ACD+
                            NOM_avg+
                            PAR_avg+PAR_max,
               "3.0", ecl_3.0, 3)


model_data(ecl_2.0,
              (post > 3) ~ pre+ ACD+ NOI+ NOT+ TLOC+
                            FOUT_avg+FOUT_max+FOUT_sum+
                            MLOC_avg+MLOC_max+MLOC_sum+
                            NBD_avg+NBD_max+NBD_sum+
                            NOF_avg+NOF_max+NOF_sum+
                            NOM_avg+NOM_max+NOM_sum+
                            NSF_avg+NSF_max+NSF_sum+
                            NSM_avg+NSM_max+NSM_sum+
                            PAR_avg+PAR_max+PAR_sum+
                            VG_avg+VG_max+VG_sum)
model_data(ecl_2.0,
              (post > 3) ~ pre+ ACD+
                            MLOC_sum+
                            NBD_max+
                            PAR_max)
model_data(ecl_2.0,
              (post > 3) ~ pre+ ACD+
                            MLOC_sum+
                            NBD_max)

colinear_predictors(ecl_2.0,
              (post > 3) ~ pre+ ACD+
                            MLOC_sum+
                            NBD_max)

test_version("2.0", ecl_2.0,
              (post > 3) ~ pre+ ACD+
                            MLOC_sum+
                            NBD_max,
               "2.0", ecl_2.0, 3)

model_data(ecl_2.1,
              (post > 3) ~ pre+ ACD+ NOI+ NOT+ TLOC+
                            FOUT_avg+FOUT_max+FOUT_sum+
                            MLOC_avg+MLOC_max+MLOC_sum+
                            NBD_avg+NBD_max+NBD_sum+
                            NOF_avg+NOF_max+NOF_sum+
                            NOM_avg+NOM_max+NOM_sum+
                            NSF_avg+NSF_max+NSF_sum+
                            NSM_avg+NSM_max+NSM_sum+
                            PAR_avg+PAR_max+PAR_sum+
                            VG_avg+VG_max+VG_sum)
# Removing predictors a few at a time
model_data(ecl_2.1,
              (post > 3) ~ pre+ 
                            NBD_max+NBD_sum+
                            NOF_avg+
                            PAR_avg+PAR_max)
colinear_predictors(ecl_2.1,
              (post > 3) ~ pre+ 
                            NBD_max+NBD_sum+
                            NOF_avg+
                            PAR_avg+PAR_max)
colinear_predictors(ecl_2.1,
              (post > 3) ~ pre+ 
                            NBD_max+NBD_sum+
                            NOF_avg+
                            PAR_avg)
test_version("2.1", ecl_2.1,
              (post > 3) ~ pre+ 
                            NBD_max+NBD_sum+
                            NOF_avg+
                            PAR_avg,
               "2.1", ecl_2.1, 3)

# Aggressive pruning of predictors
model_data(ecl_2.1,
              (post > 3) ~ pre+ 
                            NOF_avg+
                            PAR_avg+PAR_max)

colinear_predictors(ecl_2.1,
              (post > 3) ~ pre+ 
                            NOF_avg+
                            PAR_avg+PAR_max)
colinear_predictors(ecl_2.1,
              (post > 3) ~ pre+ 
                            NOF_avg+
                            PAR_avg)

test_version("2.1", ecl_2.1,
              (post > 3) ~ pre+ 
                            NOF_avg+
                            PAR_avg,
               "2.1", ecl_2.1, 3)


model_data(ecl_3.0,
              (post > 3) ~ pre+ ACD+ NOI+ NOT+ TLOC+
                            FOUT_avg+FOUT_max+FOUT_sum+
                            MLOC_avg+MLOC_max+MLOC_sum+
                            NBD_avg+NBD_max+NBD_sum+
                            NOF_avg+NOF_max+NOF_sum+
                            NOM_avg+NOM_max+NOM_sum+
                            NSF_avg+NSF_max+NSF_sum+
                            NSM_avg+NSM_max+NSM_sum+
                            PAR_avg+PAR_max+PAR_sum+
                            VG_avg+VG_max+VG_sum)
model_data(ecl_3.0,
              (post > 3) ~ pre+ ACD+ TLOC+
                            FOUT_max+FOUT_sum+
                            NBD_max+
                            NOF_sum+
                            NOM_avg)
model_data(ecl_3.0,
              (post > 3) ~ pre+ ACD+ TLOC+
                            NBD_max+
                            NOF_sum)

colinear_predictors(ecl_3.0,
              (post > 3) ~ pre+ ACD+ TLOC+
                            NBD_max+
                            NOF_sum)

test_version("3.0", ecl_3.0,
              (post > 3) ~ pre+ ACD+ TLOC+
                            NBD_max+
                            NOF_sum,
               "3.0", ecl_3.0, 3)


