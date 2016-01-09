#
# eclipse-metrics.R, 21 Jun 14
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
##
# http://www.st.cs.uni-saarland.de/softevo/bug-data/eclipse/
# Predicting Defects for Eclipse
# [Revised for Dataset Version 2.0a]

source("ESEUR_config.r")


files_20=read.csv(paste0(ESEUR_dir, "faults/eclipse/eclipse-metrics-files-2.0.csv.xz"), as.is=TRUE, sep=";")
files_21=read.csv(paste0(ESEUR_dir, "faults/eclipse/eclipse-metrics-files-2.1.csv.xz"), as.is=TRUE, sep=";")
files_30=read.csv(paste0(ESEUR_dir, "faults/eclipse/eclipse-metrics-files-3.0.csv.xz"), as.is=TRUE, sep=";")

packages_20=read.csv(paste0(ESEUR_dir, "faults/eclipse/eclipse-metrics-packages-2.0.csv.xz"), as.is=TRUE, sep=";")
packages_21=read.csv(paste0(ESEUR_dir, "faults/eclipse/eclipse-metrics-packages-2.1.csv.xz"), as.is=TRUE, sep=";")
packages_30=read.csv(paste0(ESEUR_dir, "faults/eclipse/eclipse-metrics-packages-3.0.csv.xz"), as.is=TRUE, sep=";")


nrow(files_20)
nrow(files_21)
nrow(files_30)
nrow(packages_20)
nrow(packages_21)
nrow(packages_30)



par(mar=c(5, 5, 2, 1) + 0.1)
hist(packages_30$post, freq=T, breaks=100, xlim=c(0,70), axes=F, main="", xlab="Number of Post-Release Defects (per Package)", ylab="Percentage", col="darkgray")
axis(1)
axis(2, at=c(0,66.1,66.1*2,66.1*3,66.1*4,66.1*5,66.1*6), labels=c("0%","10%","20%","30%","40%","50%","60%"), las=1)


pre.p = rep (-1, 33)
post.p = rep (-1, 33)
for (i in 3:35)
   {
   pre.p[i-2] = cor.test(files_30[,i], files_30$pre, method="spearman", exact=FALSE)$p.value
   post.p[i-2] = cor.test(files_30[,i], files_30$post, method="spearman", exact=FALSE)$p.value
   }

cbind(cor(files_30[,3:35], files_30$pre, method="spearman"), cor(files_30[,3:35], files_30$post, method="spearman"), (pre.p<0.01), (post.p<0.01))

pre.p = rep (-1, 42)
post.p = rep (-1, 42)
for (i in 3:44)
   {
   pre.p[i-2] = cor.test(packages_30[,i], packages_30 $pre, method="spearman", exact=FALSE)$p.value
   post.p[i-2] = cor.test(packages_30[,i], packages_30 $post, method="spearman", exact=FALSE)$p.value
   }

cbind(cor(packages_30[,3:44], packages_30$pre, method="spearman"), cor(packages_30[,3:44], packages_30$post, method="spearman"), (pre.p<0.01), (post.p<0.01))


test_classification = function (train, test) 
{
model.glm = glm((post>0) ~ pre + ACD + FOUT_avg + FOUT_max + FOUT_sum + MLOC_avg + MLOC_max + MLOC_sum + NBD_avg + NBD_max + NBD_sum + NOF_avg + NOF_max + NOF_sum + NOI + NOM_avg + NOM_max + NOM_sum + NOT + NSF_avg + NSF_max + NSF_sum + NSM_avg + NSM_max + NSM_sum + PAR_avg + PAR_max + PAR_sum + + + TLOC + VG_avg + VG_max + VG_sum, data=train, family = "binomial")
test.prob = predict(model.glm, test, type="response")
test.pred = test.prob>=0.50

outcome = table(factor(test$post>0, levels=c(F,T)), factor(test.pred, levels=c(F,T)))
TN = outcome[1,1]
FN = outcome[2,1]
FP = outcome[1,2]
TP = outcome[2,2]
precision = if (TP + FP ==0) { 1 } else { TP / (TP + FP) }
recall = TP / (TP + FN)
accuracy = (TP + TN) / (TN + FN + FP + TP)
defects = (TP + FN) / (TN + FN + FP + TP)
return (c(defects, precision, recall, accuracy))
}

