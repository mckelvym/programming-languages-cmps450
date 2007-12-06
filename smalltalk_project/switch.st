"Old version. Now use CSwitch."

Class switch Object cases defaultCase defaultIsSet
Methods switch 'all'
	"The following methods are meant to be 'public':"
	"new"
		"Create a new switch object."
	"switchValue:"
		"Provide a switch value to execute corresponding switch cases."
	"forCase:do:"
		"Add a case statement."
	"forBreakCase:do:"
		"Add a case statement with a break."
	"forCase:do:withBreak:"
		"Add a case statement and explicitly indicate a break or no break."
	"default:"
		"Add a default case to be executed."
	"caseExists:"
		"Determine if a case has been added."
	"show"
		"Print c++-like switch representation of all cases including default."
	"printCases"
		"Print internal representation of all numbered cases."
	"printDefault"
		"Print internal representation of default case."

	"All other methods are considered private and not meant to be used by the user."

	"Create a new switch object. No cases defined. Default is not specified."
	new
		| temp |
		cases <- #().
		defaultIsSet <- false.
|
	"Simulate runtime state of switch."
	switchValue: value
		value isShortInteger 
			ifFalse: [ 
				^ 'Error: value must be integer.' 
			].
		(self caseExists: value) 
			ifFalse: [ defaultIsSet 
				ifTrue: [ 
					^ defaultCase value 
				] 
				ifFalse: [ 
					^ 'No cases to execute.' 
				] 
			].
		"Execute block"
		(((self case: value) at: 2) value) print.
		((self case: value) at: 3) 
			ifFalse: [ 
				^ self fallThrough: (value + 1) 
			].
|
	"When a block of code has been executed and doesn't contain a break."
	fallThrough: value
		value isShortInteger 
			ifFalse: [ 
				^ 'Error: value must be integer.' 
			].

		"Check if value is out of range of case values."
		(((self caseAt: (cases size)) at: 1) < value)
			ifTrue: [ 	
				"Check if default case to execute."
				defaultIsSet
					ifTrue: [ 
						"Execute default case."
						(defaultCase value) print 
					]
			]
			ifFalse: [
				"Check if this case exists in the list of cases."
				(self caseExists: value)
					ifTrue: [ 
						"Execute value, see if it has a break."
						(((self case: value) at: 2) value) print.
						((self case: value) at: 3) 
							ifFalse: [ 
								"If no break, start checking for next case value."
								self fallThrough: (value + 1) 
							]
					]
					ifFalse: [ 
						"This case doesn't exist, start checking next case value."
						self fallThrough: (value + 1)
					]								
			].
|	
	"Add case without explicitly specifying break. Break will not be included."
	forCase: value do: block
		^(self forCase: value do: block withBreak: false)
|
	"Add case with a break without having to supply truth value. Break will be included."
	forBreakCase: value do: block
		^(self forCase: value do: block withBreak: true)
|
	"Add case with or without break depending on truth value."
	forCase: value do: block withBreak: truthValue
		| temp |
		value isShortInteger 
			ifFalse: [ 
				^ 'Error: case value must be an integer.' 
			].
		(truthValue isKindOf: Boolean) 
			ifFalse: [ 
				^ 'Error: withBreak value must be Boolean.' 
			].
		(self caseExists: value) 
			ifTrue: [ 
				^ 'Error: case ', value asString, ' already exists.' 
			].
		temp <- ((#() with: value) with: block) with: truthValue.
		cases <- cases with: temp.
		self sort.
		('Case ', value asString, ' added.') print
|
	"Add a default case."
	default: block
		defaultIsSet 
			ifTrue: [ (smalltalk getPrompt: 'Default case exists. Overwrite (y/n)? ') = 'y'
				ifTrue: [ 
					defaultCase <- block. ^ 'Default case changed.' 
				]
				ifFalse: [ 
					^ 'Default case unchanged.' 
				]
			].
		defaultIsSet <- true.
		defaultCase <- block.
		('Default case added.') print.
|
	"Sort the array with a bubble sort."
	sort: cases
		| swapped temp |
		(cases size <= 1) 
			ifTrue: [ 
				^ cases 
			].
		swapped <- false.
		(1 to: (cases size - 1)) 
			do: [ :i | ((self caseValueAt: i) > (self caseValueAt: (i + 1))) 
				ifTrue: [ 
					temp <- (cases at: i).
					cases <- (cases at: i put: (cases at: (i + 1))). 
					cases <- (cases at: (i + 1) put: temp). 
					swapped <- true
				]
			].
		swapped 
			ifTrue: [ 
				self sort: cases 
			] 
			ifFalse: [ 
				^ cases 
			]
|	
	"Call the sort method to sort the array."
	sort
		self sort: cases.
		^ self
|
	"Check if a certain case exists by its case value."
	caseExists: value
		| temp |
		value isShortInteger 
			ifFalse: [ 
				^ 'Error: value must be integer.' 
			].
		temp <- 1.
		(1 to: cases size) 
			do: [ :i | (value = ((cases at: i) at: 1)) 
					ifTrue: [
						^ true 
					]
				].
		^ false
|
	"Return a case by looking up the case value."
	case: value
		| temp |
		value isShortInteger 
			ifFalse: [ 
				^ 'Error: value must be integer.' 
			].
		temp <- 1.
		(1 to: cases size) 
			do: [ :i | (value = ((cases at: i) at: 1)) 
					ifTrue: [ 
						^ (cases at: i) 
					]
				].
		^ 'Error: case does not exist.' 
|	
	"Return a case at a specific index in the array."
	caseAt: value
		value isShortInteger 
			ifFalse: [ 
				^ 'Error: value must be integer.' 
			].
		(self caseExists: value) 
			ifFalse: [ 
				^ 'Error: case does not exist.' 
			].
		^(cases at: value)
|
	"Return the case value at a specific index in the array."
	caseValueAt: value
		value isShortInteger
			ifFalse: [ ^ 'Error: value must be integer.' ].
		(value <= (cases size)) 
			ifFalse: [ ^ 'Error: out of range.' ].
		^(cases at: value) at: 1.
|
	"Print c++-like representation of all cases."
	show
		'' print.
		('switch(someValue)') print.
		('{') print.
		(1 to: cases size) 
			do: [ :i | 
					('  case ', ((cases at: i) at: 1) asString, ': ') print.
					('    ', ((cases at: i) at: 2) asString, ';') print.
					((cases at: i) at: 3)
						ifTrue: [
							('    break;') print
						]
				].
		defaultIsSet
			ifTrue: [
				('  default:') print.
				('    ', defaultCase asString, ';') print
			].
		('}') print.
		'' print.
		^ self
|
	"Print numbered cases."
	printCases
		(cases = #()) 
			ifTrue: [ 
				'No cases defined.' print
			] 
			ifFalse: [ 
				^ cases 
			]
|
	"Print default case."
	printDefault
		defaultIsSet 
			ifTrue: [ 
				^ defaultCase 
			] 
			ifFalse: [ 
				'Default case has not been set.' print
			]
]
