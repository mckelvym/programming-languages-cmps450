Class Set:Collection
| list |
[
		new
				list <- List new
|
		add: newElement
				(list includes: newElement)
						ifFalse: [list add: newElement]
|
		remove: oldElement ifAbsent: exception Block
				list remove: oldElement ifAbsent exceptionBlock
|
		size
		^list size
|
		occurencesOf: anElement
		^(list includes: anElement) ifTrue: [ 1 ] ifFalse: [ 0 ]
|
		first
		^list first
|
		next
		^list next
]
