#!/bin/bash 

#Script for converting .flex and .cup to .java file
jflex --nobak -q -d src/main/ src/resources/Lexer.flex
jflex --nobak -q -d src/main/ src/resources/LexerCup.flex
java -jar lib/java-cup-11b.jar -locations -parser Parser -destdir src/main src/resources/Syntax.cup
