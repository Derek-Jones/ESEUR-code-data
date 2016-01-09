#
# eclipse-pred.R, 30 May 15
#
# Data from:
# Understanding the Impact of Code and Process Metrics on Post-release Defects: A Case Study on the Eclipse Project
# Emad Shihab and Zhen Ming Jiang and Walid M. Ibrahim and Bram Adams and Ahmed E. Hassa
# Data source: ...
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("MASS")


read_data = function(filename)
{
eclipse_data=read.csv(paste0(ESEUR_dir, "faults/eclipse/", filename), sep=";", as.is=TRUE)
#eclipse_data$post=as.numeric(eclipse_data$post > 0) # reduce to none/some

return (eclipse_data)
}


signif_predictors = function(filename)
{
ecl_2.0=read_data("eclipse-metrics-files-2.0.csv.xz")
succ_fail_2.0=cbind(ecl_2.0$post, max(ecl_2.0$post)-ecl_2.0$post)
all_mod=glm(succ_fail_2.0 ~ pre+ ACD+ NOI+ NOT+ TLOC+
                            FOUT_avg+FOUT_max+FOUT_sum+
                            MLOC_avg+MLOC_max+MLOC_sum+
                            NBD_avg+NBD_max+NBD_sum+
                            NOF_avg+NOF_max+NOF_sum+
                            NOM_avg+NOM_max+NOM_sum+
                            NSF_avg+NSF_max+NSF_sum+
                            NSM_avg+NSM_max+NSM_sum+
                            PAR_avg+PAR_max+PAR_sum+
                            VG_avg+VG_max+VG_sum,
                   family=binomial(link="logit"),
                   data=ecl_2.0)

ecl_mod=stepAIC(all_mod)

return(ecl_mod)
}


ecl_2.0_mod=signif_predictors("eclipse-metrics-files-2.0.csv.xz")
ecl_2.1_mod=signif_predictors("eclipse-metrics-files-2.1.csv.xz")
ecl_3.0_mod=signif_predictors("eclipse-metrics-files-3.0.csv.xz")



# Now remove predictors with high multicolinearity

library("car") # Needed for vif function

colinear_predictors = function(eclipse_data, eclipse_formula)
{
eclipse_model=glm(eclipse_formula,
                   family=binomial(link="logit"),
                   data=eclipse_data)
vif(eclipse_model)
}


run_colinear_predictors = function()
{
colinear_predictors(ecl_2.0,
              succ_fail_2.0 ~ pre+ ACD+ NOI+ NOT+
                            FOUT_avg+
                            NBD_avg+NBD_max+
                            NOF_avg+NOF_max+NOF_sum+
                            NOM_avg+
                            NSF_max+NSF_sum+
                            NSM_avg+
                            PAR_avg+PAR_max+
                            VG_max)
colinear_predictors(ecl_2.0,
              succ_fail_2.0 ~ pre+ ACD+
                            FOUT_avg+
                            NOM_avg+
                            PAR_avg+
                            VG_max)

colinear_predictors(ecl_2.1,
              succ_fail_2.1 ~ pre+ ACD+
                            FOUT_avg+
                            MLOC_sum+
                            NBD_max+NBD_sum+
                            PAR_avg+PAR_max)
colinear_predictors(ecl_2.1,
              succ_fail_2.1 ~ pre+ ACD+
                            FOUT_avg+
                            NBD_max+
                            PAR_avg+PAR_max)

colinear_predictors(ecl_3.0,
              succ_fail_3.0 ~ pre+ TLOC+
                            FOUT_max+FOUT_sum+
                            MLOC_avg+MLOC_sum+
                            NBD_avg+NBD_max+
                            NOF_avg+
                            NOM_max+
                            NSM_avg+
                            PAR_avg+PAR_max+
                            VG_avg+VG_sum)
colinear_predictors(ecl_3.0,
              succ_fail_3.0 ~ pre+
                            NOF_avg+
                            PAR_avg)
}


test_predictor = function(eclipse_data, eclipse_formula, test_data)
{
eclipse_model=glm(eclipse_formula,
                   family=binomial(link="logit"),
                   data=eclipse_data)
eclipse_predict = predict(eclipse_model, test_data, type="response")
test_outcome = table(factor(test_data$post > 0, levels=c(F, T)),
                     factor(eclipse_predict >= 0.5, levels=c(F, T)))
TN = test_outcome[1, 1]
FN = test_outcome[2, 1]
FP = test_outcome[1, 2]
TP = test_outcome[2, 2]
precision = if (TP + FP ==0) { 1 } else { TP / (TP + FP) }
recall = TP / (TP + FN)
accuracy = (TP + TN) / (TN + FN + FP + TP)
defects = (TP + FN) / (TN + FN + FP + TP)

return (c(defects, precision, recall, accuracy))
}


test_predictor(ecl_3.0,
              succ_fail_3.0 ~ pre+
                            NOF_avg+
                            PAR_avg,
              ecl_3.0)

test_predictor(ecl_3.0,
              succ_fail_3.0 ~ pre+ ACD+ NOI+ NOT+ TLOC+
                            FOUT_avg+FOUT_max+FOUT_sum+
                            MLOC_avg+MLOC_max+MLOC_sum+
                            NBD_avg+NBD_max+NBD_sum+
                            NOF_avg+NOF_max+NOF_sum+
                            NOM_avg+NOM_max+NOM_sum+
                            NSF_avg+NSF_max+NSF_sum+
                            NSM_avg+NSM_max+NSM_sum+
                            PAR_avg+PAR_max+PAR_sum+
                            VG_avg+VG_max+VG_sum,
              ecl_3.0)

