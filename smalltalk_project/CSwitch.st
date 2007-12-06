"Class -------- CMPS450" 
"Section ------ 001"
"Problem ------ Little Smalltalk Project"
"Name --------- McKelvy, James Markus"
"CLID --------- jmm0468"
"Due Date ----- 10:15am December 6, 2007 (Thursday)"

Class CSwitch Object cases defaultIsSet
Methods CSwitch 'all'

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
		"Add a default case with no break to be executed."
	"default:withBreak:"
		"Add a default case with or without a break to be executed."

	"caseExists:"
		"Determine if a case has been added."
	"defaultExists"
		"Check if the default case has been set."
	"show"
		"Print c++-like switch representation of all cases including default."

	"All other methods are considered private and not meant to be used by the"
	"user."


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
				^ 'Error: value must be an integer.' 
			].
		(self caseExists: value) 
			ifFalse: [ defaultIsSet 
				ifTrue: [ 
					(1 to: (cases size))
						do: [ :i | ((cases at: i) at: 1) isShortInteger
								ifFalse: [ 
									(((cases at: i) at: 2) value) print.
									((cases at: i) at: 3)
										ifFalse: [
											^ self fallThrough: (i + 1)
										]
								]
							]
				] 
				ifFalse: [ ((cases size) > 0)
					ifTrue: [
						^ 'No case by that value, no default to execute.'
					]
					ifFalse: [ 
						^ 'No cases to execute.' 
					]
				] 
			].
		"Execute block"
		(1 to: (cases size))
			do: [ :i | ((cases at: i) at: 1) isShortInteger
					ifTrue: [ (value = ((cases at: i) at: 1))
						ifTrue: [
							(((cases at: i) at: 2) value) print.
							((cases at: i) at: 3)
								ifFalse: [
									^ self fallThrough: (i + 1)
								]
						]
					]
				].
|
	"When a block of code has been executed and doesn't contain a break."
	fallThrough: index
		index isShortInteger 
			ifFalse: [ 
				^ 'Error: value must be an integer.' 
			].
		(index > -1)
			ifFalse: [
				^ 'Error: value out of index range.' 
			].
		((cases size) < index)
			ifFalse: [
				(((cases at: index) at: 2) value) print.
				((cases at: index) at: 3)
					ifFalse: [
						^ self fallThrough: (index + 1)
					]
			]
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
		('Case ', value asString, ' added.') print.
		^ self
|
	"Add a default case with no break."
	default: block
		^(self default: block withBreak: false)
|
	"Add a default case and explicitly specify a break or no break."
	default: block withBreak: truthValue
		| temp |
		(truthValue isKindOf: Boolean)
			ifFalse: [
				^ 'Error: withBreak value must be Boolean.'
			].
		defaultIsSet 
			ifTrue: [ 
				^ 'Error: Default case exists.' 
			].
		defaultIsSet <- true.
		temp <- ((#() with: #default) with: block) with: truthValue.
		cases <- cases with: temp.
		('Default case added.') print.
		^ self
|
	"Check if a certain case exists by its case value."
	caseExists: value
		value isShortInteger 
			ifFalse: [ 
				^ 'Error: value must be an integer.' 
			].
		(1 to: cases size) 
			do: [ :i | ((cases at: i) at: 1) isShortInteger
					ifTrue: [ (value = ((cases at: i) at: 1)) 
						ifTrue: [
							^ true 
						]
					]
				].
		^ false
|
	"Check if the default case has been set."
	defaultExists
		^ defaultIsSet
|
	"Get the case that is the default case."
	default
		defaultIsSet ifFalse: [ ^ 'Error: No default case defined.' ].
		(1 to: cases size)
			do: [ :i | ((cases at: i) at: 1) isShortInteger
					ifFalse: [ ^ (cases at: i) ]
				].
		^ 'Error: No default case defined.'

|	
	"Return a case at a specific index in the array."
	caseAt: value
		value isShortInteger 
			ifFalse: [ 
				^ 'Error: value must be an integer.' 
			].
		(value > -1)
			ifFalse: [
				^ 'Error: value out of index range.' 
			].
		(value > (cases size))
			ifTrue: [
				^ 'Error: value is greater than the number of cases.'
			].
		^(cases at: value)
|
	"Print c++-like representation of all cases."
	show
		'' print.
		('switch(someValue)') print.
		('{') print.
		(1 to: cases size) 
			do: [ :i | ((cases at: i) at: 1) isShortInteger
					ifTrue: [
						('  case ', ((cases at: i) at: 1) asString, ': ') print.
						('    ', ((cases at: i) at: 2) asString, ';') print.
						((cases at: i) at: 3)
							ifTrue: [
								('    break;') print
							]
					]
					ifFalse: [
						('  default:') print.
						('    ', ((cases at: i) at: 2) asString, ';') print.
						((cases at: i) at: 3)
							ifTrue: [
								('    break;') print
							]
					]
				].
		('}') print.
		'' print.
		^ self
]
