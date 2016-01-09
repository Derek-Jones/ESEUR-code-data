#
# get_powerinf.sh, 20 Jan 14
#
# Summarise the contents of:
# calpella2_TB-off_CS-on_SPEC/turbo_off

echo "processor,meanpower,benchmark,frequency,cpuid"

for f in */*/expt_*
   do
   t="$f"
   echo -n "${t%%/*},"
   zcat $f/*.gz | awk -f mean_power.awk
   awk -f get_ben_freq.awk < "$f/config"
   done

