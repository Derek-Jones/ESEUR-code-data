// <NOTE> This is for question 58
// <NOTE> From scan file:  08/scan0023.jpg
//API Agriculture

// <NOTE> This subject's answer is very difficult to read.
// <NOTE> Guesses as to what the subject meant will be noted.

typedef __DUMMY_INT_TYPE tai; /* x is a very big number used in xxx these xxxxx */

// <NOTE> the following type definitions were moved here
typedef int generic_id_type;

/* more attributes here */
struct rearing_field_attr { 
  genetic_id_type geneticid;
};

// <NOTE> The following typedef and union were moved so the code would compile.

typedef double areatype;

union type_of_field_attr {

/* * */    struct crop_field_attr __DUMMY_FIELD1;
/* * */    struct rearing_field_attr __DUMMY_FIELD2;
};

// <NOTE> This struct was moved here so the code would compile.

struct crop_field_attr {
  /* crop attribute a field*/
/* 8 */  tai date_harvested;  //* Date crop harvested
};
struct field {
/* can be calculated using location and temporarily stored here */
/* 2 */  areatype area;  //* Farm acres used to grow crops
/* * */  union type_of_field_attr attrs;
/* * */  gpslocation * location;  /* describe the perimmeter of the field */
/* * */  fieldtype fieldtype;
};

struct farm  {
/* * */  char * owner;
/* * */  struct field * fields; /*head of linked list */
};

// typedef double areatype;

typedef enum animal_type animaltype;

enum mind_type {
  cows,
  rabbits
  /* etc. we should have an extra list in the enum */
};

// <NOTE> struct field needed to be moved so the code would compile.
// <NOTE> typedef x tai; needed to be moved

typedef double weight;

typedef struct __DUMMY_TAG {
/* * */                            double longitude,
/* * */                                   latitude,
/* * */                                   gpslocation;
                           } __DUMMY_TYPEID;

// <NOTE> union type_of_field_attr { needed to be moved

typedef enum typeoffield
{
  crop,
  __UNREADABLE_enum
}
  fieldtype;

// <NOTE> struct crop_field_attr { had to be moved
// <NOTE> struct rearing_field_attr {  had to be moved
// <NOTE> typedef int generic_id_type; had to be moved

/*
Rationale
Unions are used to specify attribute that are mutually exclusive when in use a
field used for rearing animal attribute in a rearing_field_attr {} struct.
And a crop field in attribute in crop_field_attr {}; they are xxxxxxxxxx in a
union field-specific_attribute, the type of field may change in the future so
that is with the union , in the struct field_type. Wherever possible the name in
type is as extensive as practical, inversely proportional to its use.
Types appearing only once have the largest names, they can be easily identified
in the global namespace. For many xxxnavebler a typedef is selected when it is
important to clearify its not motability with after types date and keyit,
should not be used in an arithemetic expression. A farm is a collection of
fields. The xxxxx each field is expressed as a collection of gps positions
determining its area and location. For each location type in order to
use geometrical functions to calculate boarders and a new proportion on area. 
*/

// <NOTE> The following comment was found in SCAN0025.jpg.  In the word
// <NOTE> document, it was placed at the end of the above answer.
// <NOTE> However, in the order of scans, it's after question 59.

// Rationale 
// Mostly follow guideline in naming and use of collection, unions and struct,
//  and type_in as in xxx example.
//
// typedef double currency_type;
