/*
 * read BYU address traces from SPEC 2000 benchmarks and
 * create map of accesses and working set sizes.
 */

#include <stdio.h>
#include <stdlib.h>
#include "byutr.h"

// #define DEBUG 1

/*
 * basic units for map
 */
#define	PAGE	  4096
#define PAGE_NUM  1048576
#define	BLOCK	  1048576
#define BLOCK_NUM 4096
#define TAU	  100000

/*
 * prototypes
 */
FILE *open_trace(int argc, char *argv[]);
void init(unsigned long *mask, int *shift, int **pages, int sz, int num);
int  get_addr(FILE *ifp, unsigned long *addr, int *type);


/*
 * main
 */
int main(int argc, char *argv[])
{
    FILE		*ifp;
    int			*pages, *blocks;
    unsigned long	page_mask, block_mask;
    int			page_shift, block_shift;
    unsigned long	addr, page, block, unique=0;
    int			type;
    int			t=0, tot=0, i, check=0;

#ifdef DEBUG
    fprintf(stderr, "starting\n");
    fflush(stderr);
#endif

    ifp = open_trace(argc, argv);

    init(&page_mask,  &page_shift,  &pages,  PAGE,  PAGE_NUM);
    init(&block_mask, &block_shift, &blocks, BLOCK, BLOCK_NUM);

    while (get_addr(ifp, &addr, &type))
    {
	block = (addr & block_mask) >> block_shift;
	if (block >= BLOCK_NUM)
	{
	    fprintf(stderr, "block out of range! %ld\n", block);
	    exit(1);
	}

	page = (addr & page_mask) >> page_shift;
	if (page >= PAGE_NUM)
	{
	    fprintf(stderr, "page out of range! %ld\n", page);
	    exit(1);
	}

	// only data memory accesses
	if (type==MEMREAD || type==MEMREADINV || type==MEMWRITE)
	{
	    blocks[block]++;
	    pages[page]++;
	    if (pages[page] == 1)
	    {
		unique++;
	    }
	}
	else if (type > SMIACK)
	{
	    fprintf(stderr, "type out of range! %d\n", type);
	    exit(1);
	}


	// dump data every TAU references
	if (++tot >= TAU)
	{
	    // working set
	    printf("ws	%d	%ld\n", t, unique);
	    for (i=0; i<PAGE_NUM; i++)
	    {
		pages[i] = 0;
	    }
	    unique = 0;

	    // access map
	    for (i=0; i<BLOCK_NUM; i++)
	    {	
		if (blocks[i] > 0)
		{
		    printf("%d	%d	%d\n", t, i, blocks[i]);
		    check += blocks[i];
		    blocks[i] = 0;
		}
	    }
	    printf("# tot=%d, check=%d\n", tot, check);
	    tot   = 0;
	    check = 0;
	    t++;
	}
    }

    fclose(ifp);

#ifdef DEBUG
    fprintf(stderr, "finished\n");
    fflush(stderr);
#endif
    return( 0 );
}

/*
 * open address trace file
 */
FILE *open_trace(int argc, char *argv[])
{
    FILE *ifp;

    if(argc != 2)
    {
	fprintf(stderr,"usage: %s input_byutr_file\n", argv[0]);
	exit(1);
    }

    if((ifp = fopen(argv[1],"rb")) == NULL)
    {
	fprintf(stderr,"cannot open %s for reading\n",argv[1]);
	exit(1);
    }

#ifdef DEBUG
    fprintf(stderr, "opened trace\n");
    fflush(stderr);
#endif
    return ifp;
}

/*
 * initialize arrays to track data and code accesses, and access types.
 * set mask to turn addresses into pages by masking offset.
 */
void init(unsigned long *mask, int *shift, int **arr, int sz, int num)
{
    int	i, j;

    *arr = malloc(num * sizeof(int));
    if (*arr == NULL)
    {
	fprintf(stderr,"cannot allocate arr[]\n");
	exit(1);
    }
#ifdef DEBUG
    fprintf(stderr, "allocated %d cells for arr[] at %p\n", num, *arr);
    fflush(stderr);
#endif

    for (i=0; i<num; i++)
    {
	(*arr)[i] = 0;
    }

    i = j = 1;
    while (i <= sz)
    {
	i <<= 1;
	j++;
    }
    *mask  = ~(i - 1) & 0xffffffff;  // Trace is from a 32-bit system
    *shift = j-1;

#ifdef DEBUG
    fprintf(stderr, "initialized (%lx, %d)\n", *mask, *shift);
    fflush(stderr);
#endif
}

/*
 * get next address from trace
 */
int get_addr(FILE *ifp, unsigned long *addr, int *type)
{
    p2AddrTr tr;

    if (feof(ifp))
    {
	return 0;
    }

    fread(&tr, sizeof(p2AddrTr), 1, ifp);

#ifdef DEBUG
    fprintf(stderr, "  addr %lx of type %d at %ld\n", tr.addr, tr.reqtype, tr.time);
    fflush(stderr);
#endif

    *addr = tr.addr;
    *type = tr.reqtype;
    return 1;
}
