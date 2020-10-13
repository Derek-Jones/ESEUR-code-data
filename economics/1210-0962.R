#
# 1210-0962.R, 20 Jul 20
# Data from:
# Breaking Monotony with Meaning: {Motivation} in Crowdsourcing Markets
# Dana Chandlera and Adam Kapelner
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human

source("ESEUR_config.r")


# wid  worker ID
# tag_wid 1 when completed first task
# trt treatment: 0_ZeroContext 1_Meaning 2_Shredded 
# num_imgs number of images processed
# qual_rec_5, qual_rec_2  Quality was measured by the fraction of cells
# labeled at a distance of five pixels (“coarse quality”) and
# two pixels (“fine quality”) from their true centers.

ad=read.csv(paste0(ESEUR_dir, "economics/1210-0962.csv.xz"), as.is=TRUE)

# Extract cases were a task was completed
adc=subset(ad, tag_wid == 1)

# log(num_imgs) produxes a better fit (just fishing)
img_mod=glm(log(num_imgs+1e-1) ~ trt+country+sex, data=adc)
summary(img_mod)

q2_mod=glm(qual_rec_2 ~ trt+country+sex, data=adc)
summary(q2_mod)

q5_mod=glm(qual_rec_5 ~ trt+country+sex, data=adc)
summary(q5_mod)


