#
# funcmod.R,  2 Dec 13
#
# Data from:
# Modification and developer metrics at the function level: Metrics for the study of the evolution of a software project
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


brew_col=rainbow_hcl(3)

funcs=read.csv(paste0(ESEUR_dir, "evolution/functions/ev_funcmod.tsv.xz"), as.is=TRUE, sep="\t")
revdate=read.csv(paste0(ESEUR_dir, "evolution/functions/ev_rev_date.csv.xz"), as.is=TRUE)

# Assign date-time for a given revid
funcs$date=revdate$date_time[funcs$revid %in% revdate$revid]


merge_move=function(df)
{
deleted=subset(df, typemod == "D")
added=subset(df, typemod == "A")

return (cbind(nrow(deleted), nrow(added)))
}
all_moves=ddply(funcs, .(func_name), merge_move)
table(all_moves[, 2:3])
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

count_mods=function(df)
{
# Only count additions and modifications
df=subset(df, typemod != "D")
num_mods=nrow(df)
num_authors=length(unique(df$author))

return(cbind(num_mods, num_authors))
}


mod_count=ddply(funcs, .(filename,func_name), count_mods)
total_mods=ddply(mod_count, .(num_mods, num_authors), nrow)


plot_mods=function(X)
{
par(new=X != 1)
t=subset(total_mods, num_authors == X)
plot(t$num_mods, t$V1, type="l", col=brew_col[X], log="y",
	xlab="Modifications", ylab="Functions",
	xlim=xbounds, ylim=ybounds)
}


xbounds=c(1, 15)
ybounds=c(1, max(total_mods$V1))

pal_col=rainbow_hcl(5)

dummy=sapply(1:5, plot_mods)

legend(x="topright",legend=c("1 author", "2 authors", "3 authors", "4 authors", "5 authors"), bty="n", fill=brew_col)


plot_layout(1, 2)

all_mods=ddply(total_mods, .(num_mods), function(df) sum(df$V1))

plot(all_mods$num_mods, all_mods$V1, log="y",
	xlim=c(0, 50),
	xlab="Modifications", ylab="Functions")

a_mod=glm(V1 ~ num_mods, data=all_mods[2:15, ], family=quasipoisson)
lines(1:15, predict(a_mod, newdata=data.frame(num_mods=1:15), type="response"), col=brew_col[2])

s=exp(a_mod$coefficients[2])
M_t=s/(1-s)


author_mods=ddply(total_mods, .(num_authors), function(df) sum(df$V1))

plot(author_mods$num_authors, author_mods$V1, log="y",
	xlab="Authors", ylab="Functions")

a_authors=glm(V1 ~ num_authors, data=author_mods[2:20, ], family=quasipoisson)
lines(1:20, predict(a_authors, newdata=data.frame(num_authors=1:20), type="response"), col=brew_col[2])

s=exp(a_authors$coefficients[2])
M_t=s/(1-s)

