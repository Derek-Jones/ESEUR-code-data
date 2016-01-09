// <NOTE> This is for question 40
// <NOTE> From scan file:  /08SCAN0010.jpg - SCAN0011.jpg
//API Agriculture

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class scan0010 { }

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

class Farm {
/* * */    Integer id;
/* 1 */    String location;  //* Location of farm
/* 10 */    String owner;  //* Owner of farm
/* * */    Product [] products;
}

class Field {
/* * */    Integer id;
/* * */    String title;
/* * */    String notes;
/* * */    float acres;
}

// <NOTE> "bool" is not a type in Java,
// <NOTE> so all instances were replaced by boolean

class Product {
/* 13 */    Integer geneticid;  //* Genetic ID
/* * */    Integer type;
/* 2 */    boolean abchems;  //* Antibiotics / Chemicals used
/* 3 */    boolean organically;  //* Was organically produced
/* 4 */    float laborCost;  //* Average labor costs of agricultural product
/* 5 */    float shipmentweight;  //* Agricultural product average shipment weight
/* 6 */    Integer noOnFarm;  //* Number of each kind of agricultural product on farm
/* 7 */    float marketValue;  //* Agricultural product market value
/* 8 */    Integer dateSafetyInspection;  //* Date of last official agricultural product food safety inspection
/* 11 */    Integer dateStarted;  //* Agricultural product started life date
/* 12 */    Integer dateKilled;  //* Date agricultural product killed
/* 9 */    Field [] locations;  //* Field locations holding agricultural product
/* 14 */    float growthCosts;  //* Agricultural product growth costs (e.g., Feed-stuff and Fertilizer)
}

/* Ommitted
15) Farm acres dedicated to creation of agricultural product
*/

