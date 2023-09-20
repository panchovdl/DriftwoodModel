Class {
	#name : #DriftwoodAre,
	#superclass : #CMSpatialEntityElement,
	#instVars : [
		'state',
		'hasStone'
	],
	#category : #'Driftwood-Model'
}

{ #category : #testing }
DriftwoodAre >> isAccessible [

	^ state = #accessible
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

	^ self isAccessible
		ifTrue: [ Color yellow ]
		ifFalse: [ Color blue ]
]

{ #category : #stepping }
DriftwoodAre >> step [

	self neighbourhood size = 8 ifFalse: [ ^ self ].

	self isAccessible
		ifTrue: [ self neighbourW isAccessible
			ifFalse: [ self makeInaccessible ] ]
]
