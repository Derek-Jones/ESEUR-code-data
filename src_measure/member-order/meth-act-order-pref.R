#
# meth-act-order-pref.R,  4 Jan 16
#
# Data from:
#
# The Order of Things: {How} Developers Sort Fields and Methods
# Benjamin Biegel and Fabian Beck and Willi Hornig and Stephan Diehl
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

# fully_qualified_name;file;line_number;entity_category;method_subcategory;visibility;lexico_index;lexico_field_index;lexico_method_index;semantic_cluster_index

csv_files=c("Checkstyle.csv.xz", "JabRef.csv.xz", "JUnit.csv.xz", "TvBrowser.csv.xz",
            "Cobertura.csv.xz", "JEdit.csv.xz", "LWJGL.csv.xz", "Wicket.csv.xz",
            "CruiseControl.csv.xz", "JFreeChart.csv.xz", "PMD.csv.xz", "JFtp.csv.xz",
            "Stripes.csv.xz", "iText.csv.xz", "JHotDraw.csv.xz", "SweetHome3D.csv.xz")

pref_ent_order=c("class_variable", "instance_variable", "constructor", "method")
 
library(plyr)

in_pref_order=function(pref_order, actual_order)
{
# Do the items in actual_order appear in the order given in pref_order?
# actual_order has one row per class (i.e., filename).

# Get index in pref_order that items in actual order appear
m=match(actual_order, pref_order)

# We want to check the index of items is in increasing order
m_order=order(m)

# No need to have a separate test for each vector length
return (identical(m_order, order(m_order)))
}


read_data=function(csv_file)
{
m_ord=read.csv(paste0(ESEUR_dir, "src_measure/member-order/", csv_file), sep=";",
			as.is=TRUE)

return(m_ord)
}


ent_cat_rle=function(m_ord)
{
# Get the run-length for each JCC attribute in every class
# Each list element returned contains something like:
# $Axis.java
#Run Length Encoding
#  lengths: int [1:4] 16 26 1 68
#  values : chr [1:4] "class_variable" "instance_variable" "constructor" ...

# rle returns  an array of 'values' and an array of corresponding 'lengths'
ent_cat=dlply(m_ord, .(file), function(X) rle(as.vector(X$entity_category)))

return(ent_cat)
}


in_primary_order=function(m_ord)
{
# Return TRUE/FALSE for classes having declarations primarily
# ordered by JCC attribute

ent_cat=ent_cat_rle(m_ord)

return (laply(ent_cat, function(X) in_pref_order(pref_ent_order, X$values)))
}


# Check if the JCC attribute controls the primary order
# Look for patterns in 'secondary' ordering attributes

library("prefmod")
# Needed for pattR.fit and patt.worth

method_subcat_str=c("getter/setter", "initializer", "other", "static")
visibility_key=c("default", "private", "protected", "public")


get_init_seq=function(vis_info)
{
# Return the longest sequence of visibility keywords, starting at the
# front, that does not contain a keyword that has already been seen.

vis_init_seq=NULL
# Loop :-(, through each element
for (i in 1:length(vis_info$values))
   if (length(intersect(vis_init_seq, vis_info$values[i])) == 0)
      vis_init_seq=c(vis_init_seq, vis_info$values[i])
   else
      break()

#cat(vis_init_seq,
#    sum(vis_info$length[1:length(vis_init_seq)]), sum(vis_info$length),
#     "\n")

seq_count <<- seq_count+1
if (length(vis_init_seq) == 1)
   return(NA)

# Count how many declaration sequences failed the 90% cutoff
multiseq_count <<- multiseq_count+1
if (sum(vis_info$length[1:length(vis_init_seq)])/sum(vis_info$length) < 0.9)
   vis_less_90 <<- vis_less_90+1

# Exclude any initial sequence which is less than 90% of the class total
if (sum(vis_info$length[1:length(vis_init_seq)])/sum(vis_info$length) < 0.9)
   return(NA)
else
   return(paste(vis_init_seq, collapse="."))
}