test_classification_pkg = function (train, test) 
{
model.glm = glm((post>0) ~ pre + ACD_avg + ACD_max + ACD_sum + FOUT_avg + FOUT_max + FOUT_sum + MLOC_avg + MLOC_max + MLOC_sum + NBD_avg + NBD_max + NBD_sum + NOCU + NOF_avg + NOF_max + NOF_sum + NOI_avg + NOI_max + NOI_sum + NOM_avg + NOM_max + NOM_sum + NOT_avg + NOT_max + NOT_sum + NSF_avg + NSF_max + NSF_sum + NSM_avg + NSM_max + NSM_sum + PAR_avg + PAR_max + PAR_sum + TLOC_avg + TLOC_max + TLOC_sum + VG_avg + VG_max + VG_sum, data=train, family = "binomial")
test.prob = predict(model.glm, test, type="response")
test.pred = test.prob>=0.50

outcome = table(factor(test$post>0, levels=c(F,T)), factor(test.pred, levels=c(F,T)))
TN = outcome[1,1]
FN = outcome[2,1]
FP = outcome[1,2]
TP = outcome[2,2]
precision = if (TP + FP ==0) { 1 } else { TP / (TP + FP) }
recall = TP / (TP + FN)
accuracy = (TP + TN) / (TN + FN + FP + TP)
defects = (TP + FN) / (TN + FN + FP + TP)
return (c(defects, precision, recall, accuracy))
}


test_classification(files_20, files_20)
test_classification(files_20, files_21)
test_classification(files_20, files_30)
test_classification(files_21, files_20)
test_classification(files_21, files_21)
test_classification(files_21, files_30)
test_classification(files_30, files_20)
test_classification(files_30, files_21)
test_classification(files_30, files_30)

test_classification_pkg(packages_20, packages_20)
test_classification_pkg(packages_20, packages_21)
test_classification_pkg(packages_20, packages_30)
test_classification_pkg(packages_21, packages_20)
test_classification_pkg(packages_21, packages_21)
test_classification_pkg(packages_21, packages_30)
test_classification_pkg(packages_30, packages_20)
test_classification_pkg(packages_30, packages_21)
test_classification_pkg(packages_30, packages_30)



test_ranking = function (train, test) 
{
model.lm = lm(post ~ pre + ACD + FOUT_avg + FOUT_max + FOUT_sum + MLOC_avg + MLOC_max + MLOC_sum + NBD_avg + NBD_max + NBD_sum + NOF_avg + NOF_max + NOF_sum + NOI + NOM_avg + NOM_max + NOM_sum + NOT + NSF_avg + NSF_max + NSF_sum + NSM_avg + NSM_max + NSM_sum + PAR_avg + PAR_max + PAR_sum + + + TLOC + VG_avg + VG_max + VG_sum, data=train)
test.pred = predict(model.lm, test)

r.squared = summary(model.lm)$r.squared
pearson = cor(test$post, test.pred, method="pearson")
spearman = cor(test$post, test.pred, method="spearman")
pearson.p = cor.test(test$post, test.pred, method="pearson")$p.value
spearman.p = cor.test(test$post, test.pred, method="spearman", exact=FALSE)$p.value

return (c(r.squared, pearson, spearman, pearson.p<0.01, spearman.p<0.01))
}

test_ranking_pkg = function (train, test) 
{
model.lm = lm(post ~ pre + ACD_avg + ACD_max + ACD_sum + FOUT_avg + FOUT_max + FOUT_sum + MLOC_avg + MLOC_max + MLOC_sum + NBD_avg + NBD_max + NBD_sum + NOCU + NOF_avg + NOF_max + NOF_sum + NOI_avg + NOI_max + NOI_sum + NOM_avg + NOM_max + NOM_sum + NOT_avg + NOT_max + NOT_sum + NSF_avg + NSF_max + NSF_sum + NSM_avg + NSM_max + NSM_sum + PAR_avg + PAR_max + PAR_sum + TLOC_avg + TLOC_max + TLOC_sum + VG_avg + VG_max + VG_sum, data=train)
test.pred = predict(model.lm, test)

r.squared = summary(model.lm)$r.squared
pearson = cor(test$post, test.pred, method="pearson")
spearman = cor(test$post, test.pred, method="spearman")
pearson.p = cor.test(test$post, test.pred, method="pearson")$p.value
spearman.p = cor.test(test$post, test.pred, method="spearman", exact=FALSE)$p.value

return (c(r.squared, pearson, spearman, pearson.p<0.01, spearman.p<0.01))
}


test_ranking(files_20, files_20)
test_ranking(files_20, files_21)
test_ranking(files_20, files_30)
test_ranking(files_21, files_20)
test_ranking(files_21, files_21)
test_ranking(files_21, files_30)
test_ranking(files_30, files_20)
test_ranking(files_30, files_21)
test_ranking(files_30, files_30)

test_ranking_pkg(packages_20, packages_20)
test_ranking_pkg(packages_20, packages_21)
test_ranking_pkg(packages_20, packages_30)
test_ranking_pkg(packages_21, packages_20)
test_ranking_pkg(packages_21, packages_21)
test_ranking_pkg(packages_21, packages_30)
test_ranking_pkg(packages_30, packages_20)
test_ranking_pkg(packages_30, packages_21)
test_ranking_pkg(packages_30, packages_30)

