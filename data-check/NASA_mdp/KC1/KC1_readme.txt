README file for data extracted from MDP database.  Monday, February 16, 2004 at 15:46:27


Foreword
************************************************************************
The term product refers to any item from which defect and metrics data 
can be generated.  In most cases products will refer to software 
code.  In this document the term product is used referring to CSCI
and module level data.

Defect data will refer to information parsed from an error report.  The 
problem will have been generated due to an error.  
The defect data incorporated into the Metrics Data Program will most 
often have its origins in other software designed specifically for the 
purpose of recording defect data.

The term metrics data applies to any finite numeric values, which describe 
measured qualities and characteristics of a product.

** Empty fields in the reports mean that either the value is not available
or does not apply to a particular item.

Note: Fields with project specific data are maintained by MDP, but are
not available for downloads from this website.
************************************************************************

DEFINITIONS OF TERMS:
PRODUCT - Refers to anything to which defect data and metrics data can be associated.
	In most cases products will be synonymous with code related items such as
	functions and systems/sub-systems.
CSCI - Term applied to a grouping of products usually having similar functions or
	capabilities.  Usually the term CSCI is synonymous with system or sub-system
	but the definition may vary from project to project.
CSC - Computer Software Component. CSCIs are comprised of logical groups of CSCs.
	 This design element generally is comprised of files, which make up an executable. 
CLASS - A template from which objects can be created.
MODULE - Term applied to the lowest level functional unit which metrics can be applied.
	In most cases this will refer to code specific items such as functions but
	the real world representation can vary between projects and programming
	languages (e.g. functions, modules, subroutines)
SEVERITY - This value quantifies the impact of the defect on the overall
	environment with 1 being most severe to 5 being least severe.
	For example, severity 1 may imply that the defect caused a loss
	of functionality without a workaround where severity 5 may mean that the impact
	is superficial and did not cause any major disruptions to the system.
PRIORITY - This value quantifies the necessity for this defect to be resolved
	where 1 has the highest priority (critical) to 3 for lowest priority.
	For example, priority 1 means that there is a critical need for the
	resolution of a defect where priority 3 may imply that the development
	or maintenance can delay the change.

************************************************************************
This README file contains a description of the data in the following files:

KC1_product_hierarchy.csv
KC1_defect_product_relations.csv
KC1_dynamic_defect_data.csv
KC1_static_defect_data.csv
KC1_product_module_metrics.csv
KC1_product_class_metrics.csv
KC1_odc_activity.csv
KC1_odc_target.csv
KC1_odc_type.csv
KC1_odc_age.csv
************************************************************************

Detailed description of files:
************************************************************************
KC1_product_module_metrics.csv
************************************************************************
This file contains all of the available metrics values and their associated
products.  These metrics are module level.

Field descriptions for KC1_product_module_metrics.csv
------------------------------------------------------------------------
MODULE - The unique numeric identifier of the product.
LOC_BLANK - The number of blank lines in a module.
BRANCH_COUNT - Branch count metrics.
LOC_CODE_AND_COMMENT - The number of lines which contain both code & comment
	 in a module.
LOC_COMMENTS - The number of lines of comments in a module.
CYCLOMATIC_COMPLEXITY - The cyclomatic complexity of a module.
DESIGN_COMPLEXITY - The design complexity of a module.
ERROR_COUNT - The number of defects associated with a module.
ERROR_DENSITY - The number of defects per 1000 lines of code for a module
	 [ERROR_DENSITY = 1000*(ERROR_COUNT/LOC_TOTAL)].
ESSENTIAL_COMPLEXITY - The essential complexity of a module.
LOC_EXECUTABLE - The number of lines of executable code for a module
	 (not blank or comment)
