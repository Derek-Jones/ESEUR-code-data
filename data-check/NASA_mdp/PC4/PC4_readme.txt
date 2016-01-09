README file for data extracted from MDP database.  Friday, February 25, 2005 at 09:48:22


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

PC4_product_hierarchy.csv
PC4_defect_product_relations.csv
PC4_dynamic_defect_data.csv
PC4_static_defect_data.csv
PC4_product_module_metrics.csv
************************************************************************

Detailed description of files:
************************************************************************
PC4_product_module_metrics.csv
************************************************************************
This file contains all of the available metrics values and their associated
products.  These metrics are module level.

Field descriptions for PC4_product_module_metrics.csv
------------------------------------------------------------------------
MODULE - The unique numeric identifier of the product.
LOC_BLANK - The number of blank lines in a module.
BRANCH_COUNT - Branch count metrics.
CALL_PAIRS - Number of calls to other functions in a module.
LOC_CODE_AND_COMMENT - The number of lines which contain both code & comment
	 in a module.
LOC_COMMENTS - The number of lines of comments in a module.
CONDITION_COUNT - Number of conditionals in a given module.
CYCLOMATIC_COMPLEXITY - The cyclomatic complexity of a module.
CYCLOMATIC_DENSITY - It is the ratio of the module's cyclomatic complexity to its
	 length in NCSLOC. The intent is to factor out the size component of complexity. It has the effect of
	 normalizing the complexity of a module, and therefore its maintenance difficulty.
DECISION_COUNT - Number of decision points in a given module.
DECISION_DENSITY - Calculated as: Cond / Decision.
DESIGN_COMPLEXITY - The design complexity of a module.
DESIGN_DENSITY - Design density is calculated as: iv(G)/v(G).
EDGE_COUNT - Number of edges found in a given module. Represents the transfer of
	 control from one module to another. (Edges are a base metric, used to calculate many of the more
	 involved complexity metric).
ERROR_COUNT - The number of defects associated with a module.
ERROR_DENSITY - The number of defects per 1000 lines of code for a module
	 [ERROR_DENSITY = 1000*(ERROR_COUNT/LOC_TOTAL)].
ESSENTIAL_COMPLEXITY - The essential complexity of a module.
ESSENTIAL_DENSITY - Essential density is calculated as: (ev(G)-1)/(v(G)-1).
LOC_EXECUTABLE - The number of lines of executable code for a module
	 (not blank or comment)
PARAMETER_COUNT - Number of parameters to a given module.
GLOBAL_DATA_COMPLEXITY - Global Data Complexity quantifies the cyclomatic complexity of a 
	module's structure as it relates to global/parameter data.
GLOBAL_DATA_DENSITY - Global Data density is calculated as: gdv(G) / v(G).
HALSTEAD_CONTENT - The halstead length content of a module.
HALSTEAD_DIFFICULTY - The halstead difficulty metric of a module.
HALSTEAD_EFFORT - The halstead effort metric of a module.
HALSTEAD_ERROR_EST - The halstead error estimate metric of a module.
HALSTEAD_LENGTH - The halstead length metric of a module.
HALSTEAD_LEVEL - The halstead level metric of a module.
HALSTEAD_PROG_TIME - The halstead programming time metric of a module.
HALSTEAD_VOLUME - The halstead volume metric of a module.
MAINTENANCE_SEVERITY - Maintenance Severity is calculated as: ev(G)/v(G).
MODIFIED_CONDITION_COUNT - 
MULTIPLE_CONDITION_COUNT - Number of multiple conditions that exist within a module.
NODE_COUNT - Number of nodes found in a given module. (Nodes are a base metric, used to
	 calculate many of the more involved complexity metrics).
NORMALIZED_CYLOMATIC_COMPLEXITY - 
NUM_OPERANDS - The number of operands contained in a module.
NUM_OPERATORS - The number of operators contained in a module.
NUM_UNIQUE_OPERANDS - The number of unique operands contained in a module.
NUM_UNIQUE_OPERATORS - The number of unique operators contained in a module.
NUMBER_OF_LINES - Number of lines in a module. Pure, simple count from open bracket to
	 close bracket. Includes every line in between, regardless of character content.
PATHOLOGICAL_COMPLEXITY - A measure of the degree to which a module contains extremely unstructured constructs.
PERCENT_COMMENTS - Percentage of the code that is comments. Calculated as: ((CLOC+C&SLOC)/(SLOC+CLOC+C&SLOC))*100
LOC_TOTAL - The total number of lines for a given module.
------------------------------------------------------------------------



PC4_product_hierarchy.csv
************************************************************************
This file contains a representation of the product hierarchy as it exists
in the database.  

Field descriptions for PC4_product_hierarchy.csv
------------------------------------------------------------------------
CSCI_ID	- The unique numeric identifiers of the CSCIs.
CSC_ID	- The unique numeric identifiers of the CSCs.
MODULE_ID - The unique numeric identifiers of the modules contained by the CSCs.
LANGUAGE - The programming language in which the product was developed.
------------------------------------------------------------------------



PC4_defect_product_relations.csv
************************************************************************
This file lists directly makes the link between products and the
defect records to which they are associated.

Field descriptions for PC4_defect_product_relations.csv
------------------------------------------------------------------------
MODULE_ID - The unique numeric identifier of the module.
DEFECT_ID - The unique numeric identifier of the associated defect.
------------------------------------------------------------------------



PC4_static_defect_data.csv
************************************************************************
This file contains defect data that remains constant throughout the life
cycle of that defect.  Priority and severity values are listed in this 
file for project PC4 because these values do not change over the life of a
defect.  Future projects may have these values excluded from this file.
Field descriptions for PC4_static_defect_data.csv
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



PC4_dynamic_defect_data.csv
************************************************************************
This file contains defect data that changes constant throughout the life
cycle of that defect.  This file essentially outlines the history of the
defect.  The dates for ACTIVITY and TRIGGER entries are the dates on which
the defect was opened.  The dates for TARGET_PRODUCT_ID and DEFECT_TYPE
are the dates on which the defect was closed.

Field descriptions for PC4_dynamic_defect_data.csv
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
