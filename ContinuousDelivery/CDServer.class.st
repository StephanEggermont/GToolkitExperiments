Class {
	#name : #CDServer,
	#superclass : #Object,
	#instVars : [
		'localEnvironment',
		'gtoolkitUpdater'
	],
	#category : #ContinuousDelivery
}

{ #category : #accessing }
CDServer >> gtoolkitUpdater [
	^gtoolkitUpdater
]

{ #category : #accessing }
CDServer >> initialize [
	localEnvironment := CDLocalEnvironment new.
	localEnvironment ensureDirectories.
	gtoolkitUpdater  := CDGToolkitUpdater new.
	gtoolkitUpdater getLatestVersion
]

{ #category : #accessing }
CDServer >> localEnvironment [
	^localEnvironment
]

{ #category : #accessing }
CDServer >> openAsApplication [
	localEnvironment openCardsInSpace.
	GtWorld allInstances do: [ :eachWorld | eachWorld removeShutdownListener ].
	GtWorld allInstances do: [ :eachWorld | eachWorld close ].
	Smalltalk snapshot: true andQuit: false
]

{ #category : #accessing }
CDServer >> run [
	(localEnvironment hasRelease: gtoolkitUpdater latestVersion) ifFalse: [
		gtoolkitUpdater getLatestVersion.
		gtoolkitUpdater updateIn: localEnvironment]
]
