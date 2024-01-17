Class {
	#name : #DriftwoodPile,
	#superclass : #CMAgent,
	#traits : 'TCMLocated',
	#classTraits : 'TCMLocated classTrait',
	#instVars : [
		'currentCharge',
		'owner',
		'location'
	],
	#category : #'Driftwood-Model'
}

{ #category : #initialization }
DriftwoodPile >> initialize [

	super initialize.
]
