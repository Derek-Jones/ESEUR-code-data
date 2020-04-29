#
# WSPP.R, 25 Apr 20
#
# Data from:
# Data extracted from Microsoft WSPP document pdfs by DJ
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Microsoft_WSPP documentation_links


source("ESEUR_config.r")


# A simpler approach that using graphviz
library("igraph")
library("sna")


plot_layout(2, 1, max_height=9, default_width=5)

par(mar=MAR_default-c(2.7, 3.5, 0.8, 0.8))

# par(fin=c(3/2.54, 3/2.54), mfcol=c(2, 1))

pal_col=rainbow(2)


plot_dot=function(dot_file)
{
interest=read.dot(paste0(ESEUR_dir, "communicating/WSPP/", dot_file))
dimnames(interest)[[1]]=gsub("\"", "", dimnames(interest)[[1]])
dimnames(interest)[[2]]=gsub("\"", "", dimnames(interest)[[2]])
dimnames(interest)[[1]]=gsub("MS-", "", dimnames(interest)[[1]])
dimnames(interest)[[2]]=gsub("MS-", "", dimnames(interest)[[2]])

interest_gr=graph.adjacency(interest, mode="directed")

# V(interest_gr)[names(in_deg)]$size=3+in_deg^0.7
V(interest_gr)$size=1
# V(interest_gr)$color=brew_col[4]
V(interest_gr)$label.color=pal_col[1]
V(interest_gr)$label.font=2 # bold font
V(interest_gr)$label.cex=1.05
E(interest_gr)$arrow.size=0.2
E(interest_gr)$color=pal_col[2]

plot(interest_gr, asp=FALSE) # is asp=TRUE, control over plot size goes haywire
}


plot_dot("all.dot")
plot_dot("interest.dot")

