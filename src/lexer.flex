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
%class lexer
%standalone
%line
%column
%unicode
// %cup
// %debug

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

Identifier = [a-zA-Z][a-zA-Z0-9_]*

// Operators
Comparison = "<"|">"|"=="|"!="|"<="|">="
Arithmetic  = "+"|"-"|"*"|"/"|"**"|"//"|"%"|"++"|"--"
Assignment = "="|"+="|"-="|"*="|"/="|"**="|"//="|"%="|"&="|"|="|"^="|">>="|"<<="
Logical = "&&"|"||"|"!"|"and"|"or"|"not"|"?"|"??"|"AndAlso"
Identity = "is"|"is not"
Instance = "instanceof"
Membership = "in"|"not in"
Bitwise = "&"|"|"|"^"|"~"|"<<"|">>"

// Literals
Boolean = ([Tt]"rue")|([Ff]"alse")
Null = [Nn]"ull"|"None"
String = \"[^\'\"]*\"
Character = \'[^\'\"\\]?\'
Number = (0|([1-9][0-9]*))("."[0-9]+)?

// Keywords
Loop = "for"|"foreach"|"while"|"do"|"Each"
DataType = "int"|"int8"|"int16"|"int32"|"int64"|"string"|"boolean"|"float"|"decimal"|"date"|"char"|"byte"|"var"|"complex"|"long"|"short"|"double"|"time"
Conditional = "if"|"elif"|"switch"|"case"|"ALL"|"ANY"|"EXISTS"|"HAVING"|"LIKE"|"WHERE"
Consequence = "else"|"finally"
Function = "def"|"void"|"lambda"|"PROCEDURE"
Execute = "EXEC"|"Call"
Try = "try"|"assert"|"with"
Exception = "throw"|"raise"|"catch"|"except"
Comment = "/*"|"*/"|"#"|"TODO"|"FIXME"
AccesMod = "nonlocal"|"global"|"public"|"private"|"protected"|"default"
NonAccesMod = "const"|"final"|"abstract"|"static"|"transient"|"synchronized"|"volatile"
Separator = "("|")"|"{"|"}"|"["|"]"|";"|","|"."|":"
Class = "class"|"super"
Interface = "interface"
Enum = "enum"
Inherited = "extends"|"implements"
Break = "break"
Continue = "continue"
Pass = "pass"
Importing = "import"|"from"|"requires"|"native"
Return = "return"|"yield"
Create = "new"|"CREATE"
Delete = "del"|"DELETE"|"DROP"|"TRUNCATE"
Reference = "this"|"self"|"throws"|"AddressOf"|"Delegate"
Alias = "as"|"Alias"
Asynchronous = "await"|"async"
Package = "package"
Print = "print"

// VisualBasic
Handler = "AddHandler"
Modifier = "ByRef"|"ByVal"|"strictfp"
Storage = "Dim"
Cast = "DirectCast"

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

{Loop}          {printResult("Iterador", yytext(), yyline, yycolumn);}
{DataType}      {printResult("Tipo de dato", yytext(), yyline, yycolumn);}
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
{Number}        {printResult("Numero", yytext(), yyline, yycolumn);}
//{}{printResult("", yytext(), yyline, yycolumn);}

[^] {/* Ignore unmatched characters */}