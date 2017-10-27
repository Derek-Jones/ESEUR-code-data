#
# SANER-2017.R, 11 Jun 17
# Data from:
# An Empirical Comparison of Dependency Issues in {OSS} Packaging Ecosystems
# Alexandre Decan and Tom Mens and Ma{\"a}lick Claes
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")
# library("semver")


# Sum dependencies, relies on presence of NA causing any result to be NA
sum_deps=function(df)
{
t=nrow(df)+sum(cran_pack$num_dep[match(df$dep_sat, cran_pack$release)])
}


# Find the earliest release of every package
get_first_release=function(df)
{
# which(...)[1] is needed to handle two releases on the same day
return(df$release[which(min(df$date) == df$date)[1]])
}


# Some packages have a single dependency, with is also dependent
# on them, i.e., a circular dependency.
break_circ=function(df)
{
if (nrow(df) != 1)
   return(NULL)

dep_rel=subset(cran_dep, dep_sat == df$release)
num_circ=match(df$dep_sat, dep_rel$release)
return(data.frame(pack_num=match(df$release, cran_pack$release),
			value=num_circ))
}


# Find the next greatest version that exists
make_exist_dep=function(df)
{
base_pack=subset(cran_dep, dep_sat == df)
versions=unique(subset(cran_pack, package == base_pack$dependency[1])$version)

# The following gives: Error in parse_ptr(version) : stoi
# sem_ver=sort(parse_version(versions))
# sem_dep=parse_version(gsub(base_pack$dependency[1], "", df))
# t=(sem_dep < sem_ver)

cur_ver=gsub(base_pack$dependency[1], "", df)

# Not a perfect solution...
t=sort(c(versions, cur_ver))
t_rank=which(t == cur_ver)
# Use the following if possible, otherwise use the previous
t_rank=t_rank+1-2*(t_rank == length(t))

exist_ver=paste0(base_pack$dependency[1], t[t_rank])
cran_dep$dep_sat[cran_dep$dep_sat == df] <<- exist_ver
}



# package,version,dependency,constraint
cran_dep=read.csv(paste0(ESEUR_dir, "ecosystems/SANER-2017/cran_dep.csv.xz"), as.is=TRUE)
# cran_dep$version=gsub("-", ".", cran_dep$version)
# cran_dep$constraint=gsub("-", ".", cran_dep$constraint)

cran_dep$release=paste0(cran_dep$package, cran_dep$version)

# package,version,time,size
cran_pack=read.csv(paste0(ESEUR_dir, "ecosystems/SANER-2017/cran_pack.csv.xz"), as.is=TRUE)
cran_pack$date=as.Date(cran_pack$time, format="%Y-%m-%d")
# cran_pack$version=gsub("-", ".", cran_pack$version)

cran_pack$release=paste0(cran_pack$package, cran_pack$version)

# t=table(substr(cran_dep$constraint, 1, 2))
# t

# Pick the version number out of the constraint
# Ignore the small number of cases where the relationship is < or >
cran_dep$dep_sat=paste0(cran_dep$dependency, 
			gsub("<=|<|=|>|>=", "", cran_dep$constraint))

# Replace * cases by the earliest release known of the dependency
earliest_rel=ddply(cran_pack, .(package), get_first_release)

use_early=grep("\\*$", cran_dep$dep_sat)
cran_dep$dep_sat[use_early]=earliest_rel$V1[match(cran_dep$dependency[use_early], earliest_rel$package)]

# Some packages have a single dependency, which is also dependent
# on them, i.e., a circular dependency.
circ_patch=ddply(cran_dep, .(release), break_circ)
circ_patch=subset(circ_patch, !is.na(value))

all_dep_sat=unique(cran_dep$dep_sat)
all_release=unique(cran_pack$release)
missing_dep=setdiff(all_dep_sat, all_release)
a_ply(missing_dep, 1, make_exist_dep)

cran_pack$num_dep=0
cran_pack$num_dep[cran_pack$release %in% cran_dep$release]=NA
cran_pack$num_dep[circ_patch$pack_num]=0

# table(cran_pack$num_dep, useNA="always")

for (i in 1:6)
   {
   t=ddply(cran_dep, .(release), sum_deps)
   dep_pack=match(t$release, cran_pack$release)
   cran_pack$num_dep[dep_pack]=t$V1
   cran_pack$num_dep[circ_patch$pack_num]=0 # Circularity may reset to NA
   }

# 39339  23464  12284  5657  1839  378  28  2
# cran_pack[head(which(is.na(cran_pack$num_dep))), ]

