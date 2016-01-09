// <NOTE> This is for question 100 
// <NOTE> From scan file:  08/scan0036.jpg
//API Agriculture

#include "typedefs.h"

#define CATTLE 1
// ...
#define WHEAT 6
#define PRODUCTS 6

struct farm {
/* * */    long farm_id;          //5
/* 5 */    char *Loction;           //19 //* Location of farm
/* 14 */    char *owner;  //* Owner of farm
/* 2 */    time_t last_inspected;     //2  //* Date of last official agricultural product food safety inspection
/* 1 */    long products [PRODUCTS];   //1  //* Number of each kind of agricultural product on farm
};

struct product {
/* * */    int prod_type;
/* * */    long farm_id; // these two form the tag

/* 3 */    char *family;   //use defines if the generic family is reasonably small and fixed in that case int family instead;  //* Genetic family

    // <NOTE> (crossed out) long int costs;
    // <NOTE>(crossed out) int weight_av;
/* 6 */    int avg_weight; //6  //* Average shipment weight of agricultural product
/* 8 */    int organic; //8  //* Was organically produced
/* 12 */    char * chemicals;   //not sure of they want a list of entries or just yes/no;  12  //* Chemicals / Antibiotics used

/* 13 */    int value;  //13  //* Agricultural product market value
/* 9 */    int acres;   //8  //* Acres dedicated to creation of agricultural product
/* 15 */    time_t born;    //15 //* Date agricultural product started life
/* 10 */    time_t endlife; //10  //* Agricultural product end life date
/* 4 */    int costs_material; //9  //* Costs (e.g., Feed-stuff and Fertilizer) for agricultural product growing
/* 11 */    int costs_labor;    //11  //* Agricultural product average labor costs

/* 7 */    char ** locations;  //7 // do they have a list of ids?  //* Field locations holding agricultural product
};
