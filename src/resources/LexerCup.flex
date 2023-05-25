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
%full

// Code for defining atributes a methods of the class "Lexer"
%{  
    private boolean _thereIsTokens = false;

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
ConditionConseq = ("elif")
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
// Operators
{Comparison}        {return new Symbol(sym.Comparison, yycolumn, yyline, yytext());}
{Arithmetic}        {return new Symbol(sym.Arithmetic, yycolumn, yyline, yytext());}
{Unary}             {return new Symbol(sym.Unary, yycolumn, yyline, yytext());}
{Assignment}        {return new Symbol(sym.Assignment, yycolumn, yyline, yytext());}
{Logical}           {return new Symbol(sym.Logical, yycolumn, yyline, yytext());}
{Negation}          {return new Symbol(sym.Negation, yycolumn, yyline, yytext());}
{Nullish}           {return new Symbol(sym.Nullish, yycolumn, yyline, yytext());}
{Ternary}           {return new Symbol(sym.Ternary, yycolumn, yyline, yytext());}
{Identity}          {return new Symbol(sym.Identity, yycolumn, yyline, yytext());}
{Instance}          {return new Symbol(sym.Instance, yycolumn, yyline, yytext());}
{Type}              {return new Symbol(sym.Type, yycolumn, yyline, yytext());}
{Membership}        {return new Symbol(sym.Membership, yycolumn, yyline, yytext());}
{Bitwise}           {return new Symbol(sym.Bitwise, yycolumn, yyline, yytext());}

// Literals
{Boolean}           {return new Symbol(sym.Boolean, yycolumn, yyline, yytext());}
{Null}              {return new Symbol(sym.Null, yycolumn, yyline, yytext());}
{String}            {return new Symbol(sym.String, yycolumn, yyline, yytext());}
{Character}         {return new Symbol(sym.Character, yycolumn, yyline, yytext());}
{Integer}           {return new Symbol(sym.Integer, yycolumn, yyline, yytext());}
{Decimal}           {return new Symbol(sym.Decimal, yycolumn, yyline, yytext());}
{Complex}           {return new Symbol(sym.Complex, yycolumn, yyline, yytext());}

// Loops
{ForLoop}           {return new Symbol(sym.ForLoop, yycolumn, yyline, yytext());}
{DoLoop}            {return new Symbol(sym.DoLoop, yycolumn, yyline, yytext());}
{WhileLoop}         {return new Symbol(sym.WhileLoop, yycolumn, yyline, yytext());}
{Iterate}           {return new Symbol(sym.Iterate, yycolumn, yyline, yytext());}

// Variables
{DataType}          {return new Symbol(sym.DataType, yycolumn, yyline, yytext());}
{DataStructure}     {return new Symbol(sym.DataStructure, yycolumn, yyline, yytext());}
{Variable}          {return new Symbol(sym.Variable, yycolumn, yyline, yytext());}

// Conditionals
{Conditional}       {return new Symbol(sym.Conditional, yycolumn, yyline, yytext());}
{ConditionConseq}   {return new Symbol(sym.ConditionConseq, yycolumn, yyline, yytext());}
{Consequence}       {return new Symbol(sym.Consequence, yycolumn, yyline, yytext());}
{Switch}            {return new Symbol(sym.Switch, yycolumn, yyline, yytext());}
{Case}              {return new Symbol(sym.Case, yycolumn, yyline, yytext());}

// Functions and Modifiers 
{Function}          {return new Symbol(sym.Function, yycolumn, yyline, yytext());}
{Void}              {return new Symbol(sym.Void, yycolumn, yyline, yytext());}
{Lambda}            {return new Symbol(sym.Lambda, yycolumn, yyline, yytext());}
{Execute}           {return new Symbol(sym.Execute, yycolumn, yyline, yytext());}
{Try}               {return new Symbol(sym.Try, yycolumn, yyline, yytext());}
{TryConsequence}    {return new Symbol(sym.TryConsequence, yycolumn, yyline, yytext());}
{Exception}         {return new Symbol(sym.Exception, yycolumn, yyline, yytext());}

// Comments
{LineComment}       {return new Symbol(sym.LineComment, yycolumn, yyline, yytext());}
{StartComment}      {return new Symbol(sym.StartComment, yycolumn, yyline, yytext());}
{EndComment}        {return new Symbol(sym.EndComment, yycolumn, yyline, yytext());}
{SpecialComment}    {return new Symbol(sym.SpecialComment, yycolumn, yyline, yytext());}

// Modifiers
{AccesMod}          {return new Symbol(sym.AccesMod, yycolumn, yyline, yytext());}
{NonAccesMod}       {return new Symbol(sym.NonAccesMod, yycolumn, yyline, yytext());}

// Separators
{ParIzq}            {return new Symbol(sym.ParIzq, yycolumn, yyline, yytext());}
{ParDer}            {return new Symbol(sym.ParDer, yycolumn, yyline, yytext());}
{LlaveIzq}          {return new Symbol(sym.LlaveIzq, yycolumn, yyline, yytext());}
{LlaveDer}          {return new Symbol(sym.LlaveDer, yycolumn, yyline, yytext());}
{CorIzq}            {return new Symbol(sym.CorIzq, yycolumn, yyline, yytext());}
{CorDer}            {return new Symbol(sym.CorDer, yycolumn, yyline, yytext());}
{Point}             {return new Symbol(sym.Point, yycolumn, yyline, yytext());}
{Comma}             {return new Symbol(sym.Comma, yycolumn, yyline, yytext());}
{Colon}             {return new Symbol(sym.Colon, yycolumn, yyline, yytext());}
{SemiColon}         {return new Symbol(sym.SemiColon, yycolumn, yyline, yytext());}

// Misc
{Class}             {return new Symbol(sym.Class, yycolumn, yyline, yytext());}
{Parent}            {return new Symbol(sym.Parent, yycolumn, yyline, yytext());}
{Interface}         {return new Symbol(sym.Interface, yycolumn, yyline, yytext());}
{Enum}              {return new Symbol(sym.Enum, yycolumn, yyline, yytext());}
{Extends}           {return new Symbol(sym.Extends, yycolumn, yyline, yytext());}
{Implements}        {return new Symbol(sym.Implements, yycolumn, yyline, yytext());}
{Break}             {return new Symbol(sym.Break, yycolumn, yyline, yytext());}
{Continue}          {return new Symbol(sym.Continue, yycolumn, yyline, yytext());}
{Pass}              {return new Symbol(sym.Pass, yycolumn, yyline, yytext());}
{Importing}         {return new Symbol(sym.Importing, yycolumn, yyline, yytext());}
{Return}            {return new Symbol(sym.Return, yycolumn, yyline, yytext());}
{Create}            {return new Symbol(sym.Create, yycolumn, yyline, yytext());}
{Delete}            {return new Symbol(sym.Delete, yycolumn, yyline, yytext());}
{This}              {return new Symbol(sym.This, yycolumn, yyline, yytext());}
{Reference}         {return new Symbol(sym.Reference, yycolumn, yyline, yytext());}
{Alias}             {return new Symbol(sym.Alias, yycolumn, yyline, yytext());}
{Asynchronous}      {return new Symbol(sym.Asynchronous, yycolumn, yyline, yytext());}
{Package}           {return new Symbol(sym.Package, yycolumn, yyline, yytext());}
{Print}             {return new Symbol(sym.Print, yycolumn, yyline, yytext());}

// Visual Basic
{Handler}           {return new Symbol(sym.Handler, yycolumn, yyline, yytext());}
{Modifier}          {return new Symbol(sym.Modifier, yycolumn, yyline, yytext());}
{Storage}           {return new Symbol(sym.Storage, yycolumn, yyline, yytext());}
{Cast}              {return new Symbol(sym.Cast, yycolumn, yyline, yytext());}
{Event}             {return new Symbol(sym.Event, yycolumn, yyline, yytext());}
{Get}               {return new Symbol(sym.Get, yycolumn, yyline, yytext());}
{GoTo}              {return new Symbol(sym.GoTo, yycolumn, yyline, yytext());}
{Module}            {return new Symbol(sym.Module, yycolumn, yyline, yytext());}
{Namespace}         {return new Symbol(sym.Namespace, yycolumn, yyline, yytext());}
{Of}                {return new Symbol(sym.Of, yycolumn, yyline, yytext());}
{Operator}          {return new Symbol(sym.Operator, yycolumn, yyline, yytext());}
{Option}            {return new Symbol(sym.Option, yycolumn, yyline, yytext());}
{Partial}           {return new Symbol(sym.Partial, yycolumn, yyline, yytext());}
{Increment}         {return new Symbol(sym.Increment, yycolumn, yyline, yytext());}
{Debug}             {return new Symbol(sym.Debug, yycolumn, yyline, yytext());}
{Structure}         {return new Symbol(sym.Structure, yycolumn, yyline, yytext());}

// SQL
{Add}               {return new Symbol(sym.Add, yycolumn, yyline, yytext());}
{Constraint}        {return new Symbol(sym.Constraint, yycolumn, yyline, yytext());}
{ConditionalQuery}  {return new Symbol(sym.ConditionalQuery, yycolumn, yyline, yytext());}
{QueryConditions}   {return new Symbol(sym.QueryConditions, yycolumn, yyline, yytext());}
{Alter}             {return new Symbol(sym.Alter, yycolumn, yyline, yytext());}
{Insert}            {return new Symbol(sym.Insert, yycolumn, yyline, yytext());}
{Sort}              {return new Symbol(sym.Sort, yycolumn, yyline, yytext());}
{Backup}            {return new Symbol(sym.Backup, yycolumn, yyline, yytext());}
{Range}             {return new Symbol(sym.Range, yycolumn, yyline, yytext());}
{View}              {return new Symbol(sym.View, yycolumn, yyline, yytext());}
{Column}            {return new Symbol(sym.Column, yycolumn, yyline, yytext());}
{Table}             {return new Symbol(sym.Table, yycolumn, yyline, yytext());}
{Database}          {return new Symbol(sym.Database, yycolumn, yyline, yytext());}
{Select}            {return new Symbol(sym.Select, yycolumn, yyline, yytext());}
{Join}              {return new Symbol(sym.Join, yycolumn, yyline, yytext());}
{Index}             {return new Symbol(sym.Index, yycolumn, yyline, yytext());}
{Limit}             {return new Symbol(sym.Limit, yycolumn, yyline, yytext());}
{Update}            {return new Symbol(sym.Update, yycolumn, yyline, yytext());}
{Union}             {return new Symbol(sym.Union, yycolumn, yyline, yytext());}

{Identifier}        {return new Symbol(sym.Identifier, yycolumn, yyline, yytext());}
//{}{return new Symbol(sym., yycolumn, yyline, yytext());}

[\s\t\n\r]          {/* Ignore space, tab, new line and carriage return characters */}
.                   {return new Symbol(sym.Error, yycolumn, yyline, yytext());}