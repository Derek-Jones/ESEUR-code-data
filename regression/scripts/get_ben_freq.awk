#
# get_ben_freq.awk, 20 Jan 14

$1 == "benchmark:" {
	bench= substr($2, 2, length($2)-2)
	next
	}

$1 == "CpuFreq:" {
	cpufreq=substr($5, 2, length($5)-3)
	next
	}

($1 == "cpus:") && (NF == 1) {
	getline
	cpuid=substr($3, 2, length($3)-2)
	next
	}

(bench != "") && (cpufreq != "") && (cpuid != "") {
	print bench "," cpufreq "," cpuid
	exit
	}

# benchmark: [bzip2]
# channels: ['["core1", "core2", "core3", "R3+12"]
# 
# ']
# cmd:
# - &id002 [bash, -c, cd /spec2006/spec2006;source shrc;bin/specinvoke -d benchspec/CPU2006/401.bzip2/run/run_base_train_amd64-m64-gcc42-nn.0001
#     -e speccmds.err -o speccmds.stdout -f speccmds.cmd -C]
# cpus:
# - &id001 [0]
# ctrl: {dom0: 172.16.17.111, domu: null, period: 1, tag: turbo_off_pstate_calpella2,
#   xen: false}
# full:
#   172.16.17.111:
#     CpuFreq: {governor: userspace, max_freq: '2133000', min_freq: '2133000'}
#     CpuSetLimit:
#       cpus: *id001 
#     PowerTool: {channels: '["core1", "core2", "core3", "R3+12"]

