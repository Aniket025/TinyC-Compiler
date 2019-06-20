%{ /* C Declarations and Definitions */
	#include <string.h>
	#include <stdio.h>

	extern int yylex();
	void yyerror(char *s);
%}

%union {
int intval;
}

%token TYPEDEF EXTERN STATIC AUTO REGISTER INLINE RESTRICT
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token _BOOL _COMPLEX _IMAGINARY
%token STRUCT UNION ENUM
%token BREAK CASE CONTINUE DEFAULT DO IF ELSE FOR GOTO WHILE SWITCH SIZEOF
%token RETURN

%token ELLIPSIS RIGHT_ASSIGN LEFT_ASSIGN ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN
%token DIV_ASSIGN MOD_ASSIGN AND_ASSIGN XOR_ASSIGN OR_ASSIGN RIGHT_OP LEFT_OP
%token INC_OP DEC_OP PTR_OP AND_OP OR_OP LE_OP GE_OP EQ_OP NE_OP

%token IDENTIFIER STRING_LITERAL PUNCTUATORS COMMENT
%token INT_CONSTANT FLOAT_CONSTANT ENU_CONSTANT CHAR_CONSTANT

%start translation_unit

%%

primary_expression
	: IDENTIFIER
	| constant
	| STRING_LITERAL
	| '(' expression ')'
	{printf("Primary Expression\n");}
	;

constant
	: INT_CONSTANT
	| FLOAT_CONSTANT
	| ENU_CONSTANT
	| CHAR_CONSTANT
	;

postfix_expression
	: primary_expression
	| postfix_expression '[' expression ']'
	| postfix_expression '(' ')'
	| postfix_expression '(' argument_expression_list ')'
	| postfix_expression '.' IDENTIFIER
	| postfix_expression PTR_OP IDENTIFIER
	| postfix_expression INC_OP
	| postfix_expression DEC_OP
	| '(' type_name ')' '{' initializer_list '}'
	|  '(' type_name ')' '{' initializer_list ',' '}'
	{printf("Postfix Expression\n");}
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	{printf("Argument Expression List \n");}
	;

unary_expression
	: postfix_expression
	| INC_OP unary_expression
	| DEC_OP unary_expression
	| unary_operator cast_expression
	| SIZEOF unary_expression
	| SIZEOF '(' type_name ')'
	{printf("Unary Expression \n");}
	;

unary_operator
	: '&'
	| '*'
	| '+'
	| '-'
	| '~'
	| '!'
	{printf("Unary Operator\n");}
	;

cast_expression
	: unary_expression
	| '(' type_name ')' cast_expression
	{printf("Cast Expression\n");}
	;

multiplicative_expression
	: cast_expression
	| multiplicative_expression '*' cast_expression
	| multiplicative_expression '/' cast_expression
	| multiplicative_expression '%' cast_expression
	{printf("Multiplicative Expression\n");}
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression
	| additive_expression '-' multiplicative_expression
	{printf("Additive Expression\n");}
	;

shift_expression
	: additive_expression
	| shift_expression LEFT_OP additive_expression
	| shift_expression RIGHT_OP additive_expression
	{printf("Shift Expression\n");}
	;

relational_expression
	: shift_expression
	| relational_expression '<' shift_expression
	| relational_expression '>' shift_expression
	| relational_expression LE_OP shift_expression
	| relational_expression GE_OP shift_expression
	{printf("Relational Expression\n");}
	;

equality_expression
	: relational_expression
	| equality_expression EQ_OP relational_expression
	| equality_expression NE_OP relational_expression
	{printf("Equality Expression\n");}
	;

and_expression
	: equality_expression
	| and_expression '&' equality_expression
	{printf("Expression : And\n");}
	;

exclusive_or_expression
	: and_expression
	| exclusive_or_expression '^' and_expression
	{printf("Expression : Exclusive or\n");}
	;

inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression '|' exclusive_or_expression
	{printf("Expression : Inclusive Or \n");}
	;

