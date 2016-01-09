/*
 * simulate LRU stack handling of an address stream.
 * use for BYU address traces from SPEC 2000 benchmarks.
 */

#include <stdio.h>
#include "byutr.h"

/*
 * basic unit for addresses is 4K pages
 */
#define	PAGE	4096
/*
 * only tabulate up to ADDR_MAX distinct addresses
 */
#define	ADDR_NUM	100000

/*
 * LRU stack data structure:
 * page field holds page currently residing at this depth
 * count field counts how many times address was found at this depth
 */
typedef struct {
	long	page;
	long	count;
} cell_t;

/*
 * prototypes
 */
FILE *open_trace(int argc, char **argv);
void init(cell_t stack[], unsigned long *mask);
long get_addr(FILE *ifp);
int lru(long page, cell_t stack[]);
void show(cell_t stack[], int tot);


/*
 * main
 */
int main(int argc, char **argv)
{
	FILE		*ifp;
	cell_t		stack[ADDR_NUM];
	unsigned long	mask;
	long		addr;
	int		full = 0, tot = 0;

	ifp = open_trace(argc, argv);

	init(stack, &mask);

	while (((addr = get_addr(ifp)) != -1) && !full)
	{
		full = lru(addr&mask, stack);
		tot++;
	}

	show(stack, tot);

	fclose(ifp);
	return( 0 );
}

/*
 * open address trace file
 */
FILE *open_trace(int argc, char **argv)
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

	return ifp;
}

/*
 * initialize data structures:
 * in stack, mark all pages as invalid, and initialize all counts to 0.
 * set mask to turn address into page by masking offset.
 */
void init(cell_t stack[], unsigned long *mask)
{
	int	i;

	for (i=0; i<ADDR_NUM; i++)
	{
		stack[i].page  = -1;
		stack[i].count =  0;
	}

	i = 1;
	while (i < PAGE)
	{
		i <<= 1;
	}

	*mask = ~(i - 1);
}

/*
 * get next address from trace
 */
long get_addr(FILE *ifp)	
{
	p2AddrTr tr;

	if (feof(ifp))
	{
		return -1;
	}

	fread(&tr, sizeof(p2AddrTr), 1, ifp);

#ifdef DEBUG
	printf("addr %x ", tr.addr);
#endif

	return tr.addr;
}

/*
 * find page in LRU stack, mark depth, and move to front.
 * if not found just place on top.
 */
int lru(long page, cell_t stack[])
{
	long	prev = page, tmp;
	int	i = 0;

#ifdef DEBUG
	printf("=> page %x ", page);
#endif

	/*
	 * walk the stack till the referenced page is found.
	 * push pages down as you go.
	 */
	while ((stack[i].page != page) && (stack[i].page != -1) && (i < ADDR_NUM))
	{
		tmp = stack[i].page;
		stack[i].page = prev;
		prev = tmp;
		i++;
	}

	if (i == ADDR_NUM)
	{
		return 1;		/* stack is full */
	}

	if (stack[i].page == page)
	{
		stack[i].count++;	/* we had a stack hit */

#ifdef DEBUG
		printf(" found at depth %d\n", i);
#endif
	}
	else {
#ifdef DEBUG
		printf(" is new!\n", i);
#endif
	}

	if ((stack[i].page == page) || (stack[i].page == -1))
	{
	  	stack[i].page = prev;	/* complete the pushdown */
	}

	return 0;
}

/*
 * dump resulting stack depth distribution
 */
void show(cell_t stack[], int tot)
{
	int	i = 0, sum = 0;
	double	miss;

	while ((stack[i].page != -1) && (i < ADDR_NUM))
	{
		sum += stack[i].count;
		miss = ((double)tot - sum) / tot;
		printf("%d	%d	%.6lf\n", i, stack[i].count, miss);
		i++;
	}
}