m_subcat_order=function(csv_file, ent_cat)
{
# Return the method_subcategory ordering as a single string, for
# a given entity category 'ent_cat'.
m_ord=read_data(csv_file)

# Exclude classes that are not ordered by JCC attribute
JCC_primary_order=in_primary_order(m_ord)

ent_cat_ord=subset(m_ord, (m_ord$entity_category == ent_cat) &
                          		JCC_primary_order[m_ord$file])

# Some entries are blank, remove them from dataset
ent_cat_ord=subset(ent_cat_ord, method_subcategory!= "")

m_subcat_rle=dlply(ent_cat_ord, .(file),
                   function(X) rle(as.vector(X$method_subcategory)))

vis_init_seq=laply(m_subcat_rle, function(X) get_init_seq(X))

return(vis_init_seq)
}


visible_order=function(csv_file, ent_cat)
{
# Return the visibility keyword ordering as a single string, for
# a given entity category 'ent_cat'.
m_ord=read_data(csv_file)

# Exclude classes that are not ordered by JCC attribute
JCC_primary_order=in_primary_order(m_ord)

ent_cat_ord=subset(m_ord, (m_ord$entity_category == ent_cat) &
                          		JCC_primary_order[m_ord$file])

# Get the run length encoding for visibility
vis_rle=dlply(ent_cat_ord, .(file),
                   function(X) rle(as.vector(X$visibility)))

vis_init_seq=laply(vis_rle, function(X) get_init_seq(X))

return(vis_init_seq)
}


ent_vis_order=function(ent_order_str, do_visibility)
{
# Get the visibility ordering for every file and every class within
# these files.
if (do_visibility)
   t=alply(csv_files, 1, function(X) visible_order(X, ent_order_str))
else
   t=alply(csv_files, 1, function(X) m_subcat_order(X, ent_order_str))

# Sum the distinct entries and put everything in a data frame
t_table=table(unlist(t))
vis_summary=data.frame(count=as.vector(t_table),
			vis_seq=dimnames(t_table)[[1]], stringsAsFactors=FALSE)

t=ddply(vis_summary, .(vis_seq), function(X) sum(X$count))

return(t)
}


bld_vis_pref=function(vis_info)
{
# Returns preference order for one sequence of visibility keywords

# Create a row of default preference values
vis_pref=rep(NA, length(attribute_list))
names(vis_pref)=attribute_list

# Add in known preferences, i.e., keyword ordering
vis_vec=strsplit(vis_info$vis_seq, ".", fixed=TRUE)[[1]]
vis_pref[vis_vec]=1:length(vis_vec)

# duplicate the observed number of occurrences
t=matrix(rep(vis_pref, each=vis_info$V1), ncol=length(attribute_list))
colnames(t)=attribute_list

return(t)
}


bld_pattR_data=function(vis_pref_data, ent_str)
{
# Build visibility preference list for input to pattR.fit

t=dlply(vis_pref_data, 1, function(X) bld_vis_pref(X))

# concatenate the list of arrays returned
all_vis_pref=do.call(rbind, t)

return(data.frame(all_vis_pref, ent_kind=ent_str))
}


get_vis_plot=function(ent_str, do_visibility)
{
# Build visibility preference information and fit it ready for plotting
t=ent_vis_order(ent_str, do_visibility)
ent=bld_pattR_data(t, ent_str)
pt=pattR.fit(ent, length(attribute_list))
pw=patt.worth(pt)
colnames(pw)=ent_str

return(pw)
}


# We cannot use the covariance features of pattR.fitt because
# this requires that a decent number of rows not contain NAs :-(
#all_ent=rbind(ent1, ent2)
#pt=pattR.fit(all_ent, length(visibility_key),
#			 formel= ~ ent_kind, elim= ~ ent_kind)


# 90% cutoff counters
seq_count <<- 0
multiseq_count <<- 0
vis_less_90 <<- 0
attribute_list=method_subcat_str
#vis_plot_3=get_vis_plot(pref_ent_order[3], FALSE)
subcat_plot=get_vis_plot(pref_ent_order[4], FALSE)
# print(c(seq_count, multiseq_count, vis_less_90))

vplim=range(subcat_plot)

par(bty="n")
plot(subcat_plot, main="", ylim=vplim,
                   ylab="Worth estimate")


