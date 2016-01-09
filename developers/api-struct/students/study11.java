// <NOTE> Page 40


// <NOTE> This class declaration was added
// <NOTE> so the code would compile.

public class study11 { }

class Agriculture
{
    String farm_loc;
    boolean organic;
    double avg_labor_costs;
    int num_on_farm;
    double market_value;
    double avg_shipment_weight;
    int inspection_date;    // date encoded into int
    String[] field_loc;
    String owner;
    int start_date;
    int end_date;
    long /*int*/ gen_id;    // <NOTE> "int" needed to be removed
    double growth_costs;
    double acres;
}

class Meat extends Agriculture
{
    String[] antibiotics;
    String species; // needs fxn to assert valid input
}

class Cereal extends Agriculture
{
    String[] chemicals;
    String type;    // needs fxn to assert valid input
}
