%option noyywrap

%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	int lineno = 1; // initialize to 1
	void ret_print(char *token_type);
	void yyerror();
%}

%x ML_COMMENT

alpha 		[a-zA-Z]
digit 		[0-9]
alnum 		{alpha}|{digit}
print		[ -~]

IDENTIFIER 			{alpha}+{alnum}*
INTEGERCONSTANT		"0"|[0-9]{digit}*
FLOATCONSTANT		"0"|{digit}*"."{digit}+
CCONST		(\'{print}\')|(\'\\[nftrbv]\')
STRING		\"{print}*\"

%%

"//".*					{ printf("Single Line  comment %d\n", lineno); } 

"/*"					{ printf("Multiline comment from line %d ", lineno); BEGIN(ML_COMMENT); }
<ML_COMMENT>"*/" 		{ printf("to line %d\n", lineno); BEGIN(INITIAL); }
<ML_COMMENT>[^*\n]+		
<ML_COMMENT>"*"			
<ML_COMMENT>"\n"		{ lineno += 1; }


"char"|"CHAR"       	{ ret_print("KEYWORD_CHAR"); }
"int"|"INT"				{ ret_print("KEYWORD_INT"); }
"float"|"FLOAT"			{ ret_print("KEYWORD_FLOAT"); }
"double"|"DOUBLE"		{ ret_print("KEYWORD_DOUBLE"); }
"if"|"IF"				{ ret_print("KEYWORD_IF"); }
"else"|"ELSE"			{ ret_print("KEYWORD_ELSE"); }
"while"|"WHILE"			{ ret_print("KEYWORD_WHILE"); }
"for"|"FOR"				{ ret_print("KEYWORD_FOR"); }
"continue"|"CONTINUE"	{ ret_print("KEYWORD_CONTINUE"); }
"break"|"BREAK"			{ ret_print("KEYWORD_BREAK"); }
"void"|"VOID"			{ ret_print("KEYWORD_VOID"); }
"return"|"RETURN"		{ ret_print("KEYWORD_RETURN"); }


"+"					    { ret_print("ADDITION OPERATOR"); }
"-"				        { ret_print("SUBTRACTION OPERATOR"); }
"*"						{ ret_print("MULTIPLICATION OPERATOR"); }
"/"						{ ret_print("DIVISION OPERATOR"); }
"++"				    { ret_print("INCREMENT"); }
"--"				    { ret_print("DECREMENT"); }
"||"					{ ret_print("OR OPERATOR"); }
"&&"					{ ret_print("AND OPERATOR"); }
"!"						{ ret_print("NOT OPERATOR"); }
"=="				    { ret_print("EQUALS TO OPERATOR"); }
"!="				    { ret_print("NOT EQUALS TO OPERATOR"); }
">"|"<"|">="|"<="		{ ret_print("RELATIONAL OPERATORS"); }


"("				{ ret_print("LEFT PARENTHESIS"); }
")"				{ ret_print("RIGHT PARENTHESIS"); }
"]"				{ ret_print("LEFT BRACK"); }
"["				{ ret_print("RIGHT BRACK"); }
"{"				{ ret_print("LEFT BRACE"); }
"}"				{ ret_print("RIGHT BRACE"); }
";"				{ ret_print("SEMI COLON"); }
":"				{ ret_print("COLON"); }
"."				{ ret_print("DOT"); }
","				{ ret_print("COMMA"); }
"="				{ ret_print("ASSIGNMENT"); }
"&"				{ ret_print("REFER"); }
"#"				{ ret_print("PRE-PROCESSOR"); }



{IDENTIFIER} 	{ ret_print("IDENTIFIER"); }
{INTEGERCONSTANT} { ret_print("INTEGER CONSTANT"); }
{FLOATCONSTANT} 	{ ret_print("FLOAT CONSTANT"); }
{CCONST} 		{ ret_print("CCONST"); }
{STRING} 		{ ret_print("STRING"); }


"\n"			{ lineno += 1; }
[ \t\r\f]+			/* Whitespace */

.				{ yyerror("Unrecognized character"); }

%%

void ret_print(char *token_type){
	printf("yytext: %s\ttoken: %s\tlineno: %d\n", yytext, token_type, lineno);
}

void yyerror(char *message){
	printf("Error: \"%s\" in line %d. Token = %s\n", message, lineno, yytext);
	exit(1);
}

int main(int argc, char *argv[]){
    printf("Type or paste code here or run the exe attaching a file in the same directory\n");
	yyin = fopen(argv[1], "r");
	yylex();
	fclose(yyin);
	return 0;
}