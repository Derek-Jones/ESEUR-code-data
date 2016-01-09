#
# author-mod-func.R, 26 Dec 15
#
# Data from:
# Modification and developer metrics at the function level: Metrics for the study of the evolution of a software project
# Gregorio Robles and Israel Herraiz and Daniel M.  Germ{\'a}n and Daniel Izquierdo-Cort{\'a}zar
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("plyr")

brew_col=rainbow(2)
plot_layout(1, 2)

funcs=read.csv(paste0(ESEUR_dir, "evolution/functions/ev_funcmod.tsv.xz"), as.is=TRUE, sep="\t")



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


all_mods=ddply(total_mods, .(num_mods), function(df) sum(df$V1))

plot(all_mods$num_mods, all_mods$V1, log="y", col=point_col,
	xlim=c(0, 50),
	xlab="Modifications", ylab="Functions\n")

a1_mod=glm(log(V1) ~ num_mods, data=all_mods[2:20, ], family=gaussian)
lines(1:20, exp(predict(a1_mod, newdata=data.frame(num_mods=1:20), type="link")), col=brew_col[1])
a2_mod=glm(log(V1) ~ num_mods+I(num_mods^2), data=all_mods[2:50, ], family=gaussian)
lines(1:50, exp(predict(a2_mod, newdata=data.frame(num_mods=1:50), type="link")), col=brew_col[2])

# Does not converge
# a_mod=glm(V1 ~ num_mods+I(num_mods^2), data=all_mods[2:50, ], family=gaussian(link="log"))
# lines(1:50, exp(predict(a_mod, newdata=data.frame(num_mods=1:50), type="link")), col=brew_col[2])

s=exp(a1_mod$coefficients[2])
M_t=s/(1-s)


author_mods=ddply(total_mods, .(num_authors), function(df) sum(df$V1))

plot(author_mods$num_authors, author_mods$V1, log="y", col=point_col,
	xlab="Authors", ylab="")

a1_authors=glm(log(V1) ~ num_authors, data=author_mods[2:15, ], family=gaussian)
lines(1:15, exp(predict(a1_authors, newdata=data.frame(num_authors=1:15), type="response")), col=brew_col[1])
a2_authors=glm(log(V1) ~ num_authors+I(num_authors^2), data=author_mods[2:20, ], family=gaussian)
lines(1:20, exp(predict(a2_authors, newdata=data.frame(num_authors=1:20), type="response")), col=brew_col[2])

s=exp(a2_authors$coefficients[2])
M_t=s/(1-s)

