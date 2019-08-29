#
# jss-d-14.R, 28 Aug 19
# Data from:
# Can We Ask You To Collaborate?  {Analyzing} App Developer Relationships in Commercial Platform Ecosystems",
# Joey {van Angeren} and Carina Alves and Slinger Jansen",
# Data kindly provided by van Angeren (and then converted from DL format)
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Office365_apps company_links

source("ESEUR_config.r")


library("igraph")


plot_layout(1, 1, default_width=ESEUR_default_width+2,
                        default_height=ESEUR_default_height+3)

# Non-ascii characters have been stripped.
# igraph uses GTK, which was objecting...
# Pango-WARNING **: Invalid UTF-8 string passed to pango_layout_set_text()
jss=read.csv(paste0(ESEUR_dir, "ecosystems/jss-d-14.csv.xz"), as.is=TRUE)
vendors=read.csv(paste0(ESEUR_dir, "ecosystems/jss-d-14_vendors.csv.xz"), as.is=TRUE)

no_MS=subset(jss, (Source != "Microsoft") & (Target != "Microsoft"))

# length(unique(c(no_MS$Source, no_MS$Target)))

office=graph.data.frame(no_MS, directed=FALSE)

# Remove Microsoft, plus other entries where names don't match.
# Could do some cleaning to improve name matching.
v_no_MS=subset(vendors, vendor %in% no_MS$Target)

V(office)$frame.color=NA
V(office)$color="red"
V(office)$size=3
V(office)$label=NA # label=NA does not work as expected in plot

t=as.data.frame(table(no_MS$Target))
# V(office)[t$Var1]$size=(3+t$Freq)^0.8 # suck it and see
# Node size based on number of Apps, not links
V(office)[v_no_MS$vendor]$size=(2+v_no_MS$app_count)^0.8 # suck it and see

E(office)$arrow.size=0.1
E(office)$width=0.5
E(office)$color="grey"
# E(office)[t$Var1]$weight=(0+t$Freq)^(-0.8) # more s-i-a-s
# E(office)$weight=1

plot(office)

