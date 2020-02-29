#
# author-mod-func.R,  7 Feb 20
#
# Data from:
# Modification and developer metrics at the function level: Metrics for the study of the evolution of a software project
# Gregorio Robles and Israel Herraiz and Daniel M. Germ{\'a}n and Daniel Izquierdo-Cort{\'a}zar
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG function_modified function_developer evolution_function

source("ESEUR_config.r")

# The igraph package (which might be loaded when building the book)
# contains functions found in gnm.  The treemap package might also have
# been loaded, and its 'load' of igraph cannot be undone without first
# unloading treemap!
unloadNamespace("treemap")
unloadNamespace("igraph")

library("gnm")
library("plyr")

pal_col=rainbow(3)
plot_layout(2, 1)

# Evolution
funcs=read.csv(paste0(ESEUR_dir, "evolution/ev_funcmod.tsv.xz"), as.is=TRUE, sep="\t")
# Apache
# funcs=read.csv(paste0(ESEUR_dir, "evolution/ap_funcmod.tsv.xz"), as.is=TRUE, sep="\t")


# Investigate how many times files might be moved
merge_move=function(df)
{
deleted=subset(df, typemod == "D")
added=subset(df, typemod == "A")

return (cbind(nrow(deleted), nrow(added)))
}
# all_moves=ddply(funcs, .(func_name), merge_move)
# table(all_moves[, 2:3])
# Number of functions with the same name that are
# deleted (row) and added (column)
#       2
# 1        0    1    2    3    4    5    6    7
#   0      0 9152  286  111   31   12    1    2
#   1    107 9659 1075   74   17    9    5    1
#   2      3  474 1714  140   20   18    9    3
#   3      0    9   88  322   67   15    9    1
#   4      0    0   10   10   80   18    8    2
#   5      0    0    0   26    6   33    7    1
#
# 1 delete + 2 add could be a move: 1075 of them...


# Count number of changes and authors for a given function
count_mods=function(df)
{
# Only count additions and modifications
df=subset(df, typemod != "D")
num_mods=nrow(df)
num_authors=length(unique(df$author))

return(cbind(num_mods, num_authors))
}


# Two files may have the same name
mod_count=ddply(funcs, .(filename, func_name), count_mods)
total_mods=ddply(mod_count, .(num_mods, num_authors), nrow)
total_mods=total_mods[-1, ] # The zero total count is dirty data


all_mods=ddply(total_mods, .(num_mods), function(df) sum(df$V1))

plot(all_mods$num_mods, all_mods$V1, log="y", col=point_col,
	xaxs="i",
	xlim=c(0, 50),
	xlab="Modifications", ylab="Functions\n")

# a_mod=glm(V1 ~ num_mods+I(num_mods^2)+I(num_mods^3), data=all_mods[-1, ], family=poisson)
# a_mod=glm(V1 ~ num_mods, data=all_mods[-1, ], family=poisson)
# lines(1:50, exp(predict(a_mod, newdata=data.frame(num_mods=1:50), type="link")), col=pal_col[3])

a2_mod=gnm(V1 ~ instances(Mult(1, Exp(num_mods)), 2)-1,
                data=all_mods, verbose=FALSE,
                # start=c(2000.0, -0.6, 300.0, -0.1),  # Apache start
                start=c(20000.0, -0.6, 300.0, -0.1), # Evolution start
                family=poisson(link="identity"))
exp_coef=as.numeric(coef(a2_mod))

lines(all_mods$num_mods, exp_coef[1]*exp(exp_coef[2]*all_mods$num_mods), col=pal_col[2])
lines(all_mods$num_mods, exp_coef[3]*exp(exp_coef[4]*all_mods$num_mods), col=pal_col[3])
t=predict(a2_mod)
lines(all_mods$num_mods, t, col=pal_col[1])

# Find mean half-life of bi-exponential
t1=-1/a2_mod$coef[2]
t2=-1/a2_mod$coef[4]
t_mean=(a2_mod$coef[1]*t1^2+a2_mod$coef[3]*t2^2)/	
	(a2_mod$coef[1]*t1+a2_mod$coef[3]*t2)

