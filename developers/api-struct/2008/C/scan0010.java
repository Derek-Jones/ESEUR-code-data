// <NOTE> This is for question 40
// <NOTE> From scan file:  /08SCAN0010.jpg - SCAN0011.jpg
//API Agriculture

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

typedef char * String;

// Location - string, owner
// Aib ab, chems - bool /liss (string)
// Organically - pool
// Avg cebourcos - float
// Avg shipmow - float
// Number - int
// Perfect value - float
// Number - float
// Perfect value - float
// Satarespdite - bis (unix time) <NOTE> This isn't really readable
// Field locations
// Killed date
// Gen ID
// Growth costs <NOTE> Not readable </NOTE>

struct Product ;

struct Farm {
/* * */    int id;
/* 1 */    String location;  //* Location of farm
/* 10 */    String owner;  //* Owner of farm
/* * */    struct Product *products;
};

struct Field {
/* * */    int id;
/* * */    String title;
/* * */    String notes;
/* * */    float acres;
};

// <NOTE> "bool" is not a type in Java,
// <NOTE> so all instances were replaced by _Bool

struct Product {
/* 13 */    int geneticid;  //* Genetic ID
/* * */    int type;
/* 2 */    _Bool abchems;  //* Antibiotics / Chemicals used
/* 3 */    _Bool organically;  //* Was organically produced
/* 4 */    float laborCost;  //* Average labor costs of agricultural product
/* 5 */    float shipmentweight;  //* Agricultural product average shipment weight
/* 6 */    int noOnFarm;  //* Number of each kind of agricultural product on farm
/* 7 */    float marketValue;  //* Agricultural product market value
/* 8 */    int dateSafetyInspection;  //* Date of last official agricultural product food safety inspection
/* 11 */    int dateStarted;  //* Agricultural product started life date
/* 12 */    int dateKilled;  //* Date agricultural product killed
/* 9 */    struct Field locations[4];  //* Field locations holding agricultural product
/* 14 */    float growthCosts;  //* Agricultural product growth costs (e.g., Feed-stuff and Fertilizer)
};

/* Ommitted
15) Farm acres dedicated to creation of agricultural product
*/

