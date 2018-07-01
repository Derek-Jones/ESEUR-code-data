#
# vis-key_order-pref.R,  7 Jun 18
#
# Data from:
# The Order of Things: {How} Developers Sort Fields and Methods
# Benjamin Biegel and Fabian Beck and Willi Hornig and Stephan Diehl
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")
library("prefmod") # Needed for pattR.fit and patt.worth


par(bty="n")

# fully_qualified_name;file;line_number;entity_category;method_subcategory;visibility;lexico_index;lexico_field_index;lexico_method_index;semantic_cluster_index

base_dir=paste0(ESEUR_dir, "sourcecode/member-order/")
# csv_files=list.files(base_dir, pattern="*.csv.xz")
csv_files=c("Checkstyle.csv.xz", "JabRef.csv.xz", "JUnit.csv.xz", "TvBrowser.csv.xz",
            "Cobertura.csv.xz", "JEdit.csv.xz", "LWJGL.csv.xz", "Wicket.csv.xz",
            "CruiseControl.csv.xz", "JFreeChart.csv.xz", "PMD.csv.xz", "JFtp.csv.xz",
            "Stripes.csv.xz", "iText.csv.xz", "JHotDraw.csv.xz", "SweetHome3D.csv.xz")

pref_ent_order=c("class_variable", "instance_variable", "constructor", "method")

# Check if the JCC attribute controls the primary order
# Look for patterns in 'secondary' ordering attributes
method_subcat_str=c("getter/setter", "initializer", "other", "static")
visibility_key=c("default", "private", "protected", "public")


in_pref_order=function(pref_order, actual_order)
{
# Do the items in actual_order appear in the order given in pref_order?
# actual_order has one row per class (i.e., filename).

# Get index into pref_order that items in actual_order appear
m=match(actual_order, pref_order)

# Check that the index is in increasing order
return (length(which(diff(m) < 0)) == 0)
}


read_data=function(csv_file)
{
m_ord=read.csv(paste0(base_dir, "/", csv_file), sep=";", as.is=TRUE)

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


in_JCC_order=function(m_ord)
{
# Return TRUE/FALSE for classes containing definitions whose order primarily
# follows Java coding conventions.

ent_cat=ent_cat_rle(m_ord)

return (laply(ent_cat, function(X) in_pref_order(pref_ent_order, X$values)))
}


summarise_primary_order=function(csv_file)
{
m_ord=read_data(csv_file)
t=in_JCC_order(m_ord)

return(data.frame(csv_file, num_classes=length(t),
                     frac_not_ordered=length(which(t == FALSE))/length(t)))
}


# # Check if the JCC attribute controls the primary order
# t=adply(csv_files, 1, function(X) summarise_primary_order(X))


# # How many classes are there?
# sum(aaply(csv_files, 1, function(X) length(unique(read_data(X)$file))))


get_init_seq=function(vis_info)
{
# vis_info has class rle
# Nothing to do when only one visibility keyword present
if (length(unique(vis_info$values)) == 1)
   return(NA)

# Life is simple, if there is no chopping and changing
if (length(unique(vis_info$values)) == length(vis_info$values))
   return(paste(vis_info$values, collapse="."))

# Try and get the general picture, by removing short sequences.
# What is a short sequence?  More than 10% is not short (or
# at least seems to work well enough).
total_len=sum(vis_info$lengths)
vis_df=data.frame(unclass(vis_info))
no_small=subset(vis_df, lengths/total_len > 0.10)
if (length(unique(no_small$values)) == length(no_small$values))
   return(paste(no_small$values, collapse="."))

return(NA)
}


m_subcat_order=function(csv_file, ent_cat)
{
# Return the method_subcategory ordering as a single string, for
# a given entity category 'ent_cat'.
m_ord=read_data(csv_file)

# Exclude classes that are not ordered by JCC attribute
JCC_primary_order=in_JCC_order(m_ord)

ent_cat_ord=subset(m_ord, (entity_category == ent_cat) &
                          		JCC_primary_order[file])

# Some entries are blank, remove them.
ent_cat_ord=subset(ent_cat_ord, method_subcategory != "")

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
JCC_primary_order=in_JCC_order(m_ord)

ent_cat_ord=subset(m_ord, (entity_category == ent_cat) &
                          		JCC_primary_order[file])

# Reduce multiple occurrences by using run length encoding
vis_rle=dlply(ent_cat_ord, .(file),
                   function(X) rle(as.vector(X$visibility)))

vis_init_seq=laply(vis_rle, function(X) get_init_seq(X))

return(vis_init_seq)
}


ent_vis_order=function(ent_order_str, vis_func)
{
# Get the visibility ordering for every file and every class within
# these files.
t=alply(csv_files, 1, function(X) vis_func(X, ent_order_str))

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


get_vis_plot=function(ent_str, vis_func)
{
# Build visibility preference information and fit it ready for plotting
t=ent_vis_order(ent_str, vis_func)
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
seq_count = 0
multiseq_count = 0
vis_less_90 = 0
attribute_list=visibility_key
vis_plot_1=get_vis_plot(pref_ent_order[1], visible_order)
vis_plot_2=get_vis_plot(pref_ent_order[2], visible_order)
vis_plot_3=get_vis_plot(pref_ent_order[3], visible_order)
vis_plot_4=get_vis_plot(pref_ent_order[4], visible_order)

# print(c(seq_count, multiseq_count, vis_less_90))

all_plots=cbind(vis_plot_1, vis_plot_2, vis_plot_3, vis_plot_4)
class(all_plots)=class(vis_plot_1)


plot(all_plots, main="",
	xaxt="n", yaxt="n",
	ylab="Worth estimate\n")

