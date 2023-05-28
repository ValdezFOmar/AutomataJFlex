// User Code (Import dependencies or declare variables)
import java_cup.runtime.Symbol;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;
%%
// Options and Declarations
%public
%class LexerCup
%cup
%line
%column
%unicode


// Code for defining atributes or methods of the class "Lexer"
%{
    ComplexSymbolFactory symbolFactory;

    // Constructor
    public LexerCup(java.io.Reader in, ComplexSymbolFactory sf) {
	    this(in);
	    symbolFactory = sf;
    }

    // Method for generating Symbol objects
    public Symbol symbol(String name, int terminalcode) {
        return symbolFactory.newSymbol(
            name,
            terminalcode,
            new Location(yyline+1,yycolumn+1)
        );
    }

    private void error(String message) {
        System.out.println("Error en linea "+(yyline+1)+", columna "+(yycolumn+1)+" : "+message);
    }
%}

%eofval{
    return symbolFactory.newSymbol(
        "EOF",
        sym.EOF,
        new Location(yyline+1,yycolumn+1)
    );
%eofval}

// --- Definitions ---
// Not keywords
SIGN = [+-]
DIGIT = [0-9]
DEC = "."{DIGIT}+
EXPO = [Ee]{SIGN}?{DIGIT}+

// Identifier
Identifier = [a-zA-Z][a-zA-Z0-9_]*

// Operators
Comparison = ("<"|">"|"=="|"!="|"<="|">=")
Arithmetic  = ("+"|"-"|"*"|"/"|"**"|"//"|"%"|"Mod")
Unary = ("++"|"--")
Assignment = "="
AssignOperation = ("+="|"-="|"*="|"/="|"**="|"//="|"%="|"&="|"|="|"^="|">>="|"<<=")
Logical = ("&&"|"||"|"and"|"or"|"AndAlso"|"OrElse"|"Xor")
Negation = ("!"|"not")
Nullish = "??"
Ternary = "?"
Identity = ("is"|"is not")
Instance = ("instanceof")
Type = ("TypeOf")
Membership = ("in"|"not in")
Bitwise = ("&"|"|"|"^"|"~"|"<<"|">>")

// Literals
Boolean = ([Tt]"rue")|([Ff]"alse")
Null = [Nn]"ull"|"None"|"Nothing"
String = \"[^\'\"]*\"
Character = \'[^\'\"\\]\'
Integer = {SIGN}?{DIGIT}+           // [+-]?[0-9]+
Decimal = {Integer}{DEC}?{EXPO}?    // ([+-]?[0-9]+)("."[0-9]+)?([Ee][+-]?[0-9]+)?
Complex = {Decimal}"i"              // ([+-]?[0-9]+)("."[0-9]+)?([Ee][+-]?[0-9]+)?"i"

// Keywords
ForLoop = ("for")
DoLoop = ("do")
WhileLoop = ("while")
Iterate = ("foreach"|"Each"|"Next")

DataTypeInt = (
    "int"|"int8"|"int16"|"int32"|"int64"|"byte"|"long"|
    "short"|"SByte"|"Single"|"UInteger"|"ULong"|"UShort"|
    "uint"|"uint8"|"uint16"|"uint32"|"uint64"
)
DataTypeDecimal = ("float"|"decimal"|"double"|"float32"|"float64")
DataTypeComplex = ("complex"|"complex64"|"complex128")
DataTypeBoolean = "boolean"
DataTypeString = "string"
DataTypeChar = "char"
DataTypeMisc = "date"|"time"|"Object"
DataStructure = ("list"|"tuple"|"dict"|"Array"|"Stack"|"Queue")
Variable = ("var"|"Let")

Conditional = ("if")
ConditionConseq = ("elif")
Consequence = ("else")
Switch = ("switch")
Case = ("case")
Default = ("default")
Function = ("def"|"PROCEDURE"|"Sub"|"func")
Lambda = ("lambda")
Void = ("void")
Execute = ("EXEC"|"Call")
Try = ("try"|"assert"|"with")
TryConsequence = ("finally"|"Resume"|"Then")
Exception = ("throw"|"raise"|"catch"|"except"|"Error"|"RaiseEvent")

LineComment = ("#")
StartComment = ("/*")
EndComment = ("*/")
SpecialComment = ("TODO"|"FIXME"|"REM")

