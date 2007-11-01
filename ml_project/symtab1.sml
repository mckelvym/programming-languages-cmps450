(*
Class			CMPS450
Section			001
Problem			ML Type Checking Project
Name			McKelvy, James Markus
CLID			jmm0468
Due Date		10:15am December 6, 2007 (Thursday)
*)

open Array;
     
(* These are the basic types handled *)
datatype Atype = 
	 IntType
       | RealType
       | BoolType
       | ListType of Atype
       | NilType
       | FunType of (Atype * Atype)
       | StringType
       | Error;
	 
(* Id of a sym entry, to be looked up later *)
datatype idName = Token of string;
	 
(* A sym entry can be one of the following... *)
datatype symEntry = Empty
		  | Boundary of string
		  | Entry of ( idName * Atype );

(* Size of the symbol table *)	 
val symTab = array(1000,Empty);
    
val i = ref ~1;
    
(* Create a new scope such as in a let expression or function *)
fun newBoundary ( RibBoundary as Boundary(s), symTab ) =
    ( i := !i + 1; update(symTab,!i,RibBoundary))
    
(* Insert a new entry into the symbol table *)
fun insertEntry ( Item, symTab ) = 
    ( i := !i + 1; update(symTab,!i,Item))

(* Delete the last entry from the symbol table *)
fun deleteEntry ( symTab ) = 
    (update(symTab,!i,Empty);i := !i - 1)
    
(* Delete the last entry from the symbol table and replace it with a new entry *)
fun updateEntry ( Item, symTab ) = 
    ( deleteEntry(symTab); insertEntry(Item, symTab) )

(* Exit out of a scope, such as in a let expression or function *)
fun exitScope ( s, symTab ) =
    (let 
	 val entry = sub(symTab,!i);
     in
	 (case entry 
	   of Boundary bName => if bName = s then deleteEntry( symTab )
                                else ( i := !i - 1 )
	    | Entry( n, t) => (deleteEntry(symTab); exitScope(s, symTab))
	    | Empty => (i := !i - 1; exitScope(s, symTab)))
     end)
    
(* Lookup an id in the symbol table and return the type *)
fun lookup ( anId, symTab ) =
    let
	val j = ref 0;
	val ans = ref Error;
    in
	j := !i;
	while !j >= 0 do 
	    (case sub(symTab, !j)
              of Boundary bName => j := !j - 1
               | Entry( idName, t ) => if idName = anId then
                                           (j := ~1; ans := t)
                                       else (j := !j - 1; ans := Error)
               | _ => j := !j - 1);
	!ans
    end
