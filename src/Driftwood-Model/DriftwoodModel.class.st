Class {
	#name : #DriftwoodModel,
	#superclass : #CMAbstractModel,
	#instVars : [
		'theDriftwoods',
		'theAres',
		'theCollectors',
		'tideCounter',
		'numberOfCollectors',
		'numberOfDriftwoods',
		'thePiles'
	],
	#category : #'Driftwood-Model'
}

{ #category : #'- probes' }
DriftwoodModel class >> colorOfProbe_numberOfCollectedDriftwood [
  ^ Color red
]

{ #category : #'- probes' }
DriftwoodModel class >> colorOfProbe_numberOfLeftDriftwood [
  ^ (Color r: 0.08406647116324535 g: 0.08406647116324535 b: 0.6011730205278593 alpha: 1.0)
]

{ #category : #'as yet unclassified' }
DriftwoodModel >> createStoneCell [

| aSubCollec |
aSubCollec := (self pickN: 20 entities: DriftwoodAre  constrainedBy: [:c | c isAccessible ]).
	aSubCollec do: [ :v | v hasStone: true ].

]

{ #category : #init }
DriftwoodModel >> init [

	self
		createGridLines: 20
		columns: 50
		neighbourhood: 8
		closed: true.
self theAres do: [ :c | c hasStone: false ].
	self pickCellConstrainedBy: [ :cell |  cell isAccessible ].
	
	
 
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
		cell hasNoOccupants and: [ cell isInaccessible ] ].

	self
		displayPov: #pov of: DriftwoodCollector;
		displayPov: #pov of: DriftwoodDriftwood.
		
	self createStoneCell.
]

{ #category : #initialization }
DriftwoodModel >> initialize [

	super initialize.

	numberOfCollectors := 10.
	numberOfDriftwoods := 50.

	theAres := OrderedCollection new.
	theCollectors := OrderedCollection new.
	theDriftwoods := OrderedCollection new.
	thePiles := OrderedCollection new.
	

	tideCounter := 0
]

{ #category : #'as yet unclassified' }
DriftwoodModel >> moveWaterToPosition: aRowNumber [

	| index |
	
	theAres do: [ :each | each makeInaccessible ].

	1 to: 50 do: [ :i |
		1 to: aRowNumber do: [ :j |
			index := ((j-1) * 50) + i.
			(theAres at: index) makeAccessible ] ].
	
]

{ #category : #probes }
DriftwoodModel >> numberOfCollectedDriftwood [
	<probe>
	^ self theDriftwoods size - self numberOfLeftDriftwood 
]

{ #category : #probes }
DriftwoodModel >> numberOfLeftDriftwood [
	<probe>
	^ (self theDriftwoods select: [ :each | each isSituated ]) size
]

{ #category : #initialization }
DriftwoodModel >> setHighTide [

	self moveWaterToPosition: 15.
	self teleportCollectorsAwayFromWater.

]

{ #category : #initialization }
DriftwoodModel >> setLowTide [

	self moveWaterToPosition: 19.
]

{ #category : #control }
DriftwoodModel >> step: t [
	
	tideCounter := tideCounter + 1.
	
	tideCounter = 20 ifTrue: [ self setLowTide ].
	
	tideCounter = 40 ifTrue: [ 
		self setHighTide.
		tideCounter := 0 ].
	
	self theCollectors do: #step
]

{ #category : #'as yet unclassified' }
DriftwoodModel >> teleportCollectorsAwayFromWater [

	theCollectors do: [ :each |
		each patch isInaccessible ifTrue: [ 
			each randomJumpConstrainedBy: [ :patch | patch isAccessible ] ] ]
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

{ #category : #accessing }
DriftwoodModel >> thePiles [

	<getterFor: #DriftwoodPile>
	^ thePiles
]