# Ratio based on mean half-life
s=exp(-1/t_mean)
D_I_mean=(1-s)^2/s

# The post initial implementation exponential
s2=exp(a2_mod$coef[4])
D_I_post_i=(1-s2)^2/s2

# The number of functions having zero modifications 
a=a2_mod$coef[1]

# b=a2_mod$coef[3]

# Numbers for Evolution
# Where does the long term exponential become larger than the initial one?
# > exp_coef[1]*exp(exp_coef[2]*(5:10))
# [1] 633.99082 301.76041 143.62881  68.36296  32.53870  15.48743
# > exp_coef[3]*exp(exp_coef[4]*(5:10))
# [1] 574.6146 489.8101 417.5215 355.9016 303.3759 258.6022
# > exp_coef[1]*exp(exp_coef[2]*seq(5, 6, by =0.1))
#  [1] 633.9908 588.6280 546.5109 507.4074 471.1017 437.3938 406.0977
#  [8] 377.0409 350.0632 325.0157 301.7604
# > exp_coef[3]*exp(exp_coef[4]*seq(5, 6, by =0.1))
#  [1] 574.6146 565.5119 556.5535 547.7369 539.0600 530.5206 522.1164
#  [8] 513.8454 505.7054 497.6943 489.8101

# For Apache
# >  exp_coef[1]*exp(exp_coef[2]*(13:16))
# [1] 11.019631  7.817404  5.545721  3.934173
# >  exp_coef[3]*exp(exp_coef[4]*(13:16))
# [1] 10.178103  9.619688  9.091910  8.593089
# > exp_coef[1]*exp(exp_coef[2]*seq(13, 14, by =0.1))
#  [1] 11.019631 10.647720 10.288360  9.941129  9.605617  9.281428  8.968181
#  [8]  8.665505  8.373045  8.090456  7.817404
# > exp_coef[3]*exp(exp_coef[4]*seq(13, 14, by =0.1))
#  [1] 10.178103 10.120833 10.063886 10.007258  9.950949  9.894958  9.839281
#  [8]  9.783917  9.728865  9.674123  9.619688

# Ratio of functions initially invested in, and long term functions modified
# a/(exp_coef[3]*exp(exp_coef[4]*5.2))

# a/(exp_coef[3]*exp(exp_coef[4]*13.3))

# c(s, t1, t2)


author_mods=ddply(total_mods, .(num_authors), function(df) sum(df$V1))
author_mods=author_mods[-1, ] # The zero author count is dirty data

plot(author_mods$num_authors, author_mods$V1, log="y", col=point_col,
	xlab="Authors", ylab="Functions\n")

# a1_authors=glm(V1 ~ num_authors, data=author_mods[-1, ], family=poisson)
# lines(1:15, exp(predict(a1_authors, newdata=data.frame(num_authors=1:15), type="link")), col=pal_col[1])
# a2_authors=glm(V1 ~ num_authors+I(num_authors^2), data=author_mods[-1, ], family=poisson)
# lines(1:20, exp(predict(a2_authors, newdata=data.frame(num_authors=1:20), type="link")), col=pal_col[2])

a2_mod=gnm(V1 ~ instances(Mult(1, Exp(num_authors)), 2)-1,
                data=author_mods, verbose=FALSE,
                start=c(20000.0, -0.6, 300.0, -0.1),
                family=poisson(link="identity"))
exp_coef=as.numeric(coef(a2_mod))

lines(author_mods$num_authors, exp_coef[1]*exp(exp_coef[2]*author_mods$num_authors), col=pal_col[2])
lines(author_mods$num_authors, exp_coef[3]*exp(exp_coef[4]*author_mods$num_authors), col=pal_col[3])
t=predict(a2_mod)
lines(author_mods$num_authors, t, col=pal_col[1])

s1=exp(a2_mod$coef[2])
D_I_1=(1-s1)^2/s1

s2=exp(a2_mod$coef[4])
D_I_2=(1-s2)^2/s2

# c(s1, D_I_1, s2, D_I_2)

