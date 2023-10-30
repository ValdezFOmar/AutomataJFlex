" Vim syntax file
" Language: Language for the parser of this repo


if exists("b:current_syntax")
  finish
endif

" Symbols
syn match mlOperator    "->"
syn match mlOperator    "<"
syn match mlOperator    "+"
syn match mlOperator    "-"
syn match mlOperator    "\*"
syn match mlOperator    "/"
syn match mlOperator    "%"
syn match mlOperator    "\*\*"
syn match mlOperator    "++"
syn match mlOperator    "="
syn match mlOperator    "+="
syn match mlOperator    "//="
syn match mlOperator    "&&"
syn match mlOperator    ">"
syn match mlOperator    "=="
syn match mlOperator    "!="
syn match mlOperator    "<="
syn match mlOperator    ">="
syn match mlOperator    "//"
syn match mlOperator    "--"
syn match mlOperator    "-="
syn match mlOperator    "*="
syn match mlOperator    "/="
syn match mlOperator    "**="
syn match mlOperator    "%="
syn match mlOperator    "&="
syn match mlOperator    "|="
syn match mlOperator    "^="
syn match mlOperator    ">>="
syn match mlOperator    "<\<="
syn match mlOperator    "||"

syn match mlDelimiter   "("
syn match mlDelimiter   ")"
syn match mlDelimiter   "{"
syn match mlDelimiter   "}"
syn match mlDelimiter   "\["
syn match mlDelimiter   "\]"
syn match mlDelimiter   "\."
syn match mlDelimiter   ","
syn match mlDelimiter   ":"
syn match mlDelimiter   ";"

" Language Keywords
syn keyword mlKeyword       and or AndAlso OrElse Xor mod package
syn keyword mlKeyword       class def PROCEDURE Sub func Call nextgroup=mlFunction skipwhite
syn keyword mlKeyword       EXEC brak End Exit return yield
syn keyword mlKeyword       Event of CHECK CONSTRAINT FOREIGN BACKUP
syn keyword mlKeyword       KEY PRIMARY KEY UNIQUE VIEW DATABASE
syn keyword mlStatement     print Stop SELECT TABLE
syn keyword mlConditional   if elif else switch case default
syn keyword mlRepeat        for do while
syn keyword mlException     try assert with throw raise 
syn keyword mlException     catch except Error RaiseEvent
syn keyword mlInclude       import from requires native Using
syn keyword mlBoolean       True true False false
syn keyword mlBoolean       null Null None Nothing

syn match   mlFunction	"\h\w*" display contained

" Data types
syn keyword mlType  int int8 int16 int32 int64 byte long 
syn keyword mlType  short SByte Single UInteger ULong UShort 
syn keyword mlType  uint uint8 uint16 uint32 uint64
syn keyword mlType  float decimal double float32 float64
syn keyword mlType  complex complex64 complex128
syn keyword mlType  boolean void
syn keyword mlType  string char
syn keyword mlType  date time Object
syn keyword mlType  list tuple dict Array Stack Queue


" Literal
syn match mlChar    "\'.\'"
syn match mlString  "\".\{-}\""
syn match mlNumber  "\<\([-\|+]\?\d\+\)\(\.\d\+\)\?\([Ee][+-]\?\d\+\)\?i\?"
" Number matches integers, decimals, and complex numbers
" with optional sign and scientific notation


" Comment
syn match   mlComment           "#.*$" contains=mlTodo
syn match   mlBlockComment      "/\*\_.\{-}\*/" contains=mlTodo
syn keyword mlTodo              FIXME TODO contained

" Syntax Highlighting
hi def link mlComment           Comment
hi def link mlBlockComment      Comment
hi def link mlTodo              Todo
hi def link mlInclude           Include
hi def link mlKeyword           Keyword
hi def link mlStatement         Statement
hi def link mlFunction          Function
hi def link mlException         Exception
hi def link mlRepeat            Repeat
hi def link mlConditional       Conditional
hi def link mlBoolean           Boolean
hi def link mlType              Type
hi def link mlOperator          Operator
hi def link mlString            String
hi def link mlChar              Character
hi def link mlNumber            Number
hi def link mlDelimiter         Delimiter

let b:current_syntax = "mylang"
