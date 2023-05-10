// User Code (Import dependencies or declare variables)

/*TODO.
    - Refactor some of the token (separe the 'Separator' category into their own tokens)

    - Change the return values
        - Return the lexema found if the token has more than one lexeme
        - Return the nothing if the token has only one lexeme
        - Return the number of the identifier found (0),(1),(2),...
*/

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
    
    public boolean thereIsTokens() {return this._thereIsTokens;}
    public int numberTokens() {return this._numberTokens;}

    // Creates and returns a Token Object
    private Token foundSymbol(String token, String lexeme, int line, int column) {
        this._thereIsTokens = true;
        this._numberTokens++;
        Token t = new Token(token, lexeme, line, column);
        return t;
    }
%}

// Execute at the end of file
%eof{
    this._thereIsTokens = false;
%eof}

// --- Definitions ---
SIGN = [+-]
DIGIT = [0-9]
DEC = "."{DIGIT}+
EXPO = [Ee]{SIGN}?{DIGIT}+

Identifier = [a-zA-Z][a-zA-Z0-9_]*

// Operators
Comparison = "<"|">"|"=="|"!="|"<="|">="
Arithmetic  = "+"|"-"|"*"|"/"|"**"|"//"|"%"|"++"|"--"|"Mod"
Assignment = "="|"+="|"-="|"*="|"/="|"**="|"//="|"%="|"&="|"|="|"^="|">>="|"<<="
Logical = "&&"|"||"|"!"|"and"|"or"|"not"|"?"|"??"|"AndAlso"|"OrElse"|"Xor"
Identity = "is"|"is not"
Instance = "instanceof"
Type = "TypeOf"
Membership = "in"|"not in"
Bitwise = "&"|"|"|"^"|"~"|"<<"|">>"

// Literals
Boolean = ([Tt]"rue")|([Ff]"alse")
Null = [Nn]"ull"|"None"|"Nothing"
String = \"[^\'\"]*\"
Character = \'[^\'\"\\]?\'
Integer = {SIGN}?{DIGIT}+           // [+-]?[0-9]+
Decimal = {Integer}{DEC}?{EXPO}?    // ([+-]?[0-9]+)("."[0-9]+)?([Ee][+-]?[0-9]+)?
Complex = ({Integer}|{Decimal})"i"  // (([+-]?[0-9]+)|(([+-]?[0-9]+)("."[0-9]+)?([Ee][+-]?[0-9]+)?))"i"

// Keywords
Loop = "for"|"foreach"|"while"|"do"|"Each"|"Next"
DataType = (
    "int"|"int8"|"int16"|"int32"|"int64"|"string"|"boolean"|
    "float"|"decimal"|"date"|"char"|"byte"|"complex"|"long"|
    "short"|"double"|"time"|"Object"|"SByte"|"Single"|"UInteger"|
    "ULong"|"UShort"|"uint"|"uint8"|"uint16"|"uint32"|"uint64"|
    "float32"|"float64"|"complex64"|"complex128"
)
DataStructure = "list"|"tuple"|"dict"|"Array"|"Stack"|"Queue"
Variable = "var"|"Let"
Conditional = (
    "if"|"elif"|"switch"|"case"|"ALL"|
    "ANY"|"EXISTS"|"HAVING"|"LIKE"|"WHERE"
)
Consequence = "else"|"finally"|"Resume"|"Then"
Function = "def"|"void"|"lambda"|"PROCEDURE"|"Sub"|"func"
Execute = "EXEC"|"Call"
Try = "try"|"assert"|"with"
Exception = "throw"|"raise"|"catch"|"except"|"Error"|"RaiseEvent"
Comment = "/*"|"*/"|"#"|"TODO"|"FIXME"|"REM"
AccesMod = "nonlocal"|"global"|"public"|"private"|"protected"|"default"|"Shared"
NonAccesMod = (
    "ReadOnly"|"const"|"final"|"abstract"|"static"|
    "transient"|"synchronized"|"volatile"|"MustInherit"|
    "MustOverride"|"Overridable"|"Overrides"
)
Separator = "("|")"|"{"|"}"|"["|"]"|";"|","|"."|":"
Class = "class"
Parent = "super"|"MyBase"
Interface = "interface"
Enum = "enum"
Inherited = "extends"|"implements"
Break = "break"|"End"|"Exit"
Continue = "continue"
Pass = "pass"
Importing = "import"|"from"|"requires"|"native"|"Using"
Return = "return"|"yield"
Create = "new"|"CREATE"
Delete = "del"|"DELETE"|"DROP"|"TRUNCATE"|"Erase"|"RemoveHandler"
Reference = "this"|"self"|"throws"|"AddressOf"|"Delegate"|"Lib"|"Me"|"MyClass"
Alias = "as"|"Alias"
Asynchronous = "await"|"async"
Package = "package"
Print = "print"

