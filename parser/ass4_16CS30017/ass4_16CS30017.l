%{
#include "y.tab.h"
#include <math.h>
extern void yyerror(const char *);  /* prints grammar violation message */
void count(void);
%}

/* Definitions */

CONSTANT {IC}|{FC}|{EC}|{CC}

NZ_DIGIT [1-9]
/* Non Zero Digit */

DIGIT [0-9]
/* Digit */

DIGIT_SEQ ({DIGIT}+)
/* Digit Sequence */

NIC ({NZ_DIGIT}({DIGIT})*)
 /* Non Zero integer Constant */

IC ({NIC}|[0])
  /* Integer Constant */
sign [+-]
 /* Sign */

E ([eE]{sign}?{DIGIT_SEQ})
/* Exponential Part */

FRACTIONAL_CONSTANT (({DIGIT_SEQ}?[\.]{DIGIT_SEQ})|({DIGIT_SEQ}[\.]))
/* Fractional Constant */

FC (({FRACTIONAL_CONSTANT}{E}?)|{DIGIT_SEQ}{E})
/*Floating point constant */

ALPHABET [a-zA-Z_]
/* Identifier Non Digit */

ID {ALPHABET}({ALPHABET}|{DIGIT})*
/* Identifier Identifier non digit */

EC 		{ID}
ESC_SEQ		\\['"?\\abfnrtv]
cchar 		[^'\\\n]|{ESC_SEQ}
CC 		'({cchar})+'
schar 		[^"\\\n]|{ESC_SEQ}
SC 		\"({schar}+)\"
WS  		[ \t\v\n\f]
SINGLELINE_COMMENT  \/\/.*
MULTILINE_COMMENT	\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*\/

%%

"auto"			{ return AUTO; }
"break"         	{ return BREAK; }
"case"          	{ return CASE; }
"char"          	{ return CHAR; }
"const"         	{ return CONST; }
"continue"      	{ return CONTINUE; }
"default"       	{ return DEFAULT; }
"do"            	{ return DO; }
"double"        	{ return DOUBLE; }
"else"          	{ return ELSE; }
"enum"          	{ return ENUM; }
"extern"        	{ return EXTERN; }
"float"         	{ return FLOAT; }
"for"           	{ return FOR; }
"goto"          	{ return GOTO; }
"if"            	{ return IF; }
"inline"        	{ return INLINE; }
"int"           	{ return INT; }
"long"          	{ return LONG; }
"register"      	{ return REGISTER; }
"restrict"      	{ return RESTRICT; }
"return"        	{ return RETURN; }
"short"         	{ return SHORT; }
"signed"        	{ return SIGNED; }
"sizeof"        	{ return SIZEOF; }
"static"        	{ return STATIC; }
"struct"        	{ return STRUCT; }
"switch"        	{ return SWITCH; }
"typedef"       	{ return TYPEDEF; }
"union"         	{ return UNION; }
"unsigned"      	{ return UNSIGNED; }
"void"          	{ return VOID; }
"volatile"      	{ return VOLATILE; }
"while"        	        { return WHILE; }
"_Bool"         	{ return _BOOL; }
"_Complex"     		{ return _COMPLEX; }
"_Imaginary"    	{ return _IMAGINARY; }

{SC} 			{ return STRING_LITERAL; }
{ID}			{ return IDENTIFIER; }
{IC} 			{ return INT_CONSTANT; }
{FC} 			{ return FLOAT_CONSTANT; }
{EC} 			{ return ENU_CONSTANT; }
{CC} 			{ return CHAR_CONSTANT; }

"["			{ return '['; }
"]"			{ return ']'; }
"("			{ return '('; }
")"			{ return ')'; }
"{"			{ return '{'; }
"}"			{ return '}'; }
"."			{ return '.'; }
"->"			{ return PTR_OP; }
"++"			{ return INC_OP; }
"--"			{ return DEC_OP; }
"&"			{ return '&'; }
"*"			{ return '*'; }
"+"			{ return '+'; }
"-"			{ return '-'; }
"~"			{ return '~'; }
"!"			{ return '!'; }
"/"			{ return '/'; }
"%"			{ return '%'; }
"<<"			{ return LEFT_OP; }
">>"			{ return RIGHT_OP; }
"<"			{ return '<'; }
">"			{ return '>'; }
"<="			{ return LE_OP; }
">="			{ return GE_OP; }
"=="			{ return EQ_OP; }
"!="			{ return NE_OP; }
"^"			{ return '^'; }
"|"			{ return '|'; }
"&&"			{ return AND_OP; }
"||"			{ return OR_OP; }

"?"			{ return '?'; }
":"			{ return ':'; }
";"			{ return ';'; }
"..."			{ return ELLIPSIS; }
"="			{ return '='; }

"*="			{ return MUL_ASSIGN; }
"/="			{ return DIV_ASSIGN; }
"%="			{ return MOD_ASSIGN; }
"+="			{ return ADD_ASSIGN; }
"-="			{ return SUB_ASSIGN; }
"<<="			{ return LEFT_ASSIGN; }
">>="			{ return RIGHT_ASSIGN; }
"&="			{ return AND_ASSIGN; }
"^="			{ return XOR_ASSIGN; }
"|="			{ return OR_ASSIGN; }

","			{ return ','; }
"#"			{ return '#'; }
{SINGLELINE_COMMENT}    {}
{MULTILINE_COMMENT}	{}
{WS}			{}

%%
int column = 0;
void count(void) {
	int i;
	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n') column = 0;
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;
	ECHO;
}
