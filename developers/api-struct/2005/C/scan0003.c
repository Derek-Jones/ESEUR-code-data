// <NOTE> This is for question 1
// <NOTE> From scan file:  accu05/SCAN0003.jpg
//API Agriculture

#define MEAT_PRODUCT 1
#define CEREAL_PRODUCt 2

typedef unsigned char BOOL;

struct product {
/* 2 */    BOOL organic;  //* Produced organically
/* 4 */    int genetic_id;  //* Genetic ID
/* * */    int product_type;
/* * */    void * product;
/* * */    void * farm;
};

struct meat {
/* 9 */    long slaughter_date;  //* Animal slaughter date
/* 10 */    BOOL antibiotics_med;  //* Antibiotics used
    // <NOTE> long
    // <NOTE> ...
};

struct farm {
/* 3 */    long median_shipment_weight;  //* Weight of average shipment
/* 19 */    void * owner;  //* Farm owner
/* 8 */    void * farm_location;  //* Crop average labor costs
/* * */    long * count;
};

struct cereal {
// <NOTE> actually wrote: long market_value, weedkiller_id;
/* 1 */    long market_value;  //* Market value of field of crop
/* 5 */    long weedkiller_id;  //* Weed killer used
    // <NOTE> ...
};

/* Ommitted
6)Crop harvest date
7)Location of farm
11)Number of each kind of animal on farm
12)Farm acres used to grow crops
13)Supplier of seeds
14)Animal birth date
15)Market value of kind of animal
16)Cost of feed-stuff
17)Average labor costs for raising kind of animal
18)Fertilizer costs
20)Crop sown date
21)Last vet inspection date
22)Farm acres used to rear animals
23)Pedigree ID
24)Location of field 
25)Fertilizer used
*/