// VisualBasic
Handler = "AddHandler"|"Handles"
Modifier = (
    "ByRef"|"ByVal"|"strictfp"|"Friend"|"NotInheritable"|"NotOverridable"|
    "Optional"|"Out"|"Overloads"|"WithEvents"|"WriteOnly"
)
Storage = "Dim"|"ReDim"
Cast = (
    "DirectCast"|"CBool"|"CByte"|"CChar"|"CDate"|"CDbl"|"CDec"|"CInt"|
    "CLng"|"CObj"|"CSByte"|"CShort"|"CSng"|"CStr"|"CUInt"|"CULng"|
    "CUShort"|"Narrowing"|"TryCast"|"Widening"
)
Event = "Event"
Get = "Get"|"GetType"|"GetXmlNamespace"|"NameOf"
GoTo = "GoTo"
Module = "Module"
Namespace = "Namespace"
Of = "Of"
Operator = "Operator"
Option = "Option"
Partial = "Partial"
Increment = "Step"
Debug = "Stop"
Structure = "Structure"

// SQL Keywords
Add = "ADD"|"ADD CONSTRAINT"
Constraint = "CHECK"|"CONSTRAINT"|"FOREIGN KEY"|"PRIMARY KEY"|"UNIQUE"
Alter = "ALTER"
Insert = "INSERT INTO"|"VALUES"
Sort = "ASC"|"DESC"|"GROUP BY"|"ORDER BY"
Backup = "BACKUP"
Range = "BETWEEN"
View = "VIEW"
Column = "COLUMN"
Table = "TABLE"
Database = "DATABASE"
Select = "SELECT"
Join = (
    "JOIN"|"FULL OUTER JOIN"|"INNER JOIN"|
    "LEFT JOIN"|"OUTER JOIN"|"RIGHT JOIN"
)
Index = "INDEX"
Limit = "LIMIT"|"ROWNUM"|"TOP"|"DISTINCT"
Update = "UPDATE"|"SET"
Union = "UNION"|"UNION ALL"

%%
// Lexical Rules
{Comparison}    {return foundSymbol("Comparador", yytext(), yyline, yycolumn);}
{Arithmetic}    {return foundSymbol("Operador Aritmetico", yytext(), yyline, yycolumn);}
{Assignment}    {return foundSymbol("Asignador", yytext(), yyline, yycolumn);}
{Logical}       {return foundSymbol("Operador Logico", yytext(), yyline, yycolumn);}
{Identity}      {return foundSymbol("Operador de identidad", yytext(), yyline, yycolumn);}
{Instance}      {return foundSymbol("Operador de instancia", yytext(), yyline, yycolumn);}
{Membership}    {return foundSymbol("Operadot de Pertenencia", yytext(), yyline, yycolumn);}
{Bitwise}       {return foundSymbol("Operador de Bits", yytext(), yyline, yycolumn);}

{Boolean}       {return foundSymbol("Booleano", yytext(), yyline, yycolumn);}
{Null}          {return foundSymbol("Valor nulo", yytext(), yyline, yycolumn);}
{String}        {return foundSymbol("Cadena", yytext(), yyline, yycolumn);}
{Character}     {return foundSymbol("Caracter", yytext(), yyline, yycolumn);}
{Integer}       {return foundSymbol("Entero", yytext(), yyline, yycolumn);}
{Decimal}       {return foundSymbol("Decimal", yytext(), yyline, yycolumn);}
{Complex}       {return foundSymbol("Complejo", yytext(), yyline, yycolumn);}