logical_and_expression
	: inclusive_or_expression
	| logical_and_expression AND_OP inclusive_or_expression
	{printf("Expression : Logical AND \n");}
	;

logical_or_expression
	: logical_and_expression
	| logical_or_expression OR_OP logical_and_expression
	{printf("Expression : Logical OR \n");}
	;

conditional_expression
	: logical_or_expression
	| logical_or_expression '?' expression ':' conditional_expression
	{printf("Conditional Expression\n");}
	;

assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression
	{printf("Assignment Expression\n");}
	;

assignment_operator
	: '='
	{printf("Assignment Operator\n");}
	| MUL_ASSIGN
	| DIV_ASSIGN
	| MOD_ASSIGN
	| ADD_ASSIGN
	| SUB_ASSIGN
	| LEFT_ASSIGN
	| RIGHT_ASSIGN
	| AND_ASSIGN
	| XOR_ASSIGN
	| OR_ASSIGN
	{printf("Assignment Operator\n");}
	;

expression
	: assignment_expression
	| expression ',' assignment_expression
	{printf("Expression\n");}
	;

constant_expression
	: conditional_expression
	{printf("Constant expression\n");}
	;

declaration
	: declaration_specifiers ';'
	| declaration_specifiers init_declarator_list ';'
	{printf("Declaration\n");}
	;

declaration_specifiers
	: storage_class_specifier
	| storage_class_specifier declaration_specifiers
	| type_specifier
	| type_specifier declaration_specifiers
	| type_qualifier
	| type_qualifier declaration_specifiers
	| function_specifier
	| function_specifier declaration_specifiers
	{printf(" Declaration_specifiers \n");}
	;

init_declarator_list
	: init_declarator
	| init_declarator_list ',' init_declarator
	{printf("Init_Declarator List\n");}
	;

init_declarator
	: declarator
	| declarator '=' initializer
	{printf("Init_Declarator\n");}
	;

storage_class_specifier
	: EXTERN
	| STATIC
	| AUTO
	| REGISTER
	{printf("Storage class specifier\n");}
	;

type_specifier
	: VOID
	| CHAR
	| SHORT
	| INT
	| LONG
	| FLOAT
	| DOUBLE
	| SIGNED
	| UNSIGNED
	| _BOOL
	| _COMPLEX
	| _IMAGINARY
	| enum_specifier
	{printf("Type specifier\n");}
	;



specifier_qualifier_list
	: type_specifier specifier_qualifier_list
	| type_specifier
	| type_qualifier specifier_qualifier_list
	| type_qualifier
	{printf("Specifier_Qualifier_List\n");}
	;


enum_specifier
	: ENUM '{' enumerator_list '}'
	| ENUM IDENTIFIER '{' enumerator_list '}'
	| ENUM '{' enumerator_list ',' '}'
	| ENUM IDENTIFIER '{' enumerator_list ',' '}'
	| ENUM IDENTIFIER
	{printf("Enum specifier\n");}
	;

enumerator_list
	: enumerator
	| enumerator_list ',' enumerator
	{printf("Enumerator list\n");}
	;

enumerator
	: IDENTIFIER
	| IDENTIFIER '=' constant_expression
	{printf("Enumerator\n");}
	;

type_qualifier
	: CONST
	| VOLATILE
	| RESTRICT
	{printf("Type qualifier\n");}
	;
function_specifier
	: INLINE
	{printf("Function Specifier\n");}
	;
declarator
	: pointer direct_declarator
	| direct_declarator
	{printf("Declarator\n");}
	;

direct_declarator
	: IDENTIFIER
	| '(' declarator ')'
	| direct_declarator '['  type_qualifier_list_opt assignment_expression_opt ']'
	| direct_declarator '[' STATIC type_qualifier_list_opt assignment_expression ']'
	| direct_declarator '[' type_qualifier_list_opt '*' ']'
	| direct_declarator '(' parameter_type_list ')'
	| direct_declarator '(' identifier_list ')'
	| direct_declarator '(' ')'
	{printf("Direct Declarator\n");}
	;

