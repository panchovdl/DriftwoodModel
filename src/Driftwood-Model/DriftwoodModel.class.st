Class {
	#name : #DriftwoodModel,
	#superclass : #CMAbstractModel,
	#instVars : [
		'theDriftwoods',
		'theAres',
		'theCollectors',
		'tideCounter',
		'numberOfCollectors',
		'numberOfDriftwoods'
	],
	#category : #'Driftwood-Model'
}

{ #category : #init }
DriftwoodModel >> init [

	self
		createGridLines: 20
		columns: 50
		neighbourhood: 8
		closed: true.

	self setHighTide.

	self
		createN: numberOfCollectors
		randomlyLocatedEntities: DriftwoodCollector
		constrainedBy: [ :cell | 
		cell hasNoOccupants and: [ cell isAccessible ] ].
	
	self
	createN: numberOfDriftwoods
		randomlyLocatedEntities: DriftwoodDriftwood 
		constrainedBy: [ :cell | 
		cell hasNoOccupants and: [ cell pov blue] ].

	self
		displayPov: #pov of: DriftwoodCollector;
		displayPov: #pov of: DriftwoodDriftwood
]

{ #category : #initialization }
DriftwoodModel >> initialize [

	super initialize.

	numberOfCollectors := 10.
	numberOfDriftwoods := 50.

	theAres := OrderedCollection new.
	theCollectors := OrderedCollection new.
	theDriftwoods := OrderedCollection new.

	tideCounter := 0
]

{ #category : #initialization }
DriftwoodModel >> setHighTide [

	| index |
	
	theAres do: [ :each | each makeInaccessible ].

	1 to: 50 do: [ :i |
		1 to: 15 do: [ :j |
			index := ((j-1) * 50) + i.
			(theAres at: index) makeAccessible ] ].
	

]

{ #category : #initialization }
DriftwoodModel >> setLowTide [

	| index |
	
	theAres do: [ :each | each makeInaccessible ].

	1 to: 50 do: [ :i |
		1 to: 19 do: [ :j |
			index := ((j-1) * 50) + i.
			(theAres at: index) makeAccessible ] ]
]

{ #category : #control }
DriftwoodModel >> step: t [
	
	tideCounter := tideCounter + 1.
	
	tideCounter = 5 ifTrue: [ self setLowTide ].
	
	tideCounter = 10 ifTrue: [ 
		self setHighTide.
		tideCounter := 0 ].
	
	self theCollectors do: #step
]

{ #category : #accessing }
DriftwoodModel >> theAres [

	<getterFor: #DriftwoodAre>
	^ theAres
]

{ #category : #accessing }
DriftwoodModel >> theCollectors [

	<getterFor: #DriftwoodCollector>
	^ theCollectors
]

{ #category : #accessing }
DriftwoodModel >> theDriftwoods [

	<getterFor: #DriftwoodDriftwood>
	^ theDriftwoods
]
