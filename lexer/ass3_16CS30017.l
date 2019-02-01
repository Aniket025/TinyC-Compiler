%{
#define KEYWORD 		10
#define	IDENTIFIER	 	11
#define	CONSTANT		12
#define STRING_LITERAL 13
#define PUNCTUATOR		14
#define CMNT 		15
%}

KEYWORD 			"auto"|"break"|"int"|"float"|"case"|"const"|"continue"|"default"|"do"|"double"|"else"|"char"|"enum"|"extern"|"for"|"goto"|"if"|"inline"|"long"|"register"|"restrict"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"_Bool"|"_Complex"|"_Imaginary"|"while"

IDENTIFIER 			{ALPHABET}({ALPHABET}|{DIGIT})*

CONSTANT 			{INTEGER_CONSTANT}|{FLOAT_CONSTANT}|{ENUMERATION_CONSTANT}|{CHARACTER_CONSTANT}
INTEGER_CONSTANT	[1-9][0-9]*
FLOAT_CONSTANT		{DIGIT}+{EXPONENTIAL_PART}|{FRACTIONAL_CONSTANT}{EXPONENTIAL_PART}|{FRACTIONAL_CONSTANT}
ENUMERATION_CONSTANT	{IDENTIFIER}
CHARACTER_CONSTANT		\'{C_CHAR_SEQUENCE}+\'
C_CHAR_SEQUENCE		{ESCAPE_SEQUENCE}|[^("\'"|"\\"|"\n")]
ESCAPE_SEQUENCE		[\\][\']|[\\][\"]|[\\][?]|[\\][\\]|[\\][a]|[\\][b]|[\\][f]|[\\][n]|[\\][r]|[\\][t]|[\\][v]
EXPONENTIAL_PART 	("e+"|"e-"|"e"){DIGIT}+
FRACTIONAL_CONSTANT 	{DIGIT}+[.]{DIGIT}*|{DIGIT}+[.]|[.]{DIGIT}+ll
DIGIT 				[0-9]
ALPHABET 				[a-zA-Z]

STRING_LITERAL 	\"{S_CHAR_SEQUENCE}+\"
S_CHAR_SEQUENCE		{ESCAPE_SEQUENCE}|[^("\""|"\\"|"\n")]

PUNCTUATOR			"["|"]"|"("|")"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"..."|","|"#"|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="

CMNT 			{SINGLELINE_CMNT}|{MULTILINE_CMNT}
SINGLELINE_CMNT		"//"[^("\n")]*
MULTILINE_CMNT	"/*"([^*]|\*+[^*/])*\*+"/"

WS 		   			[ \t\n]

%%
{KEYWORD}			{ return KEYWORD; }
{IDENTIFIER}		{ return IDENTIFIER; }
{CONSTANT} 			{ return CONSTANT; }
{STRING_LITERAL}	{ return STRING_LITERAL; }
{PUNCTUATOR}		{ return PUNCTUATOR; }
{CMNT} 			{ return CMNT; }
{WS}		{/* Ignore whitespace */}
%%
