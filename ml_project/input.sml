(* To open an input file use the openIn function with the name of
the file to open.  You will need to "open TextIO;" before you can
use the functons. *)

open TextIO;

val inFile = openIn("myinput.sml");


(* To read a single character use input1(inFile), to read n characters
from the input use the inputN function which takes an instream and an
integer and returns a string of characters. To consume the next line of
the input file use input with the instream. NOTE: input1 will return a
character option so the value will be
SOME char. *)

val ch = input1(inFile);
val str = inputN(inFile, 10);
val str1 = input(inFile);

(* To detect when the input has been consumed (end of file) use the
endOfStream function with the instream return by the above call
to open_in. 
You can use something like the following to read in the entire
input into a list of characters (something that tokens takes as an
argument), hint, hint, hint. *)

fun readList(file) =
	if endOfStream(file) then nil
	else explode(input(file))@readList(file);

(* you could use it in the following manner: *)

readList(openIn("symTab.sml"));
