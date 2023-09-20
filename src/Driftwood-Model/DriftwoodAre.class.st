Class {
	#name : #DriftwoodAre,
	#superclass : #CMSpatialEntityElement,
	#instVars : [
		'state'
	],
	#category : #'Driftwood-Model'
}

{ #category : #pov }
DriftwoodAre >> pov [

	^ state = #accessible
		ifTrue: [ Color yellow ]
		ifFalse: [ Color blue ]
]

{ #category : #accessing }
DriftwoodAre >> state [

	^ state
]

{ #category : #accessing }
DriftwoodAre >> state: anObject [

	state := anObject
]

{ #category : #stepping }
DriftwoodAre >> step [

	self neighbourhood size = 8 ifFalse: [ ^ self ].

	state = #accessible
		ifTrue: [ self neighbourW  state = #accessible
			ifFalse: [ self state: #inaccessible ] ]
]