AccesMod = (
    "nonlocal"|"global"|"public"|"private"|
    "protected"|"Shared"
)
NonAccesMod = (
    "ReadOnly"|"const"|"final"|"abstract"|"static"|
    "transient"|"synchronized"|"volatile"|"MustInherit"|
    "MustOverride"|"Overridable"|"Overrides"
)

ParIzq = "("
ParDer = ")"
LlaveIzq = "{"
LlaveDer = "}"
CorIzq = "["
CorDer = "]"
Point = "."
Comma = ","
Colon = ":"
SemiColon = ";"

Class = ("class")
Parent = ("super"|"MyBase")
Interface = ("interface")
Enum = ("enum")
Extends = ("extends")
Implements = ("implements")
Break = ("break"|"End"|"Exit")
Continue = ("continue")
Pass = ("pass")
Import = ("import"|"requires"|"native"|"Using")
From = ("from")
Return = ("return"|"yield")
Create = ("new"|"CREATE")
Delete = ("del"|"DELETE"|"DROP"|"TRUNCATE"|"Erase"|"RemoveHandler")
This = ("this"|"self")
Reference = ("throws"|"AddressOf"|"Delegate"|"Lib"|"Me"|"MyClass")
Alias = ("as"|"Alias")
Asynchronous = ("await"|"async")
Package = ("package")
Print = ("print")

// VisualBasic
Handler = ("AddHandler"|"Handles")
Modifier = (
    "ByRef"|"ByVal"|"strictfp"|"Friend"|"NotInheritable"|"NotOverridable"|
    "Optional"|"Out"|"Overloads"|"WithEvents"|"WriteOnly"
)
Storage = ("Dim"|"ReDim")
Cast = (
    "DirectCast"|"CBool"|"CByte"|"CChar"|"CDate"|"CDbl"|"CDec"|"CInt"|
    "CLng"|"CObj"|"CSByte"|"CShort"|"CSng"|"CStr"|"CUInt"|"CULng"|
    "CUShort"|"Narrowing"|"TryCast"|"Widening"
)
Event = ("Event")
Get = ("Get"|"GetType"|"GetXmlNamespace"|"NameOf")
GoTo = ("GoTo")
Module = ("Module")
Namespace = ("Namespace")
Of = ("Of")
Operator = ("Operator")
Option = ("Option")
Partial = ("Partial")
Increment = ("Step")
Debug = ("Stop")
Structure = ("Structure")

// SQL Keywords
Add = ("ADD"|"ADD CONSTRAINT")
Constraint = ("CHECK"|"CONSTRAINT"|"FOREIGN KEY"|"PRIMARY KEY"|"UNIQUE")
ConditionalQuery = ("HAVING"|"WHERE")
QueryConditions = ("ALL"|"ANY"|"EXISTS"|"LIKE")
Alter = ("ALTER")
Insert = ("INSERT"|"INTO"|"VALUES")
Sort = ("ASC"|"DESC"|"GROUP BY"|"ORDER BY")
Backup = ("BACKUP")
Range = ("BETWEEN")
View = ("VIEW")
Column = ("COLUMN")
Table = ("TABLE")
Database = ("DATABASE")
Select = ("SELECT")
Join = (
    "JOIN"|"FULL OUTER JOIN"|"INNER JOIN"|
    "LEFT JOIN"|"OUTER JOIN"|"RIGHT JOIN"
)
Index = ("INDEX")
Limit = ("LIMIT"|"ROWNUM"|"TOP"|"DISTINCT")
Update = ("UPDATE"|"SET")
Union = ("UNION"|"UNION ALL")

%%
// Lexical Rules
// Operators
{Comparison}        {return symbol(yytext(), sym.COMPARISON);}
{Arithmetic}        {return symbol(yytext(), sym.ARITHMETIC);}
{Unary}             {return symbol(yytext(), sym.UNARY);}
{Assignment}        {return symbol(yytext(), sym.ASSIGNMENT);}
{AssignOperation}   {return symbol(yytext(), sym.ASSIGN_OPT);}
{Logical}           {return symbol(yytext(), sym.LOGICAL);}
{Negation}          {return symbol(yytext(), sym.NEGATION);}
{Nullish}           {return symbol(yytext(), sym.NULLISH);}
{Ternary}           {return symbol(yytext(), sym.TERNARY);}
{Identity}          {return symbol(yytext(), sym.IDENTITY);}
{Instance}          {return symbol(yytext(), sym.INSTANCE);}
{Type}              {return symbol(yytext(), sym.TYPE);}
{Membership}        {return symbol(yytext(), sym.MEMBERSHIP);}
{Bitwise}           {return symbol(yytext(), sym.BITWISE);}

