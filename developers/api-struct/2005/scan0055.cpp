// <NOTE> This is for question 67
// <NOTE> From scan file:  accu05/SCAN0055.jpg
//API Agriculture

// <NOTE> This is needed so the code would compile.
#include <string>
using namespace std;

// <NOTE> The following two types did not exist.
// <NOTE> They've been added.
typedef __DUMMY_TYPE_ Logical;
typedef __DUMMY_TYPE_ DateTime;

class AgricultureType
{
/* * */    string name;    // Meat, Cereals
};

class Product
{
/* * */    string Name;
/* * */    AgricultureType * Type;
};

class SafetyInspection
{
/* 3 */    DateTime LastInspection;  //* Date of last official agricultural product food safety inspection
};

class Farm
{
/* 7 */    string Location;  //* Location of farm
/* 9 */    string Owner;  //* Farm owner
};

class Fields    // assume one field has one product
{
/* * */    Farm * farm;
/* 10 */    string Location;  //* Location of fields holding agricultural product
/* * */    Product * currentProduct;
/* 2 */    Logical Organic;  //* Produced organically
/* 1 */    DateTime productStartLife;  //* Date agricultural product started life
/* 12 */    DateTime productEndLife;  //* Agricultural product end life date
/* 15 */    long productionCost;  //* Agricultural product growth costs (e.g., Feed-stuff and Fertilizer)
};

class Chemical  // aka antibiotic
{
/* 4 */    string name;  //* Antibiotics / Chemicals used
};

class ProductPrice
{
/* * */    Product * product;
/* 11 */    long marketValue;  //* Market value of agricultural product
};

class FieldChemicals
{
/* * */    Fields * field;
/* * */    Chemical * chemical;
};
/* Omitted
5)Average labor costs of agricultural product
6)Number of each kind of agricultural product on farm
8)Farm acres dedicated to creation of agricultural product
13)Genetic ID
14)Agricultural product average shipment weight
*/

