// <NOTE> Page 115

#include "typedefs.h"

struct fish {
    char * type;    // salmon, trout, eel
    char * slaughter_date;
    char * vet_inspect_date;
    char * pedigree_id;
    char * antibiotics;
    double raise_cost;
    double value;
    double feed_cost;
    char * bdate;
};

struct cereal {
    char * type;    // barley, corn, wheat
    char * weed_killer;
    bool organic;
    char * date_harvest;
    char * date_sow;
    char * fertilizer;
    char * genetic_id;
    double fert_cost;
};

struct fish_farm {
    struct fish ** fish;
    int acres;
    char * owner;
    int s_count;
    int t_count;
    int e_count;
    char * location;
};

struct cereal_farm {
    struct cereal ** cereal;
    char * location;
    char * owner;
    int acres;
    double labor_cost;
    double value;
    char * seed_supply;
    double ship_weight;
};
