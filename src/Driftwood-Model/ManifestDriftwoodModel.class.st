"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDriftwoodModel,
	#superclass : #PackageManifest,
	#category : #'Driftwood-Model-Manifest'
}

{ #category : #'code-critics' }
ManifestDriftwoodModel class >> ruleInconsistentMethodClassificationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#DriftwoodCollector #step #false)) #'2023-09-20T12:36:05.653516+02:00') )
]
