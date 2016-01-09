// <NOTE> This is for question 4
// <NOTE> From scan file:  accu05/SCAN0006.jpg - SCAN0008.jpg
//API Agriculture

// <NOTE> These #includes were added so the code would compile.
#include <string>
#include <vector>
using namespace std;

// 1) Going to assume farm owner and location of farm
//    are only for cereals and not fish (ie no fish farms)
// 2) Also, going to assume that there is some address structure
//    that is near there.  Actually, lets define one.
//    Useability in other areas.
// 3) Given restrictions on datatypes, going to define date structure.

struct date
{
/* * */    int day;
/* * */    int month;
/* * */    int year;
};

struct address
{
/* * */    string line1, line2;
/* * */    string town, postcode;
};
// assume postcodes even though
// small island (helps sorting)

struct doa_details
{
/* 1 */    date last_inspection;  //* Date of last official agricultural product food safety inspection
/* 3 */    double average_shipment_weight;  //* Agricultural product average shipment weight
    // <NOTE> The following was crossed out:
    // double average_labor;
};

struct farm_doa_details : doa_details
{
/* 7 */    double average_labor_cost;  //* Average labor costs of agricultural product
};

enum Cereals
{
    Barley, Corn, Wheat
};

enum Fish
{
    Salmon, Trout, Eels
};

struct AggProduct
{
/* * */    Cereals type;
/* 2 */    string chemicals;  //* Antibiotics / Chemicals used
/* 4 */    date date_planted;  //* Date agricultural product started life
/* 8 */    date date_harvested;  //* Date agricultural product killed
/* 5 */    double market_value;  //* Agricultural product market value
/* * */    double average;
/* 12 */    bool organic;  //* Was organically produced
/* 13 */    double cost;  //* Agricultural product growth costs (e.g., Feed-stuff and Fertilizer)
/* 11 */    string location;    // more descriptive  //* Location of fields holding agricultural product
};

struct farm
{
/* 6 */    double total_acres;  //* Farm acres dedicated to creation of agricultural product
/* * */    int owner_id;
/* 10 */    string owner;  //* Farm owner
/* 14 */    address farm_location;  //* Location of farm
/* * */    vector<AggProduct> products;
};

struct fish_product
{
/* * */    Fish type;
/* 8 */    date date_killed;  //* Date agricultural product killed
/* 5 */    double market_value;  //* Agricultural product market value
};

// Ideally would have created business struct
// that both farm and fishing_buss when - farm
// but out of time.

struct fishing_business
{
/* * */    int fisher_id;
/* 10 */    string fisher_name;  //* Farm owner
/* 14 */    address business_address;  //* Location of farm
};

/* Omitted
9)Genetic ID
15)Number of each kind of agricultural product of farm
*/