{Loop}          {return foundSymbol("Iterador", yytext(), yyline, yycolumn);}
{DataType}      {return foundSymbol("Tipo de dato", yytext(), yyline, yycolumn);}
{DataStructure} {return foundSymbol("Estructura de datos", yytext(), yyline, yycolumn);}
{Variable}      {return foundSymbol("Variable", yytext(), yyline, yycolumn);}
{Conditional}   {return foundSymbol("Condicional", yytext(), yyline, yycolumn);}
{Consequence}   {return foundSymbol("Consequencia", yytext(), yyline, yycolumn);}
{Function}      {return foundSymbol("Funcion", yytext(), yyline, yycolumn);}
{Execute}       {return foundSymbol("Ejecutar", yytext(), yyline, yycolumn);}
{Try}           {return foundSymbol("Intentar", yytext(), yyline, yycolumn);}
{Exception}     {return foundSymbol("Excepcion", yytext(), yyline, yycolumn);}
{Comment}       {return foundSymbol("Comentario", yytext(), yyline, yycolumn);}
{AccesMod}      {return foundSymbol("Modificador de Acceso", yytext(), yyline, yycolumn);}
{NonAccesMod}   {return foundSymbol("Modificador de No Acceso", yytext(), yyline, yycolumn);}
{Separator}     {return foundSymbol("Separador", yytext(), yyline, yycolumn);}
{Class}         {return foundSymbol("Clase", yytext(), yyline, yycolumn);}
{Interface}     {return foundSymbol("Interface", yytext(), yyline, yycolumn);}
{Enum}          {return foundSymbol("Enum", yytext(), yyline, yycolumn);}
{Inherited}     {return foundSymbol("Erencia", yytext(), yyline, yycolumn);}
{Break}         {return foundSymbol("Salida", yytext(), yyline, yycolumn);}
{Continue}      {return foundSymbol("Continuar", yytext(), yyline, yycolumn);}
{Pass}          {return foundSymbol("Pasar", yytext(), yyline, yycolumn);}
{Importing}     {return foundSymbol("Importar", yytext(), yyline, yycolumn);}
{Return}        {return foundSymbol("Regresar", yytext(), yyline, yycolumn);}
{Create}        {return foundSymbol("Crear", yytext(), yyline, yycolumn);}
{Delete}        {return foundSymbol("Borrar", yytext(), yyline, yycolumn);}
{Reference}     {return foundSymbol("Referencia", yytext(), yyline, yycolumn);}
{Alias}         {return foundSymbol("Renombrar", yytext(), yyline, yycolumn);}
{Asynchronous}  {return foundSymbol("Asyncrono", yytext(), yyline, yycolumn);}
{Package}       {return foundSymbol("Paquete", yytext(), yyline, yycolumn);}
{Print}         {return foundSymbol("Imprimir", yytext(), yyline, yycolumn);}

{Handler}       {return foundSymbol("AddHandler", yytext(), yyline, yycolumn);}
{Modifier}      {return foundSymbol("Modificador", yytext(), yyline, yycolumn);}
{Storage}       {return foundSymbol("Almacenamiento", yytext(), yyline, yycolumn);}
{Cast}          {return foundSymbol("Cast", yytext(), yyline, yycolumn);}
{Event}         {return foundSymbol("Evento", yytext(), yyline, yycolumn);}
{Get}           {return foundSymbol("Get", yytext(), yyline, yycolumn);}
{GoTo}          {return foundSymbol("GoTo", yytext(), yyline, yycolumn);}
{Module}        {return foundSymbol("Module", yytext(), yyline, yycolumn);}
{Namespace}     {return foundSymbol("Namespace", yytext(), yyline, yycolumn);}
{Of}            {return foundSymbol("Of", yytext(), yyline, yycolumn);}
{Operator}      {return foundSymbol("Operador de VB", yytext(), yyline, yycolumn);}
{Option}        {return foundSymbol("Opcion", yytext(), yyline, yycolumn);}
{Partial}       {return foundSymbol("Parcial", yytext(), yyline, yycolumn);}
{Increment}     {return foundSymbol("Incremento", yytext(), yyline, yycolumn);}
{Debug}         {return foundSymbol("Debug", yytext(), yyline, yycolumn);}
{Structure}     {return foundSymbol("Estructura", yytext(), yyline, yycolumn);}

{Add}           {return foundSymbol("Añadir", yytext(), yyline, yycolumn);}
{Constraint}    {return foundSymbol("Restriccion", yytext(), yyline, yycolumn);}
{Alter}         {return foundSymbol("Alterar", yytext(), yyline, yycolumn);}
{Insert}        {return foundSymbol("Insertar", yytext(), yyline, yycolumn);}
{Sort}          {return foundSymbol("Ordenar", yytext(), yyline, yycolumn);}
{Backup}        {return foundSymbol("Backup", yytext(), yyline, yycolumn);}
{Range}         {return foundSymbol("Rango", yytext(), yyline, yycolumn);}
{View}          {return foundSymbol("Vista", yytext(), yyline, yycolumn);}
{Column}        {return foundSymbol("Columna", yytext(), yyline, yycolumn);}
{Table}         {return foundSymbol("Tabla", yytext(), yyline, yycolumn);}
{Database}      {return foundSymbol("Database", yytext(), yyline, yycolumn);}
{Select}        {return foundSymbol("Select", yytext(), yyline, yycolumn);}
{Join}          {return foundSymbol("Join", yytext(), yyline, yycolumn);}
{Index}         {return foundSymbol("Indice", yytext(), yyline, yycolumn);}
{Limit}         {return foundSymbol("Limite", yytext(), yyline, yycolumn);}
{Update}        {return foundSymbol("Update", yytext(), yyline, yycolumn);}
{Union}         {return foundSymbol("Union", yytext(), yyline, yycolumn);}

{Identifier}    {return foundSymbol("Identificador", yytext(), yyline, yycolumn);}
//{}{return foundSymbol("", yytext(), yyline, yycolumn);}

[^] {/* Ignore unmatched characters */}