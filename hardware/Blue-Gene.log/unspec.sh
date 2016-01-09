ciod: Error loading .*: invalid or missing program image, No such file or directory
ciod: LOGIN chdir.* failed: No such file or directory
ciod: failed to read message prefix on control stream \(CioStream socket to .*
data TLB error interrupt
machine check status register: 
instruction plb error\.+\d+
data read plb error\.+\d+
data write plb error\.+\d+
tlb error\.+\d+
i-cache parity error\.+\d+
d-cache search parity error\.+\d+
d-cache flush parity error\.+\d+
machine state register:
core configuration register: 
disable store gathering\.+\d+
force load/store alignment\.+\d+
general purpose registers:
(([0-9a-f])+:([0-9a-f]){8} *){4}
special purpose registers:
lr:[0-9a-f]{8} cr:[0-9a-f]{8} xer:[0-9a-f]{8} ctr:[0-9a-f]{8}
machine check interrupt .* L2 dcache unit data parity error
LOGIN chdir\(.*\) failed: Permission denied
machine check interrupt .* L3 major internal error
L3 global control register: 
close EDRAM pages as soon as possible\.+\d+
disable all access to cache directory\.+\d+
disable write lines
L3 ecc control register:
capture first directory correctable error address\.+\d+
capture first EDRAM correctable error address\.+\d+
capture first directory uncorrectable error address\.+\d+
capture first EDRAM uncorrectable error address\.+\d+
capture first EDRAM parity error address\.+\d+
capture first DDR uncorrectable error address\.+\d+
disable flagging of DDR UE.s as major internal error
L3 ecc status register: 
data storage interrupt
exception syndrome register: 
program interrupt: illegal instruction\.+\d+
program interrupt: privileged instruction\.+\d+
program interrupt: trap instruction\.+\d+
data store interrupt caused by dcbf\.+\d+
data store interrupt caused by icbi\.+\d+
program interrupt: unimplemented operation\.+\d+
byte ordering exception\.+\d+
program interrupt: imprecise exception\.+\d+
program interrupt: fp cr update\.+\d+
program interrupt: fp compare\.+\d+
program interrupt: fp cr field \.+\d+
external input interrupt .*: torus sender .* retransmission error was corrected
Error creating node map from file .*: No child processes
ciod: Error loading .*: program image too big
Error creating node map from file .*: Cannot allocate memory
ciod: Error reading message prefix on CioStream socket to .* Link has been severed
Error creating node map from file .*: Bad file descriptor
ciod: Error creating node map from file .*: Resource temporarily unavailable
ciod: Error creating node map from file .*: Device or resource busy
ciod: Error creating node map from file .*: Block device required
ciod: Error loading .*: invalid or missing program image, Exec format error
ciod: Error creating node map from file .*: Permission denied
ciod: Error creating node map from file .*: Bad address
ciod: Error reading message prefix after LOAD_MESSAGE on CioStream socket to .*: Link has been severed
Microloader Assertion
ciod: Error loading .*: invalid or missing program image, Permission denied
rts tree/torus link training failed: wanted: .* got: .*
ciod: Error reading message prefix after .* on CioStream socket to .*: Link has been severed
ciod: Error reading message prefix after .* on CioStream socket to .*: Connection reset by peer
ciod: LOGIN chdir.* failed: Input/output error
rts: bad message header: cpu .* invalid
Error receiving packet on tree network, expecting type .* instead of type .*
ciod: Error reading message prefix on CioStream socket to .*, Connection timed out
ciod: Error reading message prefix on CioStream socket to .*, Connection reset by peer
monitor caught java.lang.IllegalStateException: while executing I2C Operation caught java.net.SocketException: Broken pipe and is stopping
fpr\d+=0x([0-9a-f]{8} *){4}
Kill job \d+ timed out.
rts: bad message header: expecting type .* instead of type .*
rts: bad message header: index .* greater than total .*
rts: bad message header: packet index .* greater than max .*
ciod: LOGIN open.* failed: Permission denied
lib_ido_error: .* socket closed
ciod: Error loading .*: not a CNK program image
(r[0-9a-f]+=0x[0-9a-f]{8}\s*){4}
DCR 0x.* : 0x[0-9a-f]{8}
Hardware monitor caught java.net.SocketException: Broken pipe and is stopping
General Purpose Registers:
Special Purpose Registers:
correctable error detected in directory \d+\.+\d+
uncorrectable error detected in directory \d+\.+\d+
correctable error detected in EDRAM bank \d+\.+\d+
uncorrectable error detected in EDRAM bank \d+\.+\d+
parity error in bank \d+\.+\d+
uncorrectable error detected in external DDR\.+\d+
parity error in read queue .*\d+
FATAL (0x[0-9a-f]{8} *)*\n
parity error in write buffer
number of correctable errors detected in L3 directories
number of correctable errors detected in L3 EDRAMs
number of lines with parity errors written to L3 EDRAMs
DDR machine check register:
memory manager uncorrectable error\.+\d+
memory manager strobe gate\.+\d+
memory manager address parity error\.+\d+
memory manager miscompare\.+\d+
memory manager address error\.+\d+
memory manager store buffer parity\.+\d+
memory manager RMW buffer parity
memory manager refresh\.+\d+
memory manager refresh counter timeout\.+\d+
memory manager refresh contention\.+\d+
memory manager / command manager address parity
regctl scancom interface\.+\d+
DDR failing info register:
capture valid\.+\d+
miscompare\.+\d+
uncorrectable error\.+\d+
address parity error\.+\d+
correctable error\.+\d+
qw trapped\.+\d+
DDR failing data registers: 
DDR failing address register
machine check interrupt .*: L2 DCU read error
Target=.* Message=Pll failed to lock
Target=.* Message=ScomError
Target=.* Message=Invalid JtagId = .*
mmcs_server exited normally with exit code \d+
port disconnected: .*
machine check interrupt .*: Torus/Tree/GI read error
VALIDATE_LOAD_IMAGE_CRC_IN_DRAM
ciod: Error loading .*: invalid or missing program image, No such device
external input interrupt .*: uncorrectable torus error
Machine Check Status Register:
Torus non-recoverable error DCRs follow
parity error\.+\d+
program interrupt
MailboxMonitor::.* lib_ido_error: .* unexpected socket error: Broken pipe
ciodb exited normally with exit code 0
MailboxMonitor::.* lib_ido_error: .*BGLERR_IDO_PKT_TIMEOUT connection lost to node/link/service card
mmcs_server exited abnormally due to signal: Segmentation fault
While inserting monitor info into DB caught java.lang.NullPointerException
idoproxy exited normally with exit code \d+
ciodb exited normally with exit code \d+
Target=.* Message=JtagId All all zeros, power good may be low
external input interrupt .*: tree header with no target waiting
floating point unavailable interrupt
Error sending packet on tree network, packet at address .* is not aligned
ddr: redundant bit steering failed, sequencer timeout
idoproxy communication failure: socket closed
Machine State Register:
Core Configuration Register \d+:
FATAL (.*=0x[0-9a-f]{8})+\n
Floating Point Status and Control Register:
exception\.+\d+
FATAL invalid.*\.+\d+
fraction rounded\.+\d+
fraction inexact
Floating Point Registers:
monitor caught java.lang.IllegalStateException: while executing CONTROL Operation caught java.io.EOFException and is stopping
Exception Syndrome Register:
idoproxy communication failure: .* connection lost to node/link/service card
machine check interrupt .*: L2 dcache unit read return parity error
machine check interrupt .*: L2 dcache unit write data parity error
MidplaneSwitchController::clearPort\(\) bll_clear_port failed: .*
ciod: Error creating node map from file .*: No such file or directory
ciod: Error creating node map from file my_map.txt: Argument list too long
instruction TLB error interrupt
Error receiving packet on tree network, packet index .* greater than max .*
