// User Code (Import dependencies or declare variables)

// import java.util.List;
// import java.util.Arrays;

/*TODO.
  - Change the return values
   - Return the lexema found if the token has more than one lexema
   - Return the nothing if the token has only one lexema
   - Return the number of the identifier found (0),(1),(2),...
*/

%%
// Options and Declarations
%class Lexer
%standalone
%line
%column
%unicode
// %cup

// Code for varibles and functions
%{
    int keywords = 0;
    //List<String> identifiers = new ArrayList<String>();
    
    void printResult(String token, String text, int line, int column){
        keywords++;
        if (text.length() >= 8)
            System.out.printf("%s\t<= %s (Linea: %d, Columna: %d)\n", text, token, line+1, column+1);
        else
            System.out.printf("%s\t\t<= %s (Linea: %d, Columna: %d)\n", text, token, line+1, column+1);
    }
%}

// Execute at the end of file
%eof{
    System.out.printf("----------------------------------------\n");
    System.out.printf("Numero total de palabras: %d.\n",keywords);
    System.out.printf("----------------------------------------\n");
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
DataType = ("int"|"int8"|"int16"|"int32"|"int64"|"string"|"boolean"|
            "float"|"decimal"|"date"|"char"|"byte"|"complex"|"long"|
            "short"|"double"|"time"|"Object"|"SByte"|"Single"|"UInteger"|
            "ULong"|"UShort"|"uint"|"uint8"|"uint16"|"uint32"|"uint64"|
            "float32"|"float64"|"complex64"|"complex128")
DataStructure = "list"|"tuple"|"dict"|"Array"|"Stack"|"Queue"
Variable = "var"|"Let"
Conditional = "if"|"elif"|"switch"|"case"|"ALL"|"ANY"|"EXISTS"|"HAVING"|"LIKE"|"WHERE"
Consequence = "else"|"finally"|"Resume"|"Then"
Function = "def"|"void"|"lambda"|"PROCEDURE"|"Sub"|"func"
Execute = "EXEC"|"Call"
Try = "try"|"assert"|"with"
Exception = "throw"|"raise"|"catch"|"except"|"Error"|"RaiseEvent"
Comment = "/*"|"*/"|"#"|"TODO"|"FIXME"|"REM"
AccesMod = "nonlocal"|"global"|"public"|"private"|"protected"|"default"|"Shared"
NonAccesMod = "ReadOnly"|"const"|"final"|"abstract"|"static"|"transient"|"synchronized"|"volatile"|"MustInherit"|"MustOverride"|"Overridable"|"Overrides"
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
Modifier = "ByRef"|"ByVal"|"strictfp"|"Friend"|"NotInheritable"|"NotOverridable"|"Optional"|"Out"|"Overloads"|"WithEvents"|"WriteOnly"
Storage = "Dim"|"ReDim"
Cast = "DirectCast"|"CBool"|"CByte"|"CChar"|"CDate"|"CDbl"|"CDec"|"CInt"|"CLng"|"CObj"|"CSByte"|"CShort"|"CSng"|"CStr"|"CUInt"|"CULng"|"CUShort"|"Narrowing"|"TryCast"|"Widening"
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
Insert = "INSERT"|"INTO"|"VALUES"
Sort = "ASC"|"DESC"|"GROUP BY"|"ORDER BY"
Backup = "BACKUP"
Range = "BETWEEN"
View = "VIEW"
Column = "COLUMN"
Table = "TABLE"
Database = "DATABASE"
Select = "SELECT"
Join = "JOIN"|"FULL OUTER JOIN"|"INNER JOIN"|"LEFT JOIN"|"OUTER JOIN"|"RIGHT JOIN"
Index = "INDEX"
Limit = "LIMIT"|"ROWNUM"|"TOP"|"DISTINCT"
Update = "UPDATE"|"SET"
Union = "UNION"|"UNION ALL"

%%
// Lexical Rules
{Comparison}    {printResult("Comparador", yytext(), yyline, yycolumn);}
{Arithmetic}    {printResult("Operador Aritmetico", yytext(), yyline, yycolumn);}
{Assignment}    {printResult("Asignador", yytext(), yyline, yycolumn);}
{Logical}       {printResult("Operador Logico", yytext(), yyline, yycolumn);}
{Identity}      {printResult("Operador de identidad", yytext(), yyline, yycolumn);}
{Instance}      {printResult("Operador de instancia", yytext(), yyline, yycolumn);}
{Membership}    {printResult("Operadot de Pertenencia", yytext(), yyline, yycolumn);}
{Bitwise}       {printResult("Operador de Bits", yytext(), yyline, yycolumn);}

{Boolean}       {printResult("Booleano", yytext(), yyline, yycolumn);}
{Null}          {printResult("Valor nulo", yytext(), yyline, yycolumn);}
{String}        {printResult("Cadena", yytext(), yyline, yycolumn);}
{Character}     {printResult("Caracter", yytext(), yyline, yycolumn);}
{Integer}       {printResult("Entero", yytext(), yyline, yycolumn);}
{Decimal}       {printResult("Decimal", yytext(), yyline, yycolumn);}
{Complex}       {printResult("Complejo", yytext(), yyline, yycolumn);}

{Loop}          {printResult("Iterador", yytext(), yyline, yycolumn);}
{DataType}      {printResult("Tipo de dato", yytext(), yyline, yycolumn);}
{DataStructure} {printResult("Estructura de datos", yytext(), yyline, yycolumn);}
{Variable}      {printResult("Variable", yytext(), yyline, yycolumn);}
{Conditional}   {printResult("Condicional", yytext(), yyline, yycolumn);}
{Consequence}   {printResult("Consequencia", yytext(), yyline, yycolumn);}
{Function}      {printResult("Funcion", yytext(), yyline, yycolumn);}
{Execute}       {printResult("Ejecutar", yytext(), yyline, yycolumn);}
{Try}           {printResult("Intentar", yytext(), yyline, yycolumn);}
{Exception}     {printResult("Excepcion", yytext(), yyline, yycolumn);}
{Comment}       {printResult("Comentario", yytext(), yyline, yycolumn);}
{AccesMod}      {printResult("Modificador de Acceso", yytext(), yyline, yycolumn);}
{NonAccesMod}   {printResult("Modificador de No Acceso", yytext(), yyline, yycolumn);}
{Separator}     {printResult("Separador", yytext(), yyline, yycolumn);}
{Class}         {printResult("Clase", yytext(), yyline, yycolumn);}
{Interface}     {printResult("Interface", yytext(), yyline, yycolumn);}
{Enum}          {printResult("Enum", yytext(), yyline, yycolumn);}
{Inherited}     {printResult("Erencia", yytext(), yyline, yycolumn);}
{Break}         {printResult("Salida", yytext(), yyline, yycolumn);}
{Continue}      {printResult("Continuar", yytext(), yyline, yycolumn);}
{Pass}          {printResult("Pasar", yytext(), yyline, yycolumn);}
{Importing}     {printResult("Importar", yytext(), yyline, yycolumn);}
{Return}        {printResult("Regresar", yytext(), yyline, yycolumn);}
{Create}        {printResult("Crear", yytext(), yyline, yycolumn);}
{Delete}        {printResult("Borrar", yytext(), yyline, yycolumn);}
{Reference}     {printResult("Referencia", yytext(), yyline, yycolumn);}
{Alias}         {printResult("Renombrar", yytext(), yyline, yycolumn);}
{Asynchronous}  {printResult("Asyncrono", yytext(), yyline, yycolumn);}
{Package}       {printResult("Paquete", yytext(), yyline, yycolumn);}
{Print}         {printResult("Imprimir", yytext(), yyline, yycolumn);}

{Handler}       {printResult("AddHandler", yytext(), yyline, yycolumn);}
{Modifier}      {printResult("Modificador", yytext(), yyline, yycolumn);}
{Storage}       {printResult("Almacenamiento", yytext(), yyline, yycolumn);}
{Cast}          {printResult("Cast", yytext(), yyline, yycolumn);}
{Event}         {printResult("Evento", yytext(), yyline, yycolumn);}
{Get}           {printResult("Get", yytext(), yyline, yycolumn);}
{GoTo}          {printResult("GoTo", yytext(), yyline, yycolumn);}
{Module}        {printResult("Module", yytext(), yyline, yycolumn);}
{Namespace}     {printResult("Namespace", yytext(), yyline, yycolumn);}
{Of}            {printResult("Of", yytext(), yyline, yycolumn);}
{Operator}      {printResult("Operador de VB", yytext(), yyline, yycolumn);}
{Option}        {printResult("Opcion", yytext(), yyline, yycolumn);}
{Partial}       {printResult("Parcial", yytext(), yyline, yycolumn);}
{Increment}     {printResult("Incremento", yytext(), yyline, yycolumn);}
{Debug}         {printResult("Debug", yytext(), yyline, yycolumn);}
{Structure}     {printResult("Estructura", yytext(), yyline, yycolumn);}

{Add}           {printResult("Añadir", yytext(), yyline, yycolumn);}
{Constraint}    {printResult("Restriccion", yytext(), yyline, yycolumn);}
{Alter}         {printResult("Alterar", yytext(), yyline, yycolumn);}
{Insert}        {printResult("Insertar", yytext(), yyline, yycolumn);}
{Sort}          {printResult("Ordenar", yytext(), yyline, yycolumn);}
{Backup}        {printResult("Backup", yytext(), yyline, yycolumn);}
{Range}         {printResult("Rango", yytext(), yyline, yycolumn);}
{View}          {printResult("Vista", yytext(), yyline, yycolumn);}
{Column}        {printResult("Columna", yytext(), yyline, yycolumn);}
{Table}         {printResult("Tabla", yytext(), yyline, yycolumn);}
{Database}      {printResult("Database", yytext(), yyline, yycolumn);}
{Select}        {printResult("Select", yytext(), yyline, yycolumn);}
{Join}          {printResult("Join", yytext(), yyline, yycolumn);}
{Index}         {printResult("Indice", yytext(), yyline, yycolumn);}
{Limit}         {printResult("Limite", yytext(), yyline, yycolumn);}
{Update}        {printResult("Update", yytext(), yyline, yycolumn);}
{Union}         {printResult("Union", yytext(), yyline, yycolumn);}

{Identifier}    {printResult("Identificador", yytext(), yyline, yycolumn);}
//{}{printResult("", yytext(), yyline, yycolumn);}

[^] {/* Ignore unmatched characters */}