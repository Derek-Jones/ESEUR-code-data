// <NOTE> This is for question 67
// <NOTE> From scan file:  accu05/SCAN0055.jpg

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
/* 3 */    DateTime LastInspection;
};

class Farm
{
/* 7 */    string Location;
/* 9 */    string Owner;
};

class Fields    // assume one field has one product
{
/* * */    Farm * farm;
/* 10 */    string Location;
/* * */    Product * currentProduct;
/* 2 */    Logical Organic;
/* 1 */    DateTime productStartLife;
/* 12 */    DateTime productEndLife;
/* 15 */    long productionCost;
};

class Chemical  // aka antibiotic
{
/* 4 */    string name;
};

class ProductPrice
{
/* * */    Product * product;
/* 11 */    long marketValue;
};

class FieldChemicals
{
/* * */    Fields * field;
/* * */    Chemical * chemical;
};