// Literals
{Boolean}           {return symbol(yytext(), sym.BOOLEAN);}
{Null}              {return symbol(yytext(), sym.NULL);}
{String}            {return symbol(yytext(), sym.STRING);}
{Character}         {return symbol(yytext(), sym.CHARACTER);}
{Integer}           {return symbol(yytext(), sym.INTEGER);}
{Decimal}           {return symbol(yytext(), sym.DECIMAL);}
{Complex}           {return symbol(yytext(), sym.COMPLEX);}

// Loops
{ForLoop}           {return symbol(yytext(), sym.FOR_LOOP);}
{DoLoop}            {return symbol(yytext(), sym.DO_LOOP);}
{WhileLoop}         {return symbol(yytext(), sym.WHILE_LOOP);}
{Iterate}           {return symbol(yytext(), sym.ITERATE);}

// Variables
{DataTypeInt}       {return symbol(yytext(), sym.DATATYPE_INT);}
{DataTypeDecimal}   {return symbol(yytext(), sym.DATATYPE_DECIMAL);}
{DataTypeComplex}   {return symbol(yytext(), sym.DATATYPE_COMPLEX);}
{DataTypeBoolean}   {return symbol(yytext(), sym.DATATYPE_BOOL);}
{DataTypeString}    {return symbol(yytext(), sym.DATATYPE_STRING);}
{DataTypeChar}      {return symbol(yytext(), sym.DATATYPE_CHAR);}
{DataTypeMisc}      {return symbol(yytext(), sym.DATATYPE_MISC);}
{DataStructure}     {return symbol(yytext(), sym.DATA_STRUCTURE);}
{Variable}          {return symbol(yytext(), sym.VARIABLE);}

// Conditionals
{Conditional}       {return symbol(yytext(), sym.IF);}
{ConditionConseq}   {return symbol(yytext(), sym.ELIF);}
{Consequence}       {return symbol(yytext(), sym.ELSE);}
{Switch}            {return symbol(yytext(), sym.SWITCH);}
{Case}              {return symbol(yytext(), sym.CASE);}
{Default}           {return symbol(yytext(), sym.DEFAULT);}

// Functions and Modifiers 
{Function}          {return symbol(yytext(), sym.FUNCTION);}
{Void}              {return symbol(yytext(), sym.VOID);}
{Lambda}            {return symbol(yytext(), sym.LAMBDA);}
{Execute}           {return symbol(yytext(), sym.EXECUTE);}
{Try}               {return symbol(yytext(), sym.TRY);}
{TryConsequence}    {return symbol(yytext(), sym.TRY_CONSEQUENCE);}
{Exception}         {return symbol(yytext(), sym.EXCEPTION);}

// Comments
{LineComment}       {return symbol(yytext(), sym.LINE_COMMENT);}
{StartComment}      {return symbol(yytext(), sym.START_COMMENT);}
{EndComment}        {return symbol(yytext(), sym.END_COMMENT);}
{SpecialComment}    {return symbol(yytext(), sym.SPECIAL_COMMENT);}

// Modifiers
{AccesMod}          {return symbol(yytext(), sym.ACCESMOD);}
{NonAccesMod}       {return symbol(yytext(), sym.NONACCESMOD);}

// Separators
{ParIzq}            {return symbol(yytext(), sym.PAR_IZQ);}
{ParDer}            {return symbol(yytext(), sym.PAR_DER);}
{LlaveIzq}          {return symbol(yytext(), sym.LLAVE_IZQ);}
{LlaveDer}          {return symbol(yytext(), sym.LLAVE_DER);}
{CorIzq}            {return symbol(yytext(), sym.COR_IZQ);}
{CorDer}            {return symbol(yytext(), sym.COR_DER);}
{Point}             {return symbol(yytext(), sym.POINT);}
{Comma}             {return symbol(yytext(), sym.COMMA);}
{Colon}             {return symbol(yytext(), sym.COLON);}
{SemiColon}         {return symbol(yytext(), sym.SEMI);}

