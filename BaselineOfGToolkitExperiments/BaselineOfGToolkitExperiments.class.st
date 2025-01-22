Class {
	#name : #BaselineOfGToolkitExperiments,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitExperiments
}

{ #category : #'as yet unclassified' }
BaselineOfGToolkitExperiments >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec package: 'ContinuousDelivery'.
		spec package: 'DrawingTool' ].
]

{ #category : #'as yet unclassified' }
BaselineOfGToolkitExperiments >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'GTCD' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]
