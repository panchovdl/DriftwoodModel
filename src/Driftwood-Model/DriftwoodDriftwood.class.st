Class {
	#name : #DriftwoodDriftwood,
	#superclass : #CMAgent,
	#traits : 'TCMLocated',
	#classTraits : 'TCMLocated classTrait',
	#instVars : [
		'state'
	],
	#category : #'Driftwood-Model'
}

{ #category : #initialization }
DriftwoodDriftwood >> initialize [

	super initialize.
]

{ #category : #pov }
DriftwoodDriftwood >> pov [

	^ Color transparent
]