type_qualifier_list_opt
	: %empty
	| type_qualifier_list
	{printf("Type_qualifier_list_optional \n");}
	;
assignment_expression_opt
	: %empty
	| assignment_expression
	{printf("Assignment_expression_optional \n");}
	;

pointer
	: '*'
	| '*' type_qualifier_list
	| '*' pointer
	| '*' type_qualifier_list pointer
	{printf("Pointer\n");}
	;

type_qualifier_list
	: type_qualifier
	| type_qualifier_list type_qualifier
	{printf("Type_qualifier_list\n");}
	;


parameter_type_list
	: parameter_list
	| parameter_list ',' ELLIPSIS
	{printf("parameter_type_list\n");}
	;

parameter_list
	: parameter_declaration
	| parameter_list ',' parameter_declaration
	{printf("Parameter_list\n");}
	;

parameter_declaration
	: declaration_specifiers declarator
	| declaration_specifiers
	{printf("Parameter-Declaration\n");}
	;

identifier_list
	: IDENTIFIER
	| identifier_list ',' IDENTIFIER
	{printf("Identifier List\n");}
	;

type_name
	: specifier_qualifier_list
	{printf("Type name \n");}
	;




initializer
	: assignment_expression
	| '{' initializer_list '}'
	| '{' initializer_list ',' '}'
	{printf("Initializer\n");}
	;

initializer_list
	: initializer
	| designation initializer
	| initializer_list ',' initializer
	|  initializer_list ',' designation initializer
	{printf("Initializer-List\n");}
	;

designation
	: designator_list '='
	{printf("Designation\n");}
	;

designator_list
	: designator
	| designator_list designator
	{printf("Designator_list\n");}
	;

designator
	: '[' constant_expression ']'
	| '.' IDENTIFIER
	{printf("Designator\n");}
	;

statement
	: labeled_statement
	| compound_statement
	| expression_statement
	| selection_statement
	| iteration_statement
	| jump_statement
	{printf("Statement\n");}
	;

labeled_statement
	: IDENTIFIER ':' statement
	| CASE constant_expression ':' statement
	| DEFAULT ':' statement
	{printf("Labeled Statement\n");}
	;

compound_statement
	: '{' '}'
	| '{' block_item_list '}'
	{printf("Compound Statement\n");}
	;

block_item_list
	: block_item
	| block_item_list block_item
	{printf("Block item list\n");}
	;

block_item
	: declaration
	| statement
	{printf("Block_item\n");}
	;


expression_statement
	: ';'
	| expression ';'
	{printf("Expression-statement\n");}
	;

selection_statement
	: IF '(' expression ')' statement
	| IF '(' expression ')' statement ELSE statement
	| SWITCH '(' expression ')' statement
	{printf("Selection-statement\n");}
	;

iteration_statement
	: WHILE '(' expression ')' statement
	| DO statement WHILE '(' expression ')' ';'
	| FOR '(' expression_statement expression_statement ')' statement
	| FOR '(' expression_statement expression_statement expression ')' statement
	{printf("Iteration-statement\n");}
	;

jump_statement
	: GOTO IDENTIFIER ';'
	| CONTINUE ';'
	| BREAK ';'
	| RETURN ';'
	| RETURN expression ';'

	{printf("Jump-statement\n");}
	;

translation_unit
	: external_declaration
	| translation_unit external_declaration
	{printf("Translation - unit\n");}
	;

external_declaration
	: function_definition
	| declaration
	{printf("External declaration\n");}
	;

function_definition
	: declaration_specifiers declarator declaration_list compound_statement
	| declaration_specifiers declarator compound_statement
	| declarator declaration_list compound_statement
	| declarator compound_statement
	{printf("Function definition\n");}
	;
declaration_list
	: declaration
	| declaration_list declaration
	{printf("Declaration list\n");}
	;

%%
void yyerror(char *s) {
	printf ("\n FOUND ERROR: %s\n",s);
}
