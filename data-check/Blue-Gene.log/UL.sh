#
# mk-UL.sh, 30 May 11

grep -E "FATAL|FAILURE" event_log-bgl > all.FF

grep -E "((RAS LINKCARD FATAL .+ (port disconnected|pap failed|iap failed|bll_clear_port failed))|RAS KERNEL FATAL (rts: kernel terminated|no ethernet link|.+ connection lost to node/link/service card|Lustre mount FAILED|rts panic\! - stopping execution|Power deactivated|Power Good signal deactivated|rts internal error|Error: unable to mount filesystem))" all.FF > L.msg


grep -v -E "((RAS KERNEL FATAL (auxiliary processor|CHECK_INITIAL_GLOBAL_INTERRUPT_VALUES|core configuration register:|data address space|data address:|exception syndrome register:|floating point operation|general purpose registers:|guaranteed instruction cache block touch|guaranteed data cache block touch|icache prefetch depth|icache prefetch threshold|instruction address:|instruction address space|machine check status register:|imprecise machine check|machine check interrupt|machine check: i-fetch|machine check summary|problem state (0=sup,1=usr)|program interrupt:|special purpose registers:|store operation))|RAS APP FATAL ciod: Error loading .+: (invalid or missing program image, Exec format error|program image too big|invalid or missing program image, No such file or directory))" all.FF > t_1

grep -v -E "[[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]]$" t_1 > t_2

grep -v -E " enable|disable" t_2 > t_3

grep -v -E " with exit code" t_3 > t_4

RAS APP FATAL ciod: Error loading /g/g0/spelce1/Tuned/SPaSM-base/rundir/SPaSM.baseline: invalid or missing program image, Permission denied
RAS APP FATAL ciod: Error loading /p/gb1/light3/sppm_chkpt/sppm: not a CNK program image
RAS APP FATAL ciod: LOGIN chdir(/p/gb2/draeger/benchmark/dat32k_060205) failed: No such file or directory

NULL RAS BGLMASTER FAILURE mmcs_server exited normally with exit code 13

   857215  13237534 143681669 all.FF
  4747963  72031948 743185031 event_log-bgl
   407644   6294832  65984961 q3
    62281   1035170  10141701 t
  6075103  92599484 962993362 total