HALSTEAD_CONTENT - The halstead length content of a module.
HALSTEAD_DIFFICULTY - The halstead difficulty metric of a module.
HALSTEAD_EFFORT - The halstead effort metric of a module.
HALSTEAD_ERROR_EST - The halstead error estimate metric of a module.
HALSTEAD_LENGTH - The halstead length metric of a module.
HALSTEAD_LEVEL - The halstead level metric of a module.
HALSTEAD_PROG_TIME - The halstead programming time metric of a module.
HALSTEAD_VOLUME - The halstead volume metric of a module.
NUM_OPERANDS - The number of operands contained in a module.
NUM_OPERATORS - The number of operators contained in a module.
NUM_UNIQUE_OPERANDS - The number of unique operands contained in a module.
NUM_UNIQUE_OPERATORS - The number of unique operators contained in a module.
ERROR_REPORT_IN_1_YR - Number of error reports in one year.
ERROR_REPORT_IN_6_MON - Number of error reports in six months.
ERROR_REPORT_IN_2_YRS - Number of error reports in two years.
LOC_TOTAL - The total number of lines for a given module.
------------------------------------------------------------------------



KC1_product_class_metrics.csv
************************************************************************
This file contains all of the available metrics values and their associated
products.  These metrics are class level.

Field descriptions for KC1_product_class_metrics.csv
------------------------------------------------------------------------
MODULE - The unique numeric identifier of the product.
PERCENT_PUB_DATA - The percentage of data that is public and protected data
	  in a class.
ACCESS_TO_PUB_DATA - The amount of times that a class’s public and protected
	  data is accessed.
COUPLING_BETWEEN_OBJECTS - The number of distinct non-inheritance-related
	  classes on which a class depends.
DEPTH - Depth indicates at what level a class is located within its class hierarchy.
LACK_OF_COHESION_OF_METHODS - For each data field in a class, the 
	 percentage of the methods in the class using that data field;
	 the percentages are averaged then subtracted from 100%.
NUM_OF_CHILDREN - The number of classes derived from a specified class.
DEP_ON_CHILD - Whether a class is dependent on a descendant.
FAN_IN - This is a count of calls by higher modules.
RESPONSE_FOR_CLASS -  A count of methods implemented within a class plus the
	  number of methods accessible to an object class due to inheritance.
WEIGHTED_METHODS_PER_CLASS - A count of methods implemented within a class
	  (rather than all methods accessible within the class hierarchy).
------------------------------------------------------------------------



KC1_product_hierarchy.csv
************************************************************************
This file contains a representation of the product hierarchy as it exists
in the database.  

Field descriptions for KC1_product_hierarchy.csv
------------------------------------------------------------------------
CSC_ID	- The unique numeric identifiers of the CSCs.
CLASS_ID - The unique numeric identifiers of the Classes contained by the CSC.
MODULE_ID - The unique numeric identifiers of the modules contained by the Class and CSC.
LANGUAGE - The programming language in which the product was developed.
------------------------------------------------------------------------



KC1_defect_product_relations.csv
************************************************************************
This file lists directly makes the link between products and the
defect records to which they are associated.

Field descriptions for KC1_defect_product_relations.csv
------------------------------------------------------------------------
MODULE_ID - The unique numeric identifier of the module.
DEFECT_ID - The unique numeric identifier of the associated defect.
------------------------------------------------------------------------



KC1_static_defect_data.csv
************************************************************************
This file contains defect data that remains constant throughout the life
cycle of that defect.  Priority and severity values are listed in this 
file for project KC1 because these values do not change over the life of a
defect.  Future projects may have these values excluded from this file.
Field descriptions for KC1_static_defect_data.csv
------------------------------------------------------------------------
DEFECT_ID - The unique numeric identifier of the defect.
SEVERITY - The severity of the defect.
PRIORITY - The priority of the defect.
CODE_REV - Whether or not the defect had a code review [yes(Y) or no (N)].
DESIGN_REV - Whether or not the defect had a design review [yes(Y) or no (N)].
CLOSE_REASON - The general reason for the closure of the error report.
COST - Relative cost for the fix.
DEFFERRED_ON - The date the error report was deferred.
EST_FIX_HOURS - The number of man hours it took to implement the fix.
EST_SLOC_COUNT - The number of sloc involved in the fix.
FIX_HOURS - The actual number of man hours the fix took to implement.
HOW_FOUND - The stage in which the defect was found.
MODE - The mode the system was operating in.
PROBLEM_TYPE - Specific reason for closure of error report.
SLOC_COUNT - The actual number of SLOC changed or added.
------------------------------------------------------------------------



