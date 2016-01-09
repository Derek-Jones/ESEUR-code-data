// <NOTE> This is for question 103
// <NOTE> From scan file:  08/scan0043.jpg and scan0044.jpg
//API Agriculture

#include "typedefs.h"
#include <time.h>

typedef char * string;

// So as not to prelude future new types of agriculture a single list of agriculture types is defined.

// <REMOVE> The following struct definitions:  they were not defined.
struct individual { int stuff; };

// <NOTE> Wherever this enum is used, the participant
// <NOTE> forgot the "enum" before its name.  I've added it.

enum Agritype { None = 0, cattle, sheep, pigs, Barley, corn, wheat};

struct Location {                   // most of these are for general purpose
/* * */    Address address;               // generic assumed elsewhere
/* * */    Grid_ref map_location;
/* * */    Gps_ref gps_location;
}; // <REMOVE>

struct field_details {  // represents a field
/* * */    enum Agritype type;
/* 2 */    double growth_cost;    // field specific cost //* Agricultural product growth costs (e.g., Feed-stuff and Fertilizer)
/* 1 */    struct tm * start_date;  //* Date agricultural product started life
/* 4 */    struct tm * end_date;  //* Date agricultural product killed
/* 3 */    string genetic_id;  //* Genetic ID
/* 11 */    int field_size_acres; //allows calc of tot arrange  //* Acres dedicated to creation of agricultural product
/* 5 */    struct tm * inspection_date;        // allows calc of tot arrange //* Date of last official agricultural product food safety inspection

/* 6 */    struct chemical * chemicals_used;   // generic "external" chemical record TBD  //* Chemicals / Antibiotics used
/* 9 */    _Bool is_organic;  //* Was organically produced
/* 8 */    struct location field_location;     //use generic location (pto)  //* Field locations holding agricultural product
/* * */    struct farm *   farm_record;     //parent
};

struct agri_details {    //generic agriculture details apply to all fields
/* * */    enum Agritype type;
/* 12 */    double avg_shipment_weight;  //* Agricultural product average shipment weight
/* 7 */    double market_value;  //* Agricultural product market value
/* * */    long dedicated_averages; //country wide
/* 14 */    double avg_labour_cost;    //calculatable from farm records  //* Agricultural product average labor costs
};

struct product {
/* * */    enum Agritype type;
/* * */    int number_fields;
/* * */    long average; //calc from field list
};

struct farm {
/* 13 */    struct Location location;       //generic address type  //* Farm location
/* 10 */    struct individual farm_owner;   //generic individual record (TBD)  //* Farm owner
/* * */    struct product * products ;   // product list
/* * */    struct field_details * field_details;     //field list
};   

// <NOTE> struct location moved to make the code compile.

// assumption:
// some general structures exist
// used ptrs to represent lists some speed

/* Ommitted
15) Number of each kind of agricultural product on farm
*/

