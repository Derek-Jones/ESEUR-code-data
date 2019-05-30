#
# license-date.R, 18 Apr 19
# Data from:
# opensource.org, via The Wayback Machine web.archive.org
# One such page:
# http://web.archive.org/web/20110202224225/http://www.opensource.org/licenses/alphabetical
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG licensing OSI survival

source("ESEUR_config.r")


library("plyr")
library("survival")


map_vendor=function(to_name, from_name)
{
lic$license[lic$license == from_name] <<- to_name
}


start_end=function(df)
{
return(data.frame(start=min(df$date), end=max(df$date)))
}

# Dates are when the Wayback Machine scraped the OSI website

lic=read.csv(paste0(ESEUR_dir, "economics/license-date.csv.xz"), as.is=TRUE)

lic$license=gsub("license", "License", lic$license)
lic$license=gsub("Licenses", "License", lic$license)
lic$license=gsub("-", " ", lic$license)
lic$date=as.Date(as.character(lic$date), format="%Y%m%d")


# license column close spellings

map_vendor("3 clause BSD License",
		"3 clause BSD License (BSD 3 Clause)")
map_vendor("Academic Free License 3.0 (AFL 3.0)",
		"Academic Free License")
map_vendor("Adaptive Public License",
		"Adaptive Public License (APL 1.0)")
map_vendor("Apache License 2.0",
		"Apache License 2.0 (Apache 2.0)")
map_vendor("Apple Public Source License",
		"Apple Public Source License (APSL 2.0)")
map_vendor("Artistic License 2.0",
		"Artistic License 2.0 (Artistic 2.0)")
map_vendor("Attribution Assurance License",
		"Attribution Assurance License (AAL)")
map_vendor("New and Simplified BSD License",
		"New BSD License")
map_vendor("New and Simplified BSD License",
		"BSD License (New and Simplified)")
map_vendor("New and Simplified BSD License",
		"BSD License")
map_vendor("Boost Software License (BSL 1.0)",
		"Boost Software License (BSL1.0)")
map_vendor("CNRI Python License",
		"CNRI Python License (CNRI Python)")
map_vendor("Common Development and Distribution License",
		"Common Development and Distribution License 1.0 (CDDL 1.0)")
map_vendor("Common Public Attribution License 1.0 (CPAL 1.0)",
		"Common Public Attribution License 1.0 (CPAL)")
map_vendor("Computer Associates Trusted Open Source License 1.1",
		"Computer Associates Trusted Open Source License 1.1 (CATOSL 1.1)")
map_vendor("CUA Office Public License Version 1.0",
		"CUA Office Public License Version 1.0 (CUA OPL 1.0)")
map_vendor("Eclipse Public License 1.0 (EPL 1.0)",
		"Eclipse Public License")
map_vendor("Educational Community License Version 2.0",
		"Educational Community License")
map_vendor("Educational Community License Version 2.0",
		"Educational Community License Version 2.0 (ECL 2.0)")
map_vendor("Eiffel Forum License V2.0",
		"Eiffel Forum License V2.0 (EFL 2.0)")
map_vendor("Entessa Public License",
		"Entessa Public License (Entessa)")
map_vendor("EU DataGrid Software License",
		"EU DataGrid Software License (EUDatagrid)")
map_vendor("Fair License (Fair)",
		"Fair License")
map_vendor("Fair License (Fair)",
		"Fair License (FAIR)")
map_vendor("Frameworx License",
		"Frameworx License (Frameworx 1.0)")
map_vendor("Free Public License 1.0.0",
		"Free Public License 1.0.0 (0BSD)")
map_vendor("GNU Affero General Public License 3.0 (AGPL 3.0)",
		"GNU Affero General Public License v3")
map_vendor("GNU Affero General Public License 3.0 (AGPL 3.0)",
		"GNU Affero General Public License v3 (AGPL 3.0)")
map_vendor("GNU Affero General Public License 3.0 (AGPL 3.0)",
		"GNU Affero General Public License v3 (AGPLv3)")
map_vendor("GNU Affero General Public License 3.0 (AGPL 3.0)",
		"GNU Affero General Public License version 3 (AGPL 3.0)")
