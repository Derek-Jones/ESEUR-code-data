#
# sw_i_faults.R, 13 Apr 20
#
# Data from:
# What Bugs Live in the Cloud? {A} Study of 3000+ Issues in Cloud Systems
# Haryadi S. Gunawi and Mingzhe Hao and Tanakorn Leesatapornwongsa and Tiratat Patana-anake and Thanh Do and Jeffry Adityatama and Kurnia J. Eliazar and Agung Laksono and Jeffrey F. Lukman and Vincentius Martin and Anang D. Satria
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG fault_location fault_effect


source("ESEUR_config.r")


library("lattice")

cassandra=read.csv(paste0(ESEUR_dir, "communicating/socc14-cbs_public/sw_i_cassandra.csv.xz"), as.is=TRUE)


t=table(cassandra$software, cassandra$implication)
t[cbind(cassandra$software,cassandra$implication)]=cassandra$count

p=levelplot(t, col.regions=rainbow(100, start=0.1),
		xlab="Software fault", ylab="Effect",
                scales=list(x=list(rot=45), cex=0.7),
		colorkey=NULL, # Numeric values remove the need for legend
		panel=function(...)
                        {
                        panel.levelplot(...)
                        panel.text(1:nrow(t), rep(1:ncol(t), each=nrow(t)), t,
								cex=0.7)
                        })

plot(p, panel.height=list(3.8, "cm"), panel.width=list(4.2, "cm"))

