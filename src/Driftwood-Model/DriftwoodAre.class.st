Class {
	#name : #DriftwoodAre,
	#superclass : #CMSpatialEntityElement,
	#instVars : [
		'state',
		'hasStone'
	],
	#category : #'Driftwood-Model'
}

{ #category : #accessing }
DriftwoodAre >> hasStone [

	^ hasStone
]

{ #category : #accessing }
DriftwoodAre >> hasStone: aBoolean [

	hasStone := aBoolean  
]

{ #category : #testing }
DriftwoodAre >> isAccessible [

	^ state = #accessible
]

{ #category : #testing }
DriftwoodAre >> isInaccessible [

	^ self isAccessible not
]

{ #category : #testing }
DriftwoodAre >> makeAccessible [

	state := #accessible
]

{ #category : #testing }
DriftwoodAre >> makeInaccessible [

	state := #inaccessible
]

{ #category : #pov }
DriftwoodAre >> pov [

	(self hasOccupantsOfClass: DriftwoodDriftwood)
		ifTrue: [ ^ Color fromHexString: 'a46c2c' ].

	 self hasStone
		ifTrue: [ ^ Color purple ].
		
	self isAccessible
		ifTrue: [ ^ Color yellow ]
		ifFalse: [ ^ Color blue ]
		

]

{ #category : #stepping }
DriftwoodAre >> step [

	self neighbourhood size = 8 ifFalse: [ ^ self ].

	self isAccessible
		ifTrue: [ self neighbourW isAccessible
			ifFalse: [ self makeInaccessible ] ]
]