map_vendor("GNU General Public License (GPL)",
		"GNU General Public License")
map_vendor("GNU General Public License version 2 (GPL 2.0)",
		"GNU General Public License version 2.0 (GPL 2.0)")
map_vendor("GNU General Public License version 2 (GPL 2.0)",
		"GNU General Public License version 2.0 (GPLv2)")
map_vendor("GNU General Public License version 3 (GPL 3.0)",
		"GNU General Public License version 3.0 (GPL 3.0)")
map_vendor("GNU General Public License version 3 (GPL 3.0)",
		"GNU General Public License version 3.0 (GPLv3)")
map_vendor("GNU Library or Lesser General Public License (LGPL)",
		"GNU Library or `Lesser' Public License")
map_vendor("GNU Library or Lesser General Public License (LGPL)",
		"GNU Library or `Lesser' Public License (LGPL)")
map_vendor("GNU Library or Lesser General Public License version 2.1 (LGPL 2.1)",
		"GNU Library or Lesser General Public License version 2.1 (LGPLv2.1)")
map_vendor("GNU Library or Lesser General Public License version 3.0 (LGPL 3.0)",
		"GNU Library or Lesser General Public License version 3.0 (LGPLv3)")
map_vendor("GNU Lesser General Public License version 2.1 (LGPL 2.1)",
		"GNU Library or Lesser General Public License version 2.1 (LGPL 2.1)")
map_vendor("GNU Lesser General Public License version 3 (LGPL 3.0)",
		"GNU Library or Lesser General Public License version 3.0 (LGPL 3.0)")
map_vendor("GNU Library or Lesser General Public License (LGPL)",
		"GNU Library or Lesser Public License (LGPL)")

map_vendor("Historical Permission Notice and Disclaimer",
		"Historical Permission Notice and Disclaimer (HPND)")
map_vendor("IBM Public License 1.0 (IPL 1.0)",
		"IBM Public License")
map_vendor("IPA Font License",
		"IPA Font License (IPA)")
map_vendor("ISC License",
		"ISC License (ISC)")
map_vendor("LaTeX Project Public License 1.3c (LPPL 1.3c)",
		"LaTeX Project Public License (LPPL)")
map_vendor("Lucent Public License Version 1.02",
		"Lucent Public License Version 1.02 (LPL 1.02)")
map_vendor("Microsoft Public License (Ms PL)",
		"Microsoft Public License (MS PL)")
map_vendor("Microsoft Reciprocal License (Ms RL)",
		"Microsoft Reciprocal License (MS RL)")
map_vendor("MirOS Licence",
		"MirOS Licence (MirOS)")
map_vendor("MIT License",
		"MIT License (MIT)")
map_vendor("MITRE Collaborative Virtual Workspace License (CVW License)",
		"MITRE Collaborative Virtual Workspace License")
map_vendor("Motosoto License",
		"Motosoto License (Motosoto)")
map_vendor("Mozilla Public License 1.0 (MPL 1.0)",
		"Mozilla Public License 1.0 (MPL)")
map_vendor("Mozilla Public License 1.0 (MPL 1.0)",
		"Mozilla Public License v. 1.0 (MPL)")
map_vendor("Mozilla Public License 1.1 (MPL 1.1)",
		"Mozilla Public License 1.1 (MPL)")
map_vendor("Multics License",
		"Multics License (Multics)")
map_vendor("NASA Open Source Agreement 1.3",
		"NASA Open Source Agreement 1.3 (NASA 1.3)")
map_vendor("Naumen Public License",
		"Naumen Public License (Naumen)")
map_vendor("Nethack General Public License",
		"Nethack General Public License (NGPL)")
map_vendor("Nokia Open Source License",
		"Nokia Open Source License (Nokia)")
map_vendor("Non Profit Open Software License 3.0 (Non Profit OSL 3.0)",
		"Non Profit Open Software License 3.0 (NPOSL 3.0)")
map_vendor("NTP License",
		"NTP License (NTP)")
map_vendor("OCLC Research Public License 2.0",
		"OCLC Research Public License 2.0 (OCLC 2.0)")
map_vendor("Open Group Test Suite License",
		"Open Group Test Suite License (OGTSL)")
