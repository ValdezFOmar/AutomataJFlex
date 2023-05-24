// User Code (Import dependencies or declare variables)
import java_cup.runtime.Symbol;
%%
// Options and Declarations
%public
%class LexerCup
%function nextToken
%type Symbol
%line
%column
%unicode
%cup

// Code for defining atributes a methods of the class "Lexer"
%{  
    public boolean thereIsTokens() {return this._thereIsTokens;}

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value)
    }

    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn)
    }
%}

// Execute at the end of file
%eof{
    this._thereIsTokens = false;
%eof}

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
Assignment = ("="|"+="|"-="|"*="|"/="|"**="|"//="|"%="|"&="|"|="|"^="|">>="|"<<=")
Logical = ("&&"|"||"|"and"|"or"|"not"|"AndAlso"|"OrElse"|"Xor")
Negation = "!"
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
Character = \'[^\'\"\\]?\'
Integer = {SIGN}?{DIGIT}+           // [+-]?[0-9]+
Decimal = {Integer}{DEC}?{EXPO}?    // ([+-]?[0-9]+)("."[0-9]+)?([Ee][+-]?[0-9]+)?
Complex = {Decimal}"i"              // ([+-]?[0-9]+)("."[0-9]+)?([Ee][+-]?[0-9]+)?"i"

// Keywords
ForLoop = ("for")
DoLoop = ("do")
WhileLoop = ("while")
Iterate = ("foreach"|"Each"|"Next")
DataType = (
    "int"|"int8"|"int16"|"int32"|"int64"|"string"|"boolean"|
    "float"|"decimal"|"date"|"char"|"byte"|"complex"|"long"|
    "short"|"double"|"time"|"Object"|"SByte"|"Single"|"UInteger"|
    "ULong"|"UShort"|"uint"|"uint8"|"uint16"|"uint32"|"uint64"|
    "float32"|"float64"|"complex64"|"complex128"
)
DataStructure = ("list"|"tuple"|"dict"|"Array"|"Stack"|"Queue")
Variable = ("var"|"Let")
Conditional = ("if")
ConditionalConsequence = ("elif")
Switch = ("switch")
Case = ("case") 
Consequence = ("else")
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
    "protected"|"default"|"Shared"
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
Importing = ("import"|"from"|"requires"|"native"|"Using")
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
{Comparison}    {return ;}
{Arithmetic}    {return ;}
{Unary}         {return ;}
{Assignment}    {return ;}
{Logical}       {return ;}
{Negation}      {return ;}
{Nullish}       {return ;}
{Ternary}       {return ;}
{Identity}      {return ;}
{Instance}      {return ;}
{Type}          {return ;}
{Membership}    {return ;}
{Bitwise}       {return ;}

{Boolean}       {return ;}
{Null}          {return ;}
{String}        {return ;}
{Character}     {return ;}
{Integer}       {return ;}
{Decimal}       {return ;}
{Complex}       {return ;}

{ForLoop}       {return ;}
{DoLoop}        {return ;}
{WhileLoop}     {return ;}
{Iterate}       {return ;}

{DataType}      {return ;}
{DataStructure} {return ;}
{Variable}      {return ;}

{Conditional}   {return ;}
{ConditionalConsequence}    {return ;}
{Consequence}   {return ;}
{Switch}        {return ;}
{Case}          {return ;}

{Function}      {return ;}
{Void}          {return ;}
{Lambda}        {return ;}
{Execute}       {return ;}
{Try}           {return ;}
{TryConsequence}    {return ;}
{Exception}     {return ;}

{LineComment}   {return ;}
{StartComment}  {return ;}
{EndComment}    {return ;}
{SpecialComment}    {return ;}

{AccesMod}      {return ;}
{NonAccesMod}   {return ;}
{ParIzq}        {return ;}
{ParDer}        {return ;}
{LlaveIzq}      {return ;}
{LlaveDer}      {return ;}
{CorIzq}        {return ;}
{CorDer}        {return ;}
{Point}         {return ;}
{Comma}         {return ;}
{Colon}         {return ;}
{SemiColon}     {return ;}
{Class}         {return ;}
{Parent}        {return ;}
{Interface}     {return ;}
{Enum}          {return ;}
{Extends}       {return ;}
{Implements}    {return ;}
{Break}         {return ;}
{Continue}      {return ;}
{Pass}          {return ;}
{Importing}     {return ;}
{Return}        {return ;}
{Create}        {return ;}
{Delete}        {return ;}
{This}          {return ;}
{Reference}     {return ;}
{Alias}         {return ;}
{Asynchronous}  {return ;}
{Package}       {return ;}
{Print}         {return ;}

{Handler}       {return ;}
{Modifier}      {return ;}
{Storage}       {return ;}
{Cast}          {return ;}
{Event}         {return ;}
{Get}           {return ;}
{GoTo}          {return ;}
{Module}        {return ;}
{Namespace}     {return ;}
{Of}            {return ;}
{Operator}      {return ;}
{Option}        {return ;}
{Partial}       {return ;}
{Increment}     {return ;}
{Debug}         {return ;}
{Structure}     {return ;}

{Add}           {return ;}
{Constraint}    {return ;}
{ConditionalQuery}  {return ;}
{QueryConditions}   {return ;}
{Alter}         {return ;}
{Insert}        {return ;}
{Sort}          {return ;}
{Backup}        {return ;}
{Range}         {return ;}
{View}          {return ;}
{Column}        {return ;}
{Table}         {return ;}
{Database}      {return ;}
{Select}        {return ;}
{Join}          {return ;}
{Index}         {return ;}
{Limit}         {return ;}
{Update}        {return ;}
{Union}         {return ;}

{Identifier}    {return ;}
//{}{return ;}

[\s\t\n\r]      {/* Ignore space, tab, new line and carriage return characters */}
.               {return ;}