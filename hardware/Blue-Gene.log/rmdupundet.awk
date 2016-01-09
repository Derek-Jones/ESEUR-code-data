#
# rmdupundet.awk, 14 Jun 11

function add_pat(pat_str)
{
num_pat++
msg_pat[num_pat]=pat_str
}

BEGIN {
        num_pat=0
# List of "Undetermined Patterns"
# from ...
add_pat("ciod: Error loading .*: invalid or missing program image, No such file or directory")
add_pat("ciod: LOGIN chdir.* failed: No such file or directory")
add_pat("ciod: failed to read message prefix on control stream [(]CioStream socket to")
add_pat("data TLB error interrupt")
add_pat("machine check status register:")
add_pat("instruction plb error")
add_pat("data read plb error")
add_pat("data write plb error")
add_pat("tlb error")
add_pat("i-cache parity error")
add_pat("d-cache search parity error")
add_pat("d-cache flush parity error")
add_pat("machine state register:")
add_pat("core configuration register:")
add_pat("disable store gathering")
add_pat("force load/store alignment")
add_pat("general purpose registers:")
add_pat("([0-9a-f]+:[0-9a-f]{8} *){4}")
add_pat("special purpose registers:")
add_pat("lr:[0-9a-f]{8} cr:[0-9a-f]{8} xer:[0-9a-f]{8} ctr:[0-9a-f]{8}")
add_pat("machine check interrupt .* L2 dcache unit data parity error")
add_pat("LOGIN chdir(.*) failed: Permission denied")
add_pat("machine check interrupt .* L3 major internal error")
add_pat("L3 global control register: ")
add_pat("close EDRAM pages as soon as possible")
add_pat("disable all access to cache directory")
add_pat("disable write lines")
add_pat("L3 ecc control register:")
add_pat("capture first directory correctable error address")
add_pat("capture first EDRAM correctable error address")
add_pat("capture first directory uncorrectable error address")
add_pat("capture first EDRAM uncorrectable error address")
add_pat("capture first EDRAM parity error address")
add_pat("capture first DDR uncorrectable error address")
add_pat("disable flagging of DDR UE.s as major internal error")
add_pat("L3 ecc status register:")
add_pat("data storage interrupt")
add_pat("exception syndrome register:")
add_pat("program interrupt: illegal instruction")
add_pat("program interrupt: privileged instruction")
add_pat("program interrupt: trap instruction")
add_pat("data store interrupt caused by dcbf")
add_pat("data store interrupt caused by icbi")
add_pat("program interrupt: unimplemented operation")
add_pat("byte ordering exception")
add_pat("program interrupt: imprecise exception")
add_pat("program interrupt: fp cr update")
add_pat("program interrupt: fp compare")
add_pat("program interrupt: fp cr field ")
add_pat("external input interrupt .*: torus sender .* retransmission error was corrected")
add_pat("Error creating node map from file .*: No child processes")
add_pat("ciod: Error loading .*: program image too big")
add_pat("Error creating node map from file .*: Cannot allocate memory")
add_pat("ciod: Error reading message prefix on CioStream socket to .* Link has been severed")
add_pat("Error creating node map from file .*: Bad file descriptor")
add_pat("ciod: Error creating node map from file .*: Resource temporarily unavailable")
add_pat("ciod: Error creating node map from file .*: Device or resource busy")
add_pat("ciod: Error creating node map from file .*: Block device required")
add_pat("ciod: Error loading .*: invalid or missing program image, Exec format error")
add_pat("ciod: Error creating node map from file .*: Permission denied")
add_pat("ciod: Error creating node map from file .*: Bad address")
add_pat("ciod: Error reading message prefix after LOAD_MESSAGE on CioStream socket to .*: Link has been severed")
add_pat("Microloader Assertion")
add_pat("ciod: Error loading .*: invalid or missing program image, Permission denied")
add_pat("rts tree/torus link training failed: wanted: .* got:")
add_pat("ciod: Error reading message prefix after .* on CioStream socket to .*: Link has been severed")
add_pat("ciod: Error reading message prefix after .* on CioStream socket to .*: Connection reset by peer")
add_pat("ciod: LOGIN chdir.* failed: Input/output error")
add_pat("rts: bad message header: cpu .* invalid")
add_pat("Error receiving packet on tree network, expecting type .* instead of type")
add_pat("ciod: Error reading message prefix on CioStream socket to .*, Connection timed out")
add_pat("ciod: Error reading message prefix on CioStream socket to .*, Connection reset by peer")
add_pat("monitor caught java.lang.IllegalStateException: while executing I2C Operation caught java.net.SocketException: Broken pipe and is stopping")
add_pat("fpr[[:digit:]]+=0x([0-9a-f]{8} *){4}")
add_pat("Kill job [[:digit:]]+ timed out.")
add_pat("rts: bad message header: expecting type .* instead of type")
add_pat("rts: bad message header: index .* greater than total")
add_pat("rts: bad message header: packet index .* greater than max")
add_pat("ciod: LOGIN open.* failed: Permission denied")
add_pat("lib_ido_error: .* socket closed")
add_pat("ciod: Error loading .*: not a CNK program image")
#add_pat("(r[0-9a-f]+=0x[0-9a-f]{8}\s*){4}")
add_pat("(r[0-9a-f]+=0x[0-9a-f]{8} *){4}")
add_pat("DCR 0x.* : 0x[0-9a-f]{8}")
add_pat("Hardware monitor caught java.net.SocketException: Broken pipe and is stopping")
add_pat("General Purpose Registers:")
add_pat("Special Purpose Registers:")
add_pat("correctable error detected in directory")
add_pat("uncorrectable error detected in directory")
add_pat("correctable error detected in EDRAM bank")
add_pat("uncorrectable error detected in EDRAM bank")
add_pat("parity error in bank")
add_pat("uncorrectable error detected in external DDR")
add_pat("parity error in read queue")
add_pat("FATAL (0x[0-9a-f]{8} *)*$")
add_pat("parity error in write buffer")
add_pat("number of correctable errors detected in L3 directories")
add_pat("number of correctable errors detected in L3 EDRAMs")
add_pat("number of lines with parity errors written to L3 EDRAMs")
add_pat("DDR machine check register:")
add_pat("memory manager uncorrectable error")
add_pat("memory manager strobe gate")
add_pat("memory manager address parity error")
add_pat("memory manager miscompare")
add_pat("memory manager address error")
add_pat("memory manager store buffer parity")
add_pat("memory manager RMW buffer parity")
add_pat("memory manager refresh")
add_pat("memory manager refresh counter timeout")
add_pat("memory manager refresh contention")
add_pat("memory manager / command manager address parity")
add_pat("regctl scancom interface")
add_pat("DDR failing info register:")
add_pat("capture valid")
add_pat("miscompare")
add_pat("uncorrectable error")
add_pat("address parity error")
add_pat("correctable error")
add_pat("qw trapped")
add_pat("DDR failing data registers:")
add_pat("DDR failing address register")
add_pat("machine check interrupt .*: L2 DCU read error")
add_pat("Target=.* Message=Pll failed to lock")
add_pat("Target=.* Message=ScomError")
add_pat("Target=.* Message=Invalid JtagId =")
add_pat("mmcs_server exited normally with exit code")
add_pat("port disconnected:")
add_pat("machine check interrupt .*: Torus/Tree/GI read error")
add_pat("VALIDATE_LOAD_IMAGE_CRC_IN_DRAM")
add_pat("ciod: Error loading .*: invalid or missing program image, No such device")
add_pat("external input interrupt .*: uncorrectable torus error")
add_pat("Machine Check Status Register:")
add_pat("Torus non-recoverable error DCRs follow")
add_pat("parity error")
add_pat("program interrupt")
add_pat("MailboxMonitor::.* lib_ido_error: .* unexpected socket error: Broken pipe")
add_pat("ciodb exited normally with exit code 0")
add_pat("MailboxMonitor::.* lib_ido_error: .*BGLERR_IDO_PKT_TIMEOUT connection lost to node/link/service card")
add_pat("mmcs_server exited abnormally due to signal: Segmentation fault")
add_pat("While inserting monitor info into DB caught java.lang.NullPointerException")
add_pat("idoproxy exited normally with exit code")
add_pat("ciodb exited normally with exit code")
add_pat("Target=.* Message=JtagId All all zeros, power good may be low")
add_pat("external input interrupt .*: tree header with no target waiting")
add_pat("floating point unavailable interrupt")
add_pat("Error sending packet on tree network, packet at address .* is not aligned")
add_pat("ddr: redundant bit steering failed, sequencer timeout")
add_pat("idoproxy communication failure: socket closed")
add_pat("Machine State Register:")
add_pat("Core Configuration Register")
add_pat("FATAL (.*=0x[0-9a-f]{8})+$")
add_pat("Floating Point Status and Control Register:")
add_pat("exception")
add_pat("FATAL invalid")
add_pat("fraction rounded")
add_pat("fraction inexact")
add_pat("Floating Point Registers:")
add_pat("monitor caught java.lang.IllegalStateException: while executing CONTROL Operation caught java.io.EOFException and is stopping")
add_pat("Exception Syndrome Register:")
add_pat("idoproxy communication failure: .* connection lost to node/link/service card")
add_pat("machine check interrupt .*: L2 dcache unit read return parity error")
add_pat("machine check interrupt .*: L2 dcache unit write data parity error")
add_pat("MidplaneSwitchController::clearPort() bll_clear_port failed:")
add_pat("ciod: Error creating node map from file .*: No such file or directory")
add_pat("ciod: Error creating node map from file my_map.txt: Argument list too long")
add_pat("instruction TLB error interrupt")
add_pat("Error receiving packet on tree network, packet index .* greater than max")
	}


function get_loc()
{
split($2, full_loc, ":")
# loc_str assigned on the when awk is invoked
if (loc_str == "any")
   return "any"
if (loc_str == "full")
   return $2
if (loc_str == "1st")
   return full_loc[1]
#return full_loc[2]
}


function new_msg()
{
print $0
# Save pattern because it may be less unique than the message matched
location[cur_loc]=cur_msg_pat
msg_time[cur_loc]=cur_time_str
}

	{
	cur_msg=$3
	for (i=4; i <= NF; i++)
	   cur_msg=cur_msg " " $i
	cur_msg_pat=""
# Is this one of the Fail messages of interest?
        for (p in msg_pat)
           if (match(cur_msg, msg_pat[p]))
              {
              cur_msg_pat=msg_pat[p]
              break
              }
	if (cur_msg_pat == "")
	   next
# Yes, get failure location and failure time
	cur_loc=get_loc()
	# Ignore fractions of second
	cur_time_str=substr($1, 1, 4) " " substr($1, 6, 2) " " substr($1, 9, 2) \
		  " " substr($1,12, 2) " " substr($1, 15, 2) " " substr($1, 18, 2)
	}

# Have we seen this message pattern at this location before?
location[cur_loc] == cur_msg_pat {
	cur_secs=mktime(cur_time_str)
	last_secs=mktime(msg_time[cur_loc])
#print $1 "  " cur_loc "  " msg_time[cur_loc]
#print "> " cur_secs-last_secs
	if (last_secs+time_int < cur_secs)
	   new_msg()
	else
	   msg_time[cur_loc]=cur_time_str
	next
	}

# Not seen before
	{
	new_msg()
	next
	}

