# <NOTE> This is for question Example
# <NOTE> From scan file:  08/scan0062.jpg, scan0063.jpg, and scan0064.jpg
//API Example

# <NOTE> This subject's handwriting is difficult to read
# <NOTE> so some names and comments may be a guess.

# Rationale for a flat mapping was named members.
# Flat is rede than nested with well names members, without nesting, the data is easy to access. 
# Address is a list of strings rather than a single string because this is the common way to specify address.
# Actually . ignore my comments, to the right! Defining data structures live
# these lever if they are not declared is quite normal. Trying to do it without use cases is still impossible! :-)

# I program with a dynamically typed language (python) that is a classic imperative language -
# but you don't declare data structures.

# A non-object based representative  is very non-idiometric.
# For this problem in python : (And a worthwhile answer can only be achieved by using actual use-cases for the API;)

NOT_APPLICABLE = 0
DETACHED = 1
SEMI = 2
TERRACED = 3

Address of accommodation	
2) Detached, Semi-detached, Terraced	
3) Easily moved	
4) Floor number of accommodation	
5) Name of current responsible occupant	
6) Name of given town	
7) Number of bathrooms	
8) Number of bedrooms	
9) Number of each kind of accommodation in given town
10) Number of rooms	
11) Parking space included with accommodation	
12) Shared bathroom	
13) Size of garden
14) State of repair
15) Total area of floor space
16) Total value of each kind accommodation in given town
17) Weekly rent

# dictionary-mapping type

accomodation = { 'type': int,
/* 1 */                 'address': [], # (list of strings)  //* Address of accommodation
/* 2 */                 'detached': DETACHED,  # (flag) //* Detached, Semi-detached, Terraced
/* 3 */                 'moveable': True,  # boolean  //* Easily moved
/* 4 */                 'floor': 1,    # int  //* Floor number of accommodation
/* 5 */                 'occupant': 'Fred', # string  //* Name of current responsible occupant
                 # <NOTE> crossed out:  'number_of_type':
/* 7 */                 'bathrooms': int,  //* Number of bathrooms
/* 8 */                 'bedrooms': int,  //* Number of bedrooms
/* 6 */                 'town': string,  //* Name of given town
/* 10 */                 'rooms': int,  //* Number of rooms
/* 11 */			'parking': bool, //* Parking space included with accommodation
/* 12 */                 'shared_bathroom': bool,  //* Shared bathroom
/* 13 */                 'size_garden': int,  //* Size of garden
/* 14 */                 'state': string,  //* State of repair
/* 15 */                 'floor': int,  //* Total area of floor space
/* 16 */                 'value': int,  //* Total value of each kind accommodation in given town
/* 17 */                 'rent': int  //* Weekly rent
               }

# plus a mapping of type (defined as constraints) to total number in town
# so probably a mapping of towns to mappings of types to numbers.
# = {.towns.. {CARAVAN : 100,     HOSTEL : 400, ..}, .towns..

# <NOTE> Crossed out:  (crossed out) farm array = {
#                                                  animals pointer to array
#                                                  antibiotics pointer to array

# I've not worked in a language limited to numerics. Pointers and arrays.

/* Ommitted
9) Number of each kind of accommodation in given town
*/

