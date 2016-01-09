//API Agriculture
/*
  1 ) Weed killer sprayed
  2 ) Field location
  3 ) Produced organically
  4 ) Genetic ID
  5 ) Animal slaughter date
  6 ) Fertilizer costs
  7 ) Last vet inspection date
  8 ) Pedigree ID
  9 ) Antibiotics given
  10 ) Farm acres used to rear animals
  11 ) Owner of farm
  12 ) Number of each kind of animal on farm
  13 ) Acres used to grow crops
  14 ) Average labor cost for growing crop
  15 ) Acre of crop market value
  16 ) Animal raising average labor cost
  17 ) Date crop harvested
  18 ) Market value of kind of animal
  19 ) Supplier of seeds
  20 ) Average shipment weight
  21 ) Cost of feed-stuff
  22 ) Location of farm
  23 ) Crop sown date
  24 ) Fertilizer applied
  25 ) Date animal born
*/

// <NOTE> Page 115

#include "typedefs.h"

struct fish
 {
  /* * */   char * type;    // salmon, trout, eel 
  /* 5 */   char * slaughter_date;
  /* 7 */   char * vet_inspect_date;
  /* 8 */   char * pedigree_id;
  /* 9 */   char * antibiotics;
  /* 16 */   double raise_cost;
  /* 18 */   double value;
  /* 21 */   double feed_cost;
  /* 25 */   char * bdate;
};


struct cereal 
{
  /* * */   char * type;    // barley, corn, wheat 
  /* 1 */   char * weed_killer;
  /* 3 */   bool organic;
  /* 17 */   char * date_harvest;
  /* 23 */   char * date_sow;
  /* 24 */   char * fertilizer;
  /* 4 */   char * genetic_id;
  /* 6 */   double fert_cost;
};

struct fish_farm {
 /* * */       struct fish ** fish;
 /* 10 */       int acres;
 /* 11 */       char * owner;
 /* 12 */       int s_count;
 /* 12 */       int t_count;
 /* 12 */       int e_count;
 /* 22 */       char * location;
};

struct cereal_farm
{
  /* * */   struct cereal ** cereal;
  /* 2 */   char * location;
  /* 11 */   char * owner;
  /* 13 */   int acres;
  /* 14 */   double labor_cost; 
  /* 18 */   double value;
  /* 19 */   char * seed_supply;
  /* 20 */   double ship_weight;
};
