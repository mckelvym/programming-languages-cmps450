# Programming Languages (CMPS 450) Class Projects

## About

Class projects and files for Programming Languages (CMPS 450) in the Fall of 2007.

## ML Project

For this assignment you are to implement, using the Standard ML language, the Hindley-Milner type checking algorithm, as presented in class and in section 6.8 of the text, for a subset of ML.

Your solution should read in a sequence of ML statements and either output that the statements are type correct or report the first type error encountered if they are not.

Your solution should be able to correctly type check any ML statement composed of:

- Mathematical expressions involving the binary operators +, -, *, /, div, and mod
- String expressions involving the binary operator ^
- List expressions involving the binary operators @ and ::
- val declarations for integer, real, boolean, string, list, and function variables.
- fun declarations where the parameters are all of the types listed above and whose return values are one of the above.
- let expressions with the same restrictions as those for fun declarations.
- if-then-else expressions which return one of the above types.

You are to use the symbol table from [symtab1.sml](ml_project/symtab1.sml). Also, [arith.sml](ml_project/arith.sml) contains code for properly parsing mathematical expressions which you must use as a foundation for your solution.

Here are some sample input functions you can use to read from a file, [input.sml](ml_project/input.sml)

NOTE TO HARLEQUIN USERS: Select "MLWorks2.0 + Basis" after installation and remove the first 3 lines of code from arith.sml before loading it into the listener.

You may assume that white spaces ( space character, newline, tab ) separate all keywords. 

## Smalltalk Project

You are to implement, using Little Smalltalk, a switch object that
mimics the behavior of the C++ switch statement. When using your
object one should be able to populate it with cases, each providing a
case value, associated block of code to execute, and an optional
break. This will simulate the "writing" of the switch statement in
C++. One should also be able to provide a switch value to the object
which will cause it to search through the known cases and execute the
appropriate blocks. This will simulate the runtime execution of the
C++ switch. Your object should also allow a default case to be
specified.

Once populated with cases your object should be persistent in that it
should be reusable. It should be possible to provide a switch value,
let the switch execute and then provide another switch value and let
it execute again. Such as when a C++ switch statement is embedded in a
loop statement.

Your object should, at a minimum, capture the behavior of the C++
switch statement.

## Snobol Project

You are to implement a recognizer for the Algol 60 programming language as defined in the Report 
on the Algorithmic Language Algol 60. Your implementation must be written in the Snobol4 programming language. 
You may use most of the Snobol4 interpreters available on the web or the Snobol4 interpreter on the UCS machines. 
You must indicate which compiler/interpreter you used when you turn in your project.
Please keep in mind that whatever you use must be available for the grader to use to grade your
project.

For this project, you should depart from the Algol 60 specification in the following ways:

- Ignore the "-" symbol in the <arithmetic operator> production in sections 2.3 and 3.3.1
- Use "and"，"or"，"not"，“->"，and "==" for "A"，"v", ja，and "=" respectively in sections 2.3 and 3.4.1
- Ignore all occurrences of <exponent part> and all occurrences of "" throughout the report
- Use "A" in place of "f" in all productions
- You may assume that there are no nested strings and that all strings begin with a single quote, end with a single quote and contain no single quotes.
- In section 4.7.1 the right hand side of production <parameter delimiter> should read: , I) <letter string> (:

In designing your solution you should only concern yourself with the syntactic or structural aspects of the language. You are not to concern yourself with the semantic
aspects of Algol 60. That is you are not concerned that a given program "makes sense". Your solution, when given a syntactically legal Algol 60 program should simply respond
with "Yes". When given anything else, your solution should respond with "No". Nothing else is expected or desired.
