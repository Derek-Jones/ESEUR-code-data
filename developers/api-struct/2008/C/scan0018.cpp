// <NOTE> This is for question: Example
// <NOTE> From scan file:  08/scan0018.jpg - scan0019.jpg
// <NOTE> SCAN0020.jpg is a duplicate of SCAN0019.jpg
//API Example

// <NOTE> Almost everything written by this subject
// <NOTE> is incredibly difficult to read.
// <NOTE> All guesses will be marked.

enum eAcc_type
{
    eBungalow,
    eCaravan,
    eDormitory,
    eFlat,
    eHouse,
    eYouthHostel
};
typedef std::vector <std:: string>  tAccs;
typedef std::mapc <Acc.type, uint>, tAccCount;
tAccs  vAccs = {"Bungalow", "caravan", "domitory", "flat", "house", "hotel"};
typedef std::map <eAcctype, Uint> tAccval;

// <NOTE> class cAcc moved here so get source compiled
class cAcc
{
    public:
        cAcc (const cTown const * pTown, const cStreet const * pStreet,
		      const cHouseId const * pHouseID, const cAccType accType);
    private:
/* 6 */        const cTown const * m_pTown;  //* Name of given town
/* 1 */        const cStreet const * m_pStreet;  //* Address of accommodation
/* 1 */        const cHouseID const * m_pHouseID;  //* Address of accommodation
/* * */        const cAccType m_accType;
/* 17 */        const uint m_weeklyrent;  //* Weekly rent
/* 5 */        const std::string m_occupant;  //* Name of current responsible occupant
/* 13 */        const uint m_gardenlength;  //* Size of garden
/* 13 */        const uint m_gardenwidth;  //* Size of garden
/* 14 */        eStateOfRepair m_StateofRepair;  //* State of repair

        // <NOTE> (crossed out) Class cAcc Val
        // <NOTE> (crossed out) typedef std::map < cAcc_type, uint AccVal;
};


class cTown
{
    public:
/* * */        cTown (const std::string name); m_name (name) {}
    private:
/* * */        const std::string m_name;
/* 16 */        tAccVal m_accVal;  //* Total value of each kind accommodation in given town
/* 9 */        tAccCount m_accCount;  //* Number of each kind of accommodation in given town
};

class cStreet
{
    public;
/* * */        cStreet (std::string of name);  m_name (name) {}
    private:
/* * */        const std::string m_name;
};
class cHouseID
    cHouseID (const uint num) : m_num (name){}
    cHouseID (const std::string & name) : m_name (name){}
                                          m_name(0)
    std :: string name ()
    {
        if (name) return lexical_cost<std::string>(name);
        return m_name;
    }
    private:
/* * */        const uint m_num;
/* * */        const std::string m_name;
};

// <NOTE> class cAcc written here in answer

enum
eStateofRepair
{
    eDelpidated,
    ePerfect,
    eOk,
};

/* Ommitted
2) Detached, Semi-detached, Terraced	
3) Easily moved	
4) Floor number of accommodation	
7) Number of bathrooms	
8) Number of bedrooms	
10) Number of rooms	
11) Parking space included with accommodation	
12) Shared bathroom	
15) Total area of floor space
*/
