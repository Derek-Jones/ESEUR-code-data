// <NOTE> This is for question 36
// 08/scan0003.c
//API Resources

#include "typedefs.h"

struct mining_location__MK_UNIQUE {
/* * */  mining_location* locate;
/* * */  struct mining_location *next;
};

// <NOTE> (cross out) struct

struct mining_location {
/* * */  char * name;
/* * */  map_reference place;
};
 
enum material {
  marble,
  slate, 
  granit,
  gold, 
  silver, 
  titanium
};
