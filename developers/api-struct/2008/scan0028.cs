// <NOTE> This is for question Example
// <NOTE> From scan file:  08/scan0028.jpg - scan0029.jpg
//API Example

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class __DUMMY_CLASSID { }

public class Caravan extends Accomodation
{
    public boolean isMovable () {return true;}
}

public class Building extends Accomodation
{
    public static final int TYPE_BUNGALOW = 0;
    public static final int TYPE_DORMTORY = 1;
    public static final int TYPE_YOUTH_HOSTEL = 4;

    public static final int CONSTRUCTION_DETACHED = 0;
    public static final int CONSTRUCTION_SEMI_DETACHED = 1;
    public static final int CONSTUCTION_DETACHED = 2;
    private int type;
    private int construction;
}

/*
damit_flow
number ?
need more classes;
lose "type" field
entirely?
Could also shove # of
Each kind of accommodation
Into a static method?
(or more somewhere else- really a query over records in a DB performing a sum) 
Accommodation accommodation building caravan 
type
address
detached & c . only applies to certain types?
*/

public class Address
{
/* * */    private String line1;
/* * */    private String line2;
/* * */    private String Town;  // or appropriate local variation
/* * */    private String County;
/* * */    private String Postcode;    
    // + accessor methods + suotable constructor as usual (get ..)
}

// <NOTE> The word "abstract" needed to
// <NOTE> be commented out so the code would compile.

public abstract class Accomodation
{
/* 1 */    private Address address;  //* Address of accommodation
/* 5 */    private String occupantName;  //* Name of current responsible occupant
/* 7 */    private int numberOfBathrooms;  //* Number of bathrooms
/* 8 */    private int numberOfBedrooms;  //* Number of bedrooms
 // constraint - greater than the sum of
/* 10 */    private int numberOfRooms;  //* Number of rooms
    // previous two fields replace with number of other rooms
    // (but think of a less ickey name)

/* 3 */    abstract boolean isMoveable ();  //* Easily moved
/* 11 */    private boolean parkingSpaceIncluded;  //* Parking space included with accommodation
 // how does this make sense given potential for multiple bathrooms? (probably only applicable to certain types)
/* 12 */    private boolean bathroomShared; //* Shared bathroom
}


//this would be much easier with a desk/table

/* Ommitted
2) Detached, Semi-detached, Terraced	
4) Floor number of accommodation	
6) Name of given town	
9) Number of each kind of accommodation in given town
13) Size of garden
14) State of repair
15) Total area of floor space
16) Total value of each kind accommodation in given town
17) Weekly rent
*/