map_vendor("Open Software License 3.0 (OSL 3.0)",
		"Open Software License")
map_vendor("Open Software License 3.0 (OSL 3.0)",
		"Open Software License 3.0 (OSL 3.0)")
map_vendor("PHP License 3.0 (PHP 3.0)",
		"PHP License")
map_vendor("Q Public License (QPL 1.0)",
		"Qt Public License")
map_vendor("Q Public License (QPL 1.0)",
		"Qt Public License (QPL 1.0)")
map_vendor("Q Public License (QPL 1.0)",
		"Qt Public License (QPL)")
map_vendor("RealNetworks Public Source License V1.0",
		"RealNetworks Public Source License V1.0 (RPSL 1.0)")
map_vendor("Reciprocal Public License 1.5 (RPL 1.5)",
		"Reciprocal Public License 1.5 (RPL1.5)")
map_vendor("Ricoh Source Code Public License",
		"Ricoh Source Code Public License (RSCPL)")
map_vendor("Simple Public License 2.0",
		"Simple Public License 2.0 (SimPL 2.0)")
map_vendor("Simple Public License 2.0",
		"Simple Public License 2.0 (Simple 2.0)")
map_vendor("Sleepycat License",
		"Sleepycat License (Sleepycat)")
map_vendor("Sun Public License 1.0 (SPL 1.0)",
		"Sun Public License")
map_vendor("Sun Public License 1.0 (SPL 1.0)",
		"Sun Public License (SPL)")
map_vendor("Sybase Open Watcom Public License 1.0",
		"Sybase Open Watcom Public License 1.0 (Watcom 1.0)")
map_vendor("The PostgreSQL License",
		"The PostgreSQL License (PostgreSQL)")
map_vendor("University of Illinois/NCSA Open Source License",
		"University of Illinois/NCSA Open Source License (NCSA)")
map_vendor("Vovida Software License v. 1.0",
		"Vovida Software License v. 1.0 (VSL 1.0)")
map_vendor("W3C License",
		"W3C License (W3C)")
map_vendor("wxWindows Library License",
		"wxWindows Library License (WXwindows)")
map_vendor("X.Net License",
		"X.Net License (Xnet)")
map_vendor("zlib/libpng License",
		"zlib/libpng License (Zlib)")
map_vendor("Zope Public License 2.0 (ZPL 2.0)",
		"Zope Public License")

last_date=max(lic$date)

lic_range=ddply(lic, .(license), start_end)

lic_surv=Surv(lic_range$end-lic_range$start, event=lic_range$end != last_date)
lic_mod=survfit(lic_surv ~ 1)

plot(lic_mod, col=point_col, lwd=2, cex.lab=1.4,
	xaxs="i", yaxs="i",
	xlab="Days",
	ylab="Survival\n")


# Data obtained by scraping the web.archive.org,
# Running the web page through html2text, and then the following
# awk script.
#
# #
# # getlic.awk, 16 Apr 19
# 
# # "# Licenses by Name"
# # The following licenses have been approved by the OSI.
# # 
# #   * [Academic Free License](/web/20070704000745/http://www.opensource.org/licenses/afl-3.0.php)
# 
# BEGIN {
# 	in_list=0
# 	seen_star=0
# 	print "license,date"
# 	}
# 
# $0 ~ /^#+ Licenses by Name/ {
# 	# print "in-list"
# 	in_list=1
# 	next
# 	}
# 
# (in_list == 1) && ($1 == "*") {
# 	seen_star=1
# 	nf=split($0, lic_str, "]")
# 	if (nf < 2)
# 	   {
# 	   in_list=0
# 	   next
# 	   }
# 	split(lic_str[1], name_str, "[")
# 	web_offset=index(lic_str[2], "/web/")
# 	gsub(",", "", name_str[2])
# 	print name_str[2] ",\"" substr(lic_str[2], web_offset+5, 8) "\""
# 	next
# 	}
# 
# ($0 == "") && (seen_star == 1) {
# 	in_list=0
# 	seen_star=0
# 	next
# 	}
# 
# $0 ~ /^\[login]/ {
# 	in_list=0
# 	next
# 	}
# 
# 	{
# 	next
# 	}
# 
