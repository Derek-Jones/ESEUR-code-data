// <NOTE> This is an answer for question 35
// <NOTE> 08/scan0002.cpp
//API Transport

// <NOTE> The following #include was added so the code will compile

#include "typedefs.h"

enum transport_method {
  walking, 
  cycling, 
  car,
  motor_bike,
  ferry, 
  train, 
  bus, 
  airplane
};

// <NOTE> The "struct route_t" was moved here from the bottom of the file
// <NOTE> so the code would compile

struct route_t {
  plane_t point;

  // <NOTE> The subject originally wrote "struct *route_t * next"
  // <NOTE> but it appears to be a crossed out mistake.  The "*" was
  // <NOTE> removed for the code to compile.
  struct route_t * next;

  // <NOTE> This struct was not complete.
  // <NOTE> the brace and semicolon were added so the code will compile.
};

struct journey {
/* * */  time_t start_time; 
/* * */  time_t end_time;

  transport_method method;
  // <NOTE> The subject crossed out "place-tstart-point;"
  // <NOTE> The subject crossed out " end-point;"
  
  route_t * route;
};
