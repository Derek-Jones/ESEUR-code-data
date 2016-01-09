
typedef struct BYUADDRESSTRACE
{
// Assumes long/int is 32 bits
//	unsigned long addr;
	unsigned int addr;
	unsigned char reqtype;
	unsigned char size;
	unsigned char attr;
	unsigned char proc;
//	unsigned long time;
	unsigned int time;
} p2AddrTr;

/* reqtype values */
#define FETCH			0x00	// instruction fetch
#define MEMREAD			0x01	// memory read
#define MEMREADINV		0x02	// memory read and invalidate
#define MEMWRITE		0x03	// memory write	

#define IOREAD			0x10	// IO read
#define IOWRITE			0x11	// IO Write

#define DEFERREPLY		0x20	// deferred reply
#define INTA			0x21	// interrupt acknowledge
#define CNTRLAGNTRES		0x22	// central agent response
#define BRTRACEREC		0x23	// branch trace record

#define SHUTDOWN		0x31	// shutdown
#define	FLUSH			0x32	// flush
#define HALT			0x33	// halt
#define	SYNC			0x34	// sync
#define FLUSHACK		0x35	// acknowledge flush
#define STOPCLKACK		0x36	// acknowledge stop clock
#define SMIACK			0x37	// acknowledge SMI mode
						

#ifdef BIG_ENDIAN
/* if you are using this program on a big-endian machine 
(something other than an Intel PC or equivalent) you will need to
use this function on tr.addr and tr.time.  Just replace references to
tr.addr   with   swap_endian(tr.addr)   */

unsigned long swap_endian (unsigned long num)
{
  return(((num << 24) & 0xff000000) | ((num << 8) & 0x00ff0000) | 
  ((num >> 8) & 0x0000ff00) | ((num >> 24) & 0x000000ff) );
}

/* this might be useful */

int is_big_endian()
{
  unsigned long *a;
  unsigned char p[4];

  a = (unsigned long *)p;
  *a = 0x12345678;
  if(*p == 0x12)
  {
    fprintf(stderr,"Big Endian System\n");
    return(1);
  }
  else
  {
    fprintf(stderr,"Little Endian System\n");
    return(0);
  }
}

#endif
