# Execute Program

## Installation

You'll need to:
- Make sure that [`jflex`](#binaries) is available in your path.
- Download and extract [CUP](#binaries)'s `*.jar` files into a directory called `lib` in the root directory of the repository.

## Compilation and Running

You'll need GNU Make to compile the files:
```sh
cd AutomataJFlex/
make convert
make compile
```

Then, for running:
```sh
make run
```


# Resources

## Binaries
- [JFlex](https://www.jflex.de/) (Lexical analyzer generator)
- [CUP](http://www2.cs.tum.edu/projects/cup/) (LALR parser generator)

## Grammar
Complete set of grammar rules in:

    doc/grammar.ods

## Keywords
Complete list of keywords:

    doc/kws_list.csv

Total number of keywords = `300`<br>
Gathered from this sources:
- [GO DataTypes](https://www.geeksforgeeks.org/data-types-in-go/)
- [GO Keywords](https://go.dev/ref/spec#Keywords)
- [Java Keywords](https://www.w3schools.com/java/java_ref_keywords.asp)
- [Java Modifiers](https://www.w3schools.com/java/java_modifiers.asp)
- [Python Keywords](https://www.w3schools.com/python/python_ref_keywords.asp)
- [Python Operators](https://www.w3schools.com/python/python_operators.asp)
- [SQL Keywords](https://www.w3schools.com/sql/sql_ref_keywords.asp)
- [Visual Basic Keywords](https://learn.microsoft.com/en-us/dotnet/visual-basic/language-reference/keywords/)
