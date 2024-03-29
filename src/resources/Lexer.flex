// User Code (Import dependencies or declare variables)
import java.util.HashMap;
%%
// Options and Declarations
%public
%class Lexer
%function nextToken
%type Token
%line
%column
%unicode
// %cup

// Code for defining atributes a methods of the class "Lexer"
%{
    private int _numberTokens = 0;
    private boolean _thereIsTokens = false;
    private HashMap<String, Integer> identifiers = new HashMap<String, Integer>();
    
    public boolean thereIsTokens() {return this._thereIsTokens;}
    public int numberTokens() {return this._numberTokens;}
    public HashMap<String, Integer> getIdentifiers() {return this.identifiers;}

    // Creates and returns a Token Object
    private Token foundSymbol(String token, String lexeme, int line, int column) {
        this._thereIsTokens = true;
        this._numberTokens++;

        // value given lexeme as a key
        Integer value = identifiers.get(lexeme);
        Integer size = identifiers.size();
        
        // Logic for storing identifiers in the Hashmap
        if (token == "Identificador") {
            if (value == null) {
                identifiers.put(lexeme, size);
                lexeme = size.toString();
            } else {
                lexeme = value.toString();
            }
        }   

        Token t = new Token(token, lexeme, line, column);
        return t;
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

LineComment = "#".*
BlockComment = ("/*"[^]*"*/")

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
{Comparison}    {return foundSymbol("Comparador", yytext(), yyline, yycolumn);}
{Arithmetic}    {return foundSymbol("Operador Aritmetico", yytext(), yyline, yycolumn);}
{Unary}         {return foundSymbol("Operador Unario", yytext(), yyline, yycolumn);}
{Assignment}    {return foundSymbol("Asignador", yytext(), yyline, yycolumn);}
{Logical}       {return foundSymbol("Operador Logico", yytext(), yyline, yycolumn);}
{Negation}      {return foundSymbol("Negacion", "", yyline, yycolumn);}
{Nullish}       {return foundSymbol("Operador Nulo", "", yyline, yycolumn);}
{Ternary}       {return foundSymbol("Operador Ternario", "", yyline, yycolumn);}
{Identity}      {return foundSymbol("Operador de identidad", yytext(), yyline, yycolumn);}
{Instance}      {return foundSymbol("Operador de instancia", "", yyline, yycolumn);}
{Type}          {return foundSymbol("Operador de typo", "", yyline, yycolumn);}
{Membership}    {return foundSymbol("Operador de Pertenencia", yytext(), yyline, yycolumn);}
{Bitwise}       {return foundSymbol("Operador de Bits", yytext(), yyline, yycolumn);}

{Boolean}       {return foundSymbol("Booleano", yytext(), yyline, yycolumn);}
{Null}          {return foundSymbol("Valor nulo", yytext(), yyline, yycolumn);}
{String}        {return foundSymbol("Cadena", yytext(), yyline, yycolumn);}
{Character}     {return foundSymbol("Caracter", yytext(), yyline, yycolumn);}
{Integer}       {return foundSymbol("Entero", yytext(), yyline, yycolumn);}
{Decimal}       {return foundSymbol("Decimal", yytext(), yyline, yycolumn);}
{Complex}       {return foundSymbol("Complejo", yytext(), yyline, yycolumn);}

{ForLoop}       {return foundSymbol("Ciclo For", "", yyline, yycolumn);}
{DoLoop}        {return foundSymbol("Ciclo Do", "", yyline, yycolumn);}
{WhileLoop}     {return foundSymbol("Ciclo While", "", yyline, yycolumn);}
{Iterate}       {return foundSymbol("Iterador", yytext(), yyline, yycolumn);}

{DataType}      {return foundSymbol("Tipo de dato", yytext(), yyline, yycolumn);}
{DataStructure} {return foundSymbol("Estructura de datos", yytext(), yyline, yycolumn);}
{Variable}      {return foundSymbol("Variable", yytext(), yyline, yycolumn);}

{Conditional}   {return foundSymbol("Condicional", "", yyline, yycolumn);}
{ConditionalConsequence}    {return foundSymbol("Consecuencia Condicional", "", yyline, yycolumn);}
{Consequence}   {return foundSymbol("Consequencia", "", yyline, yycolumn);}
{Switch}        {return foundSymbol("Switch", "", yyline, yycolumn);}
{Case}          {return foundSymbol("Case", "", yyline, yycolumn);}

{Function}      {return foundSymbol("Funcion", yytext(), yyline, yycolumn);}
{Void}          {return foundSymbol("Void", "", yyline, yycolumn);}
{Lambda}        {return foundSymbol("Lamda", "", yyline, yycolumn);}
{Execute}       {return foundSymbol("Ejecutar", yytext(), yyline, yycolumn);}
{Try}           {return foundSymbol("Intentar", yytext(), yyline, yycolumn);}
{TryConsequence}    {return foundSymbol("Consecuencia Itentar", yytext(), yyline, yycolumn);}
{Exception}     {return foundSymbol("Excepcion", yytext(), yyline, yycolumn);}

{LineComment}   {/*return foundSymbol("Comentario en linea", yytext(), yyline, yycolumn);*/}
{BlockComment}  {/*ignore block comment */}

{AccesMod}      {return foundSymbol("Modificador de Acceso", yytext(), yyline, yycolumn);}
{NonAccesMod}   {return foundSymbol("Modificador de No Acceso", yytext(), yyline, yycolumn);}
{ParIzq}        {return foundSymbol("Parentesis Izquierdo", "", yyline, yycolumn);}
{ParDer}        {return foundSymbol("Parentesis Derecho", "", yyline, yycolumn);}
{LlaveIzq}      {return foundSymbol("Llave Izquierda", "", yyline, yycolumn);}
{LlaveDer}      {return foundSymbol("Llave Derecha", "", yyline, yycolumn);}
{CorIzq}        {return foundSymbol("Corchete Izquierdo", "", yyline, yycolumn);}
{CorDer}        {return foundSymbol("Corchete Derecho", "", yyline, yycolumn);}
{Point}         {return foundSymbol("Punto", "", yyline, yycolumn);}
{Comma}         {return foundSymbol("Coma", "", yyline, yycolumn);}
{Colon}         {return foundSymbol("Dos puntos", "", yyline, yycolumn);}
{SemiColon}     {return foundSymbol("Punto y coma", "", yyline, yycolumn);}
{Class}         {return foundSymbol("Clase", "", yyline, yycolumn);}
{Parent}        {return foundSymbol("Clase Padre", yytext(), yyline, yycolumn);}
{Interface}     {return foundSymbol("Interface", "", yyline, yycolumn);}
{Enum}          {return foundSymbol("Enum", "", yyline, yycolumn);}
{Extends}       {return foundSymbol("Extiende", "", yyline, yycolumn);}
{Implements}    {return foundSymbol("Implementa", "", yyline, yycolumn);}
{Break}         {return foundSymbol("Salida", yytext(), yyline, yycolumn);}
{Continue}      {return foundSymbol("Continuar", "", yyline, yycolumn);}
{Pass}          {return foundSymbol("Pass", "", yyline, yycolumn);}
{Importing}     {return foundSymbol("Importar", yytext(), yyline, yycolumn);}
{Return}        {return foundSymbol("Regresar", yytext(), yyline, yycolumn);}
{Create}        {return foundSymbol("Crear", yytext(), yyline, yycolumn);}
{Delete}        {return foundSymbol("Borrar", yytext(), yyline, yycolumn);}
{This}          {return foundSymbol("This", yytext(), yyline, yycolumn);}
{Reference}     {return foundSymbol("Referencia", yytext(), yyline, yycolumn);}
{Alias}         {return foundSymbol("Renombrar", yytext(), yyline, yycolumn);}
{Asynchronous}  {return foundSymbol("Asyncrono", yytext(), yyline, yycolumn);}
{Package}       {return foundSymbol("Paquete", "", yyline, yycolumn);}
{Print}         {return foundSymbol("Imprimir", "", yyline, yycolumn);}

{Handler}       {return foundSymbol("AddHandler", yytext(), yyline, yycolumn);}
{Modifier}      {return foundSymbol("Modificador", yytext(), yyline, yycolumn);}
{Storage}       {return foundSymbol("Almacenamiento", yytext(), yyline, yycolumn);}
{Cast}          {return foundSymbol("Cast", yytext(), yyline, yycolumn);}
{Event}         {return foundSymbol("Evento", "", yyline, yycolumn);}
{Get}           {return foundSymbol("Get", yytext(), yyline, yycolumn);}
{GoTo}          {return foundSymbol("GoTo", "", yyline, yycolumn);}
{Module}        {return foundSymbol("Module", "", yyline, yycolumn);}
{Namespace}     {return foundSymbol("Namespace", "", yyline, yycolumn);}
{Of}            {return foundSymbol("Of", "", yyline, yycolumn);}
{Operator}      {return foundSymbol("Operador de VB", "", yyline, yycolumn);}
{Option}        {return foundSymbol("Opcion", "", yyline, yycolumn);}
{Partial}       {return foundSymbol("Parcial", "", yyline, yycolumn);}
{Increment}     {return foundSymbol("Incremento", "", yyline, yycolumn);}
{Debug}         {return foundSymbol("Debug", "", yyline, yycolumn);}
{Structure}     {return foundSymbol("Estructura", "", yyline, yycolumn);}

{Add}           {return foundSymbol("Añadir", yytext(), yyline, yycolumn);}
{Constraint}    {return foundSymbol("Restriccion", yytext(), yyline, yycolumn);}
{ConditionalQuery}  {return foundSymbol("Query Condicional", yytext(), yyline, yycolumn);}
{QueryConditions}   {return foundSymbol("Condiciones Query", yytext(), yyline, yycolumn);}
{Alter}         {return foundSymbol("Alterar", "", yyline, yycolumn);}
{Insert}        {return foundSymbol("Insertar", yytext(), yyline, yycolumn);}
{Sort}          {return foundSymbol("Ordenar", yytext(), yyline, yycolumn);}
{Backup}        {return foundSymbol("Backup", "", yyline, yycolumn);}
{Range}         {return foundSymbol("Rango", "", yyline, yycolumn);}
{View}          {return foundSymbol("Vista", "", yyline, yycolumn);}
{Column}        {return foundSymbol("Columna", "", yyline, yycolumn);}
{Table}         {return foundSymbol("Tabla", "", yyline, yycolumn);}
{Database}      {return foundSymbol("Database", "", yyline, yycolumn);}
{Select}        {return foundSymbol("Select", "", yyline, yycolumn);}
{Join}          {return foundSymbol("Join", yytext(), yyline, yycolumn);}
{Index}         {return foundSymbol("Indice", "", yyline, yycolumn);}
{Limit}         {return foundSymbol("Limite", yytext(), yyline, yycolumn);}
{Update}        {return foundSymbol("Update", yytext(), yyline, yycolumn);}
{Union}         {return foundSymbol("Union", yytext(), yyline, yycolumn);}

{Identifier}    {return foundSymbol("Identificador", yytext(), yyline, yycolumn);}
//{}{return foundSymbol("", yytext(), yyline, yycolumn);}

[\s\t\n\r]      {/* Ignore space, tab, new line and carriage return characters */}
.               {return foundSymbol("ERROR", yytext(), yyline, yycolumn);}


/* vim: set syntax=lex: */