KC1_dynamic_defect_data.csv
************************************************************************
This file contains defect data that changes constant throughout the life
cycle of that defect.  This file essentially outlines the history of the
defect.  The dates for ACTIVITY and TRIGGER entries are the dates on which
the defect was opened.  The dates for TARGET_PRODUCT_ID and DEFECT_TYPE
are the dates on which the defect was closed.

Field descriptions for KC1_dynamic_defect_data.csv
------------------------------------------------------------------------
DEFECT_ID - The unique numeric identifier of the defect.
ENTRY_TYPE - The type of defect history entry represented.
ENTRY_DATE - The date associated with the defect data entry.
ENTRY_SEVERITY - The severity at the time of the entry.
ENTRY_PRIORITY - The priority at the time of the entry.
ENTRY_DATA - The data contained in the entry
------------------------------------------------------------------------

Notes:

ENTRY data explanations for the following ENTRY_TYPE field values:
------------------------------------------------------------------------
ACTIVITY - The activity taking place during which the defect was discovered.
TRIGGER - The apparent action that caused of the defect to surface.
TARGET_PRODUCT_ID - The unique numeric identifier(s) of the products
		that are associated to this defect record.
DEFECT_TYPE - Information regarding the type of the defect.
COMMENT - Comment(s) made throughout the life cycle of the defect.  
STATE_CHANGE - Information regarding the state changes of a defect record.
CHANGE_CONTROL_BOARD - Information about change control board meetings which
		took place regarding the defect.
------------------------------------------------------------------------



KC1_odc_activity.csv
************************************************************************
This file contains ODC Activity data that describes the task that was being
performed when the defect was uncovered.

Field descriptions for KC1_odc_activity.csv
------------------------------------------------------------------------
DEFECT_ID - The unique numeric identifier of the defect.
ACTIVITY - The task performed when defect was found.
------------------------------------------------------------------------



KC1_odc_target.csv
************************************************************************
This file contains ODC Target data that describes a high-level
classification of the deliverable that was fixed.

Field descriptions for KC1_odc_target.csv
------------------------------------------------------------------------
DEFECT_ID - The unique numeric identifier of the defect.
TARGET - The high-level classification of the deliverable that was fixed.
------------------------------------------------------------------------



KC1_odc_type.csv
************************************************************************
This file contains ODC Type data that describes the corrections made to 
resovle the defect.

Field descriptions for KC1_odc_type.csv
------------------------------------------------------------------------
DEFECT_ID - The unique numeric identifier of the defect.
TYPE - The corrections made to resovle the defect.
------------------------------------------------------------------------



KC1_odc_age.csv
************************************************************************
This file contains ODC Age data describes the age of the defect.

Field descriptions for KC1_odc_age.csv
------------------------------------------------------------------------
DEFECT_ID - The unique numeric identifier of the defect.
AGE - The age of the defect. (Base, New, Rewritten, etc...)
------------------------------------------------------------------------





Contact information for the Metrics Data Program
************************************************************************
Mike Chapman
Project concept developer, project lead for Galaxy Global Corporation, 
	code level metrics specialist.
Email:  Robert.M.Chapman@ivv.nasa.gov
Phone:  (304) 367-8341

Chip Smith
Developer/Administrator.
Email:  Chip.Smith@titan.com

MDP Website:  http://mdp.ivv.nasa.gov/
************************************************************************
