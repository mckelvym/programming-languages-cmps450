datatype Atype = IntType
               | RealType
               | ListType of Atype
               | FunType of  ( Atype * Atype )
               | StringType
	       | ErrorType;

datatype idName = Token of string;

datatype symEntry = Empty
		| Boundary of string
		| Entry of ( idName * Atype );

type symTab = symEntry list;

fun newBoundary (RibBoundary as Boundary(s), symTab) =
	RibBoundary::symTab

fun insertEntry( Item, [] ) = [ Item ]
 | insertEntry( Item, symTab ) Item::symTab

fun deleteEntry( Item, [] ) = []
	| deleteEntry( Item, First::symTab ) =
	  if Item = First then symTab
	  else First::deleteEntry(Item, symTab)

fun exitScope( s, [] ) = [Empty]
 | exitScope( s, Boundary(str)::symTab ) =
   if s = str then symTab else [Empty]
 | exitScope( s, Item::symTab ) = 
   exitScope( s, deleteEntry( Item, Item::symTab ))

fun lookup( anId, symTab ) =
 | lookup( anId, Empty::symTab ) = 
   		  lookup( anId, symTab )
 | lookup( anId, Boundary( s )::symTab ) =
   		  lookup( anId, symTab )
 | lookup( anId, Entry( varName, typeMark)::symTab ) =
   	if anId = varName then
   	   	typeMark
	else
		lookup( anId, symTab )
