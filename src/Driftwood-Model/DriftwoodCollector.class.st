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

{ #category : #stepping }
DriftwoodCollector >> collectWood [

	| driftwood aPiece |
	driftwood := self patch occupantsOfClass: DriftwoodDriftwood.


			(carryingCapacity - currentCharge size min: driftwood size) 
				timesRepeat: [ 
					aPiece := driftwood first.
					currentCharge add: aPiece.
					aPiece leave.
					driftwood remove: aPiece ] 

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

	^ distancePerception ifNil: [ distancePerception := 5 ]
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

	| driftwood |
	
	
	
	driftwood := self patch occupantsOfClass: DriftwoodDriftwood.
	driftwood ifNotEmpty: [ self collectWood ]
		ifEmpty: [ self lookWoodAround ]
]

{ #category : #stepping }
DriftwoodCollector >> lookWoodAround [
		
	| woods nearestWood |
	
	woods := self locatedEntities: #DriftwoodDriftwood withinRadius: distancePerception.
	woods := woods select: [ :each | each patch isAccessible ].
	
	woods ifEmpty: [ 
		self randomWalkOnBeach.
		^ self ].
	
	nearestWood := woods anyOne.
	
	woods do: [ :each |
		(self patch distanceTo: each patch) < (self patch distanceTo: nearestWood patch)
			ifTrue: [ nearestWood := each ] ].
		
	self moveTowards: nearestWood patch.
	
	"| found n woods destination |
	
	found := false.
	n := 0. 
	
	[ n < distancePerception and: [ found not ] ] whileTrue: [ 
		n := n + 1.
		woods := self locatedEntities: #DriftwoodDriftwood withinRadius: n.
		
		woods ifNotEmpty: [ 
			found := true.
			destination := woods first patch ] ].
	
	found
		ifTrue: [ self moveTowards: destination ]
		ifFalse: [ self randomWalkOnBeach ]"
]

{ #category : #pov }
DriftwoodCollector >> pov [ 

	^ Color fromHexString: '388e3c'
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
DriftwoodCollector >> shapeOfPOV [ 

	^ #arrow
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
