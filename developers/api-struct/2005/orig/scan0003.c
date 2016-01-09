// <NOTE> This is for question 1
// <NOTE> From scan file:  accu05/SCAN0003.jpg

#define MEAT_PRODUCT 1
#define CEREAL_PRODUCt 2

typedef unsigned char BOOL;

struct product {
/* 2 */    BOOL organic;
/* 4 */    int genetic_id;
/* * */    int product_type;
/* * */    void * product;
/* * */    void * farm;
};

struct meat {
/* 9 */    long slaughter_date;
/* 10 */    BOOL antibiotics_med;
    // <NOTE> long
    // <NOTE> ...
};

struct farm {
/* 3 */    long median_shipment_weight;
/* 19 */    void * owner;
/* 8 */    void * farm_location;
/* * */    long * count;
};

struct cereal {
// <NOTE> actually wrote: long market_value, weedkiller_id;
/* 2 */    long market_value;
/* 5 */    long weedkiller_id;
    // <NOTE> ...
};
