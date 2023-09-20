Class {
	#name : #DriftwoodModel,
	#superclass : #CMAbstractModel,
	#instVars : [
		'theDriftwoods',
		'theAres',
		'theCollectors',
		'tideCounter',
		'numberOfCollectors'
	],
	#category : #'Driftwood-Model'
}

{ #category : #init }
DriftwoodModel >> init [

	self createGridLines: 20 columns: 50 neighbourhood: 8 closed: true.
	
	
	self createN: numberOfCollectors randomlyLocatedAloneEntities: DriftwoodCollector .
	
	self displayPov: #pov of: DriftwoodCollector.
	
	self setHighTide.
]

{ #category : #initialization }
DriftwoodModel >> initialize [

	super initialize.
	
	numberOfCollectors := 10.
	
	theAres := OrderedCollection new.
	theCollectors := OrderedCollection new.
	
	tideCounter := 0.
]

{ #category : #initialization }
DriftwoodModel >> setHighTide [

	| index |
	
	theAres do: [ :each | each state: #inaccessible ].

	1 to: 50 do: [ :i |
		1 to: 15 do: [ :j |
			index := ((j-1) * 50) + i.
			(theAres at: index) state: #accessible ] ].
	

]

{ #category : #initialization }
DriftwoodModel >> setLowTide [

	| index |
	
	theAres do: [ :each | each state: #inaccessible ].

	1 to: 50 do: [ :i |
		1 to: 19 do: [ :j |
			index := ((j-1) * 50) + i.
			(theAres at: index) state: #accessible ] ]
]

{ #category : #control }
DriftwoodModel >> step: t [
	
	tideCounter := tideCounter + 1.
	
	tideCounter = 5 ifTrue: [ self setLowTide ].
	
	tideCounter = 10 ifTrue: [ 
		self setHighTide.
		tideCounter := 0 ]
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
