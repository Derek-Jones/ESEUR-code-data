package nz.ac.massey.cs.deploymentpuzzlersurvey;

import static nz.ac.massey.cs.deploymentpuzzlersurvey.Settings.*;
import nz.ac.massey.cs.deploymentpuzzlersurvey.answer.Answer;
public class TechnicalQuestions {
	
	public static final TechnicalQuestion[] QUESTIONS = {
		new TechnicalQuestion(
				"IF1-UPGR",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 1,
				Answer.UPGRADE_SUCCEEDS,
				"addtointerface",
				Category.INTERFACES
		), // checked
		new TechnicalQuestion(
				"IF1-RECP",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 3,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 3,
				Answer.RECOMPILE_FAILS,
				"addtointerface",
				Category.INTERFACES				
		), // checked
		new TechnicalQuestion(
				"IF2-UPGR",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 5,
				Answer.UPGRADE_SUCCEEDS,
				"removefrominterface1",
				Category.INTERFACES
		), // checked
		new TechnicalQuestion(
				"IF2-RECP",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 7,
				Answer.RECOMPILE_FAILS,
				"removefrominterface1",
				Category.INTERFACES				
		), // checked
		new TechnicalQuestion(
				"IF3-UPGR",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 9,
				Answer.UPGRADE_SUCCEEDS,
				"removefrominterface2",
				Category.INTERFACES
		), // checked
		new TechnicalQuestion(
				"IF3-RECP",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 11,
				Answer.RECOMPILE_SUCCEEDS,
				"removefrominterface2",
				Category.INTERFACES				
		), // checked
		new TechnicalQuestion(
				"IF4-UPGR",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 13,
				Answer.UPGRADE_FAILS,
				"removefrominterface3",
				Category.INTERFACES
		), // checked
		new TechnicalQuestion(
				"IF4-RECP",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 15,
				Answer.RECOMPILE_FAILS,
				"removefrominterface3",
				Category.INTERFACES				
		), // checked 
		new TechnicalQuestion(
				"SP_RET1-UPGR",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 5,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 17,
				Answer.UPGRADE_FAILS,
				"specialiseReturnType1",
				Category.METHOD_SIGNATURES
		), // checked
		new TechnicalQuestion(
				"SP_RET1-RECP",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 7,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 19,
				Answer.RECOMPILE_SUCCEEDS,
				"specialiseReturnType1",
				Category.METHOD_SIGNATURES				
		), // checked
		new TechnicalQuestion(
				"SP_RET2-UPGR",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 21,
				Answer.UPGRADE_FAILS,
				"specialiseReturnType2",
				Category.METHOD_SIGNATURES
		), // checked
		new TechnicalQuestion(
				"SP_RET2-RECP",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 23,
				Answer.RECOMPILE_SUCCEEDS,
				"specialiseReturnType2",
				Category.METHOD_SIGNATURES				
		), // checked
		new TechnicalQuestion(
				"SP_RET3-UPGR",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 25,
				Answer.UPGRADE_FAILS,
				"specialiseReturnType3",
				Category.METHOD_SIGNATURES
		), // checked
		new TechnicalQuestion(
				"SP_RET3-RECP",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 27,
				Answer.RECOMPILE_FAILS,
				"specialiseReturnType3",
				Category.METHOD_SIGNATURES				
		), // checked
		new TechnicalQuestion(
				"SP_RET4-UPGR",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 29,
				Answer.UPGRADE_SUCCEEDS,
				"specialiseReturnType4",
				Category.METHOD_SIGNATURES
		), // checked
		new TechnicalQuestion(
				"SP_RET4-RECP",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 31,
				Answer.RECOMPILE_FAILS,
				"specialiseReturnType4",
				Category.METHOD_SIGNATURES				
		), // checked
		new TechnicalQuestion(
				"GEN_PAR1-UPGR",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 9,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 33,
				Answer.UPGRADE_FAILS,
				"generaliseParamType1",
				Category.METHOD_SIGNATURES
		), // checked
		new TechnicalQuestion(
				"GEN_PAR1-RECP",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 11,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 35,
				Answer.RECOMPILE_SUCCEEDS,
				"generaliseParamType1",
				Category.METHOD_SIGNATURES				
		), // checked
		new TechnicalQuestion(
				"GEN_PAR2-UPGR",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 37,
				Answer.UPGRADE_FAILS,
				"generaliseParamType2",
				Category.METHOD_SIGNATURES
		), // checked
		new TechnicalQuestion(
				"GEN_PAR2-RECP",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 39,
				Answer.RECOMPILE_FAILS,
				"generaliseParamType2",
				Category.METHOD_SIGNATURES				
		), // checked
		new TechnicalQuestion(
				"GEN_PAR3-UPGR",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 13,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 41,
				Answer.UPGRADE_FAILS,
				"generaliseParamType3",
				Category.METHOD_SIGNATURES
		), // checked
		new TechnicalQuestion(
				"GEN_PAR3-RECP",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 15,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 43,
				Answer.RECOMPILE_SUCCEEDS_BUT,
				"generaliseParamType3",
				Category.METHOD_SIGNATURES				
		), // checked
		new TechnicalQuestion(
				"ADD_EXC1-UPGR",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 45,
				Answer.UPGRADE_SUCCEEDS_BUT,
				"exceptions1",
				Category.EXCEPTIONS
		), // checked
		new TechnicalQuestion(
				"ADD_EXC1-RECP",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 47,
				Answer.RECOMPILE_SUCCEEDS_BUT,
				"exceptions1",
				Category.EXCEPTIONS				
		), // checked
		new TechnicalQuestion(
				"ADD_EXC2-UPGR",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 17,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 49,
				Answer.UPGRADE_SUCCEEDS_BUT,
				"exceptions2",
				Category.EXCEPTIONS
		), // checked
		new TechnicalQuestion(
				"ADD_EXC2-RECP",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 19,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 51,
				Answer.RECOMPILE_FAILS,
				"exceptions2",
				Category.EXCEPTIONS				
		), // checked
		new TechnicalQuestion(
				"SPEC_EXC1-UPGR",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 53,
				Answer.UPGRADE_SUCCEEDS,
				"exceptions4",
				Category.EXCEPTIONS
		), // checked
		new TechnicalQuestion(
				"SPEC_EXC1-RECP",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 55,
				Answer.RECOMPILE_SUCCEEDS,
				"exceptions4",
				Category.EXCEPTIONS				
		), // checked
		new TechnicalQuestion(
				"REM_EXC1-UPGR",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 21,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 57,
				Answer.UPGRADE_SUCCEEDS_BUT,
				"exceptions5",
				Category.EXCEPTIONS
		), // checked
		new TechnicalQuestion(
				"REM_EXC1-RECP",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 23,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 59,
				Answer.RECOMPILE_FAILS,
				"exceptions5",
				Category.EXCEPTIONS				
		), // checked
		new TechnicalQuestion(
				"REM_EXC2-UPGR",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 61,
				Answer.UPGRADE_SUCCEEDS_BUT,
				"exceptions6",
				Category.EXCEPTIONS
		), // checked
		new TechnicalQuestion(
				"REM_EXC2-RECP",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 63,
				Answer.RECOMPILE_SUCCEEDS_BUT,
				"exceptions6",
				Category.EXCEPTIONS				
		), // checked
		new TechnicalQuestion(
				"BOX1-UPGR",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 25,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 65,
				Answer.UPGRADE_FAILS,
				"primwrap1",
				Category.BOXING
		), // checked
		new TechnicalQuestion(
				"BOX1-RECP",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 27,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 67,
				Answer.RECOMPILE_SUCCEEDS,
				"primwrap1",
				Category.BOXING				
		), // checked
		new TechnicalQuestion(
				"BOX2-UPGR",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 69,
				Answer.UPGRADE_FAILS,
				"primwrap2",
				Category.BOXING
		), // checked
		new TechnicalQuestion(
				"BOX2-RECP",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 71,
				Answer.RECOMPILE_SUCCEEDS,
				"primwrap2",
				Category.BOXING				
		), // checked
		new TechnicalQuestion(
				"GEN1-UPGR",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 29,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 73,
				Answer.UPGRADE_SUCCEEDS,
				"generics1",
				Category.GENERICS
		), // checked
		new TechnicalQuestion(
				"GEN1-RECP",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 31,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 75,
				Answer.RECOMPILE_FAILS,
				"generics1",
				Category.GENERICS				
		), // checked
		new TechnicalQuestion(
				"GEN2-UPGR",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 33,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 77,
				Answer.UPGRADE_SUCCEEDS_BUT, // not a binary compatibility problem acc to the JLS !!
				"generics2",
				Category.GENERICS
		), // checked
		new TechnicalQuestion(
				"GEN2-RECP",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 35,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 79,
				Answer.RECOMPILE_FAILS,
				"generics2",
				Category.GENERICS				
		), // checked
		
		// inlining 
		
		new TechnicalQuestion(
				"CON1",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 37,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 81,
				Answer.PRINTS_42,
				"constants1",
				Category.INLINING				
		), // checked
		new TechnicalQuestion(
				"CON2",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 39,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 83,
				Answer.PRINTS_42,
				"constants2",
				Category.INLINING				
		), // checked
		new TechnicalQuestion(
				"CON3",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 41,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 85,
				Answer.PRINTS_42,
				"constants3",
				Category.INLINING				
		), // checked
		new TechnicalQuestion(
				"CON4",
				USER_DATA_COLUMN_OFFSET + SHORT_SURVEY_OFFSET + 43,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 87,
				Answer.PRINTS_43,
				"constants4",
				Category.INLINING				
		), // checked
		
		// misc
		new TechnicalQuestion(
				"NEST-UPGR",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 89,
				Answer.UPGRADE_FAILS,
				"ghost",
				Category.OTHERS
		),
		new TechnicalQuestion(
				"NEST-RECP",
				-1,
				USER_DATA_COLUMN_OFFSET + FULL_SURVEY_OFFSET + 91,
				Answer.RECOMPILE_SUCCEEDS,
				"ghost",
				Category.OTHERS				
		),
		
	};
	

}
