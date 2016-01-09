#
# Braha_Bar-yam_07.R,  2 Jul 14
#
# Data from:
# The statistical mechanics of complex product development: Empirical and analytical results
# Dan Braha and Yaneer Bar-Yam
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


library("igraph")

# May get loaded when document is run through asciidoc
unloadNamespace("sna")

vehicles=read.graph(paste0(ESEUR_dir, "ecosystem/Braha/Braha_VehicleNetworkinPajek.net"), format="pajek")
software=read.graph(paste0(ESEUR_dir, "ecosystem/Braha/Braha_SoftwareNetworkinPajek.net"), format="pajek")
pharmaceutical=read.graph(paste0(ESEUR_dir, "ecosystem/Braha/Braha_PharmaceuticaNetwork.txt"), format="pajek")
hospital=read.graph(paste0(ESEUR_dir, "ecosystem/Braha/Braha_SixteenStoryHospital.txt"), format="pajek")


pal_col=rainbow_hcl(3)


graph_prop=function(net_graph)
{
t1=vcount(net_graph)
t2=ecount(net_graph)
t3=average.path.length(net_graph)
t4=transitivity(net_graph)
# t5=mean(degree(net_graph, mode="in"))
t6=mean(degree(net_graph, mode="out"))
t7=graph.density(net_graph)

return(cbind(Nodes=t1, Edges=t2, "Average path length"=t3,
		"Clustering coeff"=t4, Degree=t6, Density=t7))
}

tab=graph_prop(hospital)
tab=rbind(tab, graph_prop(pharmaceutical))
tab=rbind(tab, graph_prop(software))
tab=rbind(tab, graph_prop(vehicles))

rownames(tab)=c("Hospital", "Pharmaceutical", "Software", "Vehicles")


library("ascii")
print(ascii(tab, include.rownames=TRUE, include.colnames=TRUE))