// Misc
{Class}             {return symbol(yytext(), sym.CLASS);}
{Parent}            {return symbol(yytext(), sym.PARENT);}
{Interface}         {return symbol(yytext(), sym.INTERFACE);}
{Enum}              {return symbol(yytext(), sym.ENUM);}
{Extends}           {return symbol(yytext(), sym.EXTENDS);}
{Implements}        {return symbol(yytext(), sym.IMPLEMENTS);}
{Break}             {return symbol(yytext(), sym.BREAK);}
{Continue}          {return symbol(yytext(), sym.CONTINUE);}
{Pass}              {return symbol(yytext(), sym.PASS);}
{Import}            {return symbol(yytext(), sym.IMPORT);}
{From}              {return symbol(yytext(), sym.FROM);}
{Return}            {return symbol(yytext(), sym.RETURN);}
{Create}            {return symbol(yytext(), sym.CREATE);}
{Delete}            {return symbol(yytext(), sym.DELETE);}
{This}              {return symbol(yytext(), sym.THIS);}
{Reference}         {return symbol(yytext(), sym.REFERENCE);}
{Alias}             {return symbol(yytext(), sym.ALIAS);}
{Asynchronous}      {return symbol(yytext(), sym.ASYNCHRONOUS);}
{Package}           {return symbol(yytext(), sym.PACKAGE);}
{Print}             {return symbol(yytext(), sym.PRINT);}

// Visual Basic
{Handler}           {return symbol(yytext(), sym.HANDLER);}
{Modifier}          {return symbol(yytext(), sym.MODIFIER);}
{Storage}           {return symbol(yytext(), sym.STORAGE);}
{Cast}              {return symbol(yytext(), sym.CAST);}
{Event}             {return symbol(yytext(), sym.EVENT);}
{Get}               {return symbol(yytext(), sym.GET);}
{GoTo}              {return symbol(yytext(), sym.GOTO);}
{Module}            {return symbol(yytext(), sym.MODULE);}
{Namespace}         {return symbol(yytext(), sym.NAMESPACE);}
{Of}                {return symbol(yytext(), sym.OF);}
{Operator}          {return symbol(yytext(), sym.OPERATOR);}
{Option}            {return symbol(yytext(), sym.OPTION);}
{Partial}           {return symbol(yytext(), sym.PARTIAL);}
{Increment}         {return symbol(yytext(), sym.INCREMENT);}
{Debug}             {return symbol(yytext(), sym.DEBUG);}
{Structure}         {return symbol(yytext(), sym.STRUCTURE);}

// SQL
{Add}               {return symbol(yytext(), sym.ADD);}
{Constraint}        {return symbol(yytext(), sym.CONSTRAINT);}
{ConditionalQuery}  {return symbol(yytext(), sym.CONDITIONALQUERY);}
{QueryConditions}   {return symbol(yytext(), sym.QUERY_CONDITIONS);}
{Alter}             {return symbol(yytext(), sym.ALTER);}
{Insert}            {return symbol(yytext(), sym.INSERT);}
{Sort}              {return symbol(yytext(), sym.SORT);}
{Backup}            {return symbol(yytext(), sym.BACKUP);}
{Range}             {return symbol(yytext(), sym.RANGE);}
{View}              {return symbol(yytext(), sym.VIEW);}
{Column}            {return symbol(yytext(), sym.COLUMN);}
{Table}             {return symbol(yytext(), sym.TABLE);}
{Database}          {return symbol(yytext(), sym.DATABASE);}
{Select}            {return symbol(yytext(), sym.SELECT);}
{Join}              {return symbol(yytext(), sym.JOIN);}
{Index}             {return symbol(yytext(), sym.INDEX);}
{Limit}             {return symbol(yytext(), sym.LIMIT);}
{Update}            {return symbol(yytext(), sym.UPDATE);}
{Union}             {return symbol(yytext(), sym.UNION);}

{Identifier}        {return symbol(yytext(), sym.ID);}
//{}{return symbol(yytext(), sym.);}, yytext()

[\s\t\n\r]          {/* Ignore space, tab, new line and carriage return characters */}
[^]                 { /* throw new Error("Illegal character <"+yytext()+">"); */
                        error("Illegal character <"+ yytext()+">");
                    }