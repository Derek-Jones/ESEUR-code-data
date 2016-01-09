#
# Zhu_et_al-2014.R, 23 Dec 15
#
# Data from:
#
# An analysis of programming language statement frequency in {C}, {C++}, and {Java} source code
# Xiaoyan Zhu and E. James Whitehead Jr. and Caitlin Sadowski and Qinbao Song
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


# Number,Project,File,TotalLines,ExecuteLines,FunctionCall,FunctionCall_percent,If,If_percent,Assignment,Assignment_percent,Function,Function_percent,FunctionDeclaration,FunctionDeclaration_percent,Loop,Loop_percent,DeclarationStatement,DeclarationStatement_percent,Declaration,Declaration_percent,ExpressionStatement,ExpressionStatement_percent,Expression,Expression_percent,ParameterList,ParameterList_percent,Parameter,Parameter_percent,ArgumentList,ArgumentList_percent,Argument,Argument_percent,Block,Block_percent,Continue,Continue_percent,Break,Break_percent,Return,Return_percent,For,For_percent,Else,Else_percent,While,While_percent,Do,Do_percent,Switch,Switch_percent,Case,Case_percent,LocalFunctionCall,LibFunctionCall,GetterSetterCall,ZeroOperatorAssign,ZeroOpCallAssign,ConstAssign,DeclInDeclStmt,DeclInFor,ParamDecl,Struct,Struct_percent,Gogo,Goto_percent,Label,Label_percent
stmt_c=read.csv(paste0(ESEUR_dir, "src_measure/TotalStatistics_line_c.csv.xz"), as.is=TRUE)
stmt_cpp=read.csv(paste0(ESEUR_dir, "src_measure/TotalStatistics_line_cpp.csv.xz"), as.is=TRUE)
stmt_java=read.csv(paste0(ESEUR_dir, "src_measure/TotalStatistics_line_java.csv.xz"), as.is=TRUE)

pal_col=rainbow(3)

plot_stmt=function(stmt_str)
{
c_density=density(getElement(stmt_c, paste0(stmt_str, "_percent")))
cpp_density=density(getElement(stmt_cpp, paste0(stmt_str, "_percent")))
java_density=density(getElement(stmt_java, paste0(stmt_str, "_percent")))
max_x=max(c(c_density$x, cpp_density$x, java_density$x))
max_y=max(c(c_density$y, cpp_density$y, java_density$y))

plot(c_density, col=pal_col[1],
	main="", xlab="", ylab="",
	xlim=c(0, max_x), ylim=c(0, max_y))
lines(cpp_density, col=pal_col[2])
lines(java_density, col=pal_col[3])
text(max_x, max_y, paste0("\n", stmt_str), pos=2)
}


par(mfcol=c(3, 3))
plot_stmt("Function")
plot_stmt("If")
plot_stmt("Else")
plot_stmt("Assignment")
plot_stmt("Declaration")
plot_stmt("Break")
plot_stmt("Return")
plot_stmt("While")
plot_stmt("Switch")


