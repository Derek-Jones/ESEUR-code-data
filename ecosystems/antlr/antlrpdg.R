#
# antlrpdg.R, 28 Aug 19
#
# Data from:
# Hussain Abdullah A. Al-Mutawa
# On the Classification of Cyclic Dependencies in Java Programs
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Java dependency cycles


source("ESEUR_config.r")

library("igraph")
library("plyr")
library("jsonlite")


# Increasing default_width does not seem to have any/much effect
plot_layout(5, 1, default_width=ESEUR_default_width+4)
par(oma=OMA_default+c(-1.5, 0, -0.5, 0))
par(mar=MAR_default+c(-1.5, 0, -0.2, 0))


# Remove last name on path (which is assumed to be method name)
remove_last=function(name_str)
{
sub("\\.[a-zA-Z0-9$_]+$", "", name_str)
}

get_src_tgt=function(df)
{
t=c(remove_last(df$src), remove_last(df$tar))
# remove self references
if (t[1] == t[2])
   return(NULL)
return(t)
}

plot_PDG=function(file_str)
{
ant=fromJSON(paste0(dir_str, file_str))

from_to=adply(ant$edges, 1, get_src_tgt)
f_t=data.frame(from=from_to$V1, to=from_to$V2)

ant_g=graph.data.frame(unique(f_t), directed=TRUE)
V(ant_g)$label=NA
E(ant_g)$arrow.size=0.3

plot(ant_g, main=sub("\\.json.xz", "", file_str),
	vertex.frame.color="white")
}


dir_str=paste0(ESEUR_dir, "ecosystems/antlr/")
top_files=list.files(dir_str)
top_files=top_files[grep(".*\\.json.xz$", top_files)]

dummy=sapply(top_files, plot_PDG)

