// <NOTE> This is for question 17
// <NOTE> From scan file:  accu05/SCAN0032.jpg
//API Transport

enum travel_method { walk = 0, cycle = 1, car = 2, motor_bike = 4, ferry = 8,
                     train = 16, bus = 32, plane = 64 };
enum transport_category { self, passenger };

// <NOTE> There was no currency struct, so it's
// <NOTE> been added.
struct currency { };

struct transport_statistics {
/* * */    travel_method method;
/* * */    transport_category category;
/* 8 */    bool environmentally_friendly;  // (or double evnironmental_cost;) //* Method of transport is environment friendly
/* * */    double arrival_delay_mean;
/* * */    double arrival_delay_standard_deviation;
/* * */    double arrival_delay_max;   // some common stats.  Could
/* * */    double arrival_delay_min;   // add more -10%-90% back, etc.
/* 2 */    double percentage_usage;  //* Percentage of workforce using transport method
/* 6 */    currency Tax_revenue_generated; // per you?  //* Tax revenue from transport method
/* 1 */    currency infrastructure_cost;   // " " //* Yearly expenditure on infrastructure supporting transport method
/* 9 */    bool congestion_dependent;  //* Arrival time affected by congestion
};

struct survey_result {
/* 5 */    double travel_time;  //* Travel time
/* 3 */    currency weekly_travel_cost;  //* Weekly travel cost
    // ..
    // ..
};

/* Omitted
4)Probability of arriving on time
7)Distance to travel
*/

