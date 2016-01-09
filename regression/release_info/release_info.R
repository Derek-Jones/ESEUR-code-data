#
# release_info.R, 26 Nov 14
#
# Data from:
# Growth and Change Dynamics in Open Source Software Systems
# Rajesh Vasa
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow_hcl(3)


version_mod=function(proj_str)
{
rel=read.csv(paste0(ESEUR_dir, "regression/release_info/", proj_str, "-summary.txt.xz"), as.is=TRUE, strip.white=TRUE)

# Sometimes the Version.ID looks like a floating-point number
rel$Version.ID=as.character(rel$Version.ID)

glob_rel <<- rel
rel$Release.Date=as.Date(rel$Release.Date, format="%d-%B-%Y")
rel$Release.Day=as.numeric(rel$Release.Date)
rel$Release.diff=c(NA, diff(rel$Release.Day))

# rel$clean_ver=gsub("[a-zA-Z]+.*$", "", rel$Version.ID)
# rel$split_ver=strsplit(rel$clean_ver, "\\.")

rel=subset(rel, grepl("^[0-9.]+$", rel$Version.ID))
rel$split_ver=strsplit(rel$Version.ID, "\\.")

t=t(sapply(rel$split_ver, function(X) return(as.numeric(c(X[1], X[2], X[3])))))
t[is.na(t)]=0
colnames(t)=c("major", "minor_1", "minor_2")
rel=cbind(rel, t)

rel_mod=glm(Release.diff ~ major+minor_1+minor_2, data=rel)
return(rel_mod)
}

v_mod=version_mod("acegi")
#v_mod=version_mod("spring")
summary(v_mod)

# rel_mod=glm(X.Interfaces ~ X.Size.In.Bytes+Release.Day, data=rel)
# rel_mod=glm(X.Interfaces ~ X.Fields+X.Methods, data=rel)
# summary(rel_mod)
# 
# rel_mod=glm(X.Fields ~ X.Size.In.Bytes+X.Methods, data=rel)
# summary(rel_mod)


v_mod=version_mod("activemq")
v_mod=version_mod("castor")

v_mod=version_mod("checkstyle")
v_mod=version_mod("cocoon")

v_mod=version_mod("flow4j")

v_mod=version_mod("ibatis")
v_mod=version_mod("jung")
v_mod=version_mod("rssowl")

