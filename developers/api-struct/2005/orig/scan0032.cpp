// <NOTE> This is for question 17
// <NOTE> From scan file:  accu05/SCAN0032.jpg

enum travel_method { walk = 0, cycle = 1, car = 2, motor_bike = 4, ferry = 8,
                     train = 16, bus = 32, plane = 64 };
enum transport_category { self, passenger };

// <NOTE> There was no currency struct, so it's
// <NOTE> been added.
struct currency { };

struct transport_statistics {
/* * */    travel_method method;
/* * */    transport_category category;
/* 8 */    bool environmentally_friendly;  // (or double evnironmental_cost;)
/* 9 */    double arrival_delay_mean;
/* * */    double arrival_delay_standard_deviation;
/* * */    double arrival_delay_max;   // some common stats.  Could
/* * */    double arrival_delay_min;   // add more -10%-90% back, etc.
/* 2 */    double percentage_usage;
/* 6 */    currency Tax_revenue_generated; // per you?
/* 1 */    currency infrastructure_cost;   // " "
/* 9 */    bool congestion_dependent;
};

struct survey_result {
/* 5 */    double travel_time;
/* 3 */    currency weekly_travel_cost;
    // ..
    // ..
};
