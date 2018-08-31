#
# github-lang-pairs.R, 27 Aug 18
#
# Data from:
# Popularity, interoperability, and impact of programming languages in 100,000 open source projects
# Tegawend\'{e} F. Bissyand\'{e} and Ferdian Thung and David Lo and Lingxiao Jiang and Laurent R\'{e}veill\`{e}re
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG programming-language popularity github language-pairs


source("ESEUR_config.r")


library("igraph")
library("plyr")


git_lang=read.csv(paste0(ESEUR_dir, "sourcecode/github-lang-use.csv.xz"), as.is=TRUE)

git_lang=subset(git_lang, language != "")

lang_cnt=table(git_lang$language)
git_lang$language=as.factor(git_lang$language)


count_pairs=function(df)
{
# Enumerate all possible pairs
if (nrow(df) == 1)
   return(0)
pairs=combn(as.integer(df$language), 2)

# Add entry for both pairs because we cannot assume a consistent
# ordering in the language column
lang_pairs[t(pairs)] <<- lang_pairs[t(pairs)]+1
lang_pairs[cbind(pairs[2, ], pairs[1, ])] <<-
				lang_pairs[cbind(pairs[2, ], pairs[1, ])]+1

}

lang_pairs=matrix(data=0, nrow=length(lang_cnt), ncol=length(lang_cnt))
rownames(lang_pairs)=names(lang_cnt)
colnames(lang_pairs)=names(lang_cnt)

d_ply(git_lang, .(program), count_pairs)

# Consistency check: sort(rowSums(lang_pairs)) ==  sort(colSums(lang_pairs))

lang_graph=graph.adjacency(lang_pairs, mode="undirected", weighted=TRUE)

log_max_weight=log(max(E(lang_graph)$weight))

#l_col=diverge_hcl(1+log_max_weight, alpha=(1:(1+log_max_weight))/(1+log_max_weight))
#l_col=sequential_hcl(1+log_max_weight, c=0, power=2.2, alpha=(1:(1+log_max_weight))/(1+log_max_weight))
l_col=heat_hcl(1+log_max_weight, c=c(80, 30), l=c(30, 90), power=c(1/5, 2), alpha=((1+log_max_weight):1)/(1+log_max_weight))

E(lang_graph)$color=l_col[1+log_max_weight-log(E(lang_graph)$weight)]
V(lang_graph)$shape="rectangle"

# layout.kamada.kawai seems to give the best results of those tried
plot(lang_graph, edge.width=0.5+(E(lang_graph)$weight)^0.15,
	layout=layout.kamada.kawai,
	vertex.size=5+nchar(V(lang_graph)$name)*3, vertex.size2=10,
	vertex.frame.color="white")

