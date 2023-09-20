Class {
	#name : #DriftwoodCollector,
	#superclass : #CMAgent,
	#traits : 'TCMLocated',
	#classTraits : 'TCMLocated classTrait',
	#instVars : [
		'status',
		'property',
		'carryingCapacity',
		'currentCharge',
		'distancePerception'
	],
	#category : #'Driftwood-Model'
}

{ #category : #accessing }
DriftwoodCollector >> carryingCapacity [

	^ carryingCapacity
]

{ #category : #accessing }
DriftwoodCollector >> carryingCapacity: anObject [

	carryingCapacity := anObject
]

{ #category : #accessing }
DriftwoodCollector >> currentCharge [

	^ currentCharge
]

{ #category : #accessing }
DriftwoodCollector >> currentCharge: anObject [

	currentCharge := anObject
]

{ #category : #accessing }
DriftwoodCollector >> distancePerception [

	^ distancePerception
]

{ #category : #accessing }
DriftwoodCollector >> distancePerception: anObject [

	distancePerception := anObject
]

{ #category : #accessing }
DriftwoodCollector >> initialize [

	super initialize.
	carryingCapacity := 5.
	currentCharge := OrderedCollection new.
	distancePerception := 5
]

{ #category : #stepping }
DriftwoodCollector >> lookForWood [ 
]

{ #category : #pov }
DriftwoodCollector >> pov [ 

	^ Color green
]

{ #category : #accessing }
DriftwoodCollector >> property [

	^ property
]

{ #category : #accessing }
DriftwoodCollector >> property: anObject [

	property := anObject
]

{ #category : #stepping }
DriftwoodCollector >> randomWalkOnBeach [

	| possibleDestinations |
	possibleDestinations := self patch neighbourhood select: [ :cell | 
		                        cell hasNoOccupants and: [ 
			                        cell isAccessible ] ].
	possibleDestinations isEmpty
		ifTrue: [ 
			self randomJumpConstrainedBy: [ :cell | 
				cell hasNoOccupants and: [ cell isAccessible ] ] ]
		ifFalse: [ 
			self randomWalkConstrainedBy: [ :cell | 
				cell hasNoOccupants and: [ cell isAccessible ] ] ]
]

{ #category : #accessing }
DriftwoodCollector >> status [

	^ status
]

{ #category : #accessing }
DriftwoodCollector >> status: anObject [

	status := anObject
]

{ #category : #stepping }
DriftwoodCollector >> step [

	self currentCharge size >= self carryingCapacity
		ifTrue: [ self goBacktoPile ]
		ifFalse: [ self lookForWood ]
]
