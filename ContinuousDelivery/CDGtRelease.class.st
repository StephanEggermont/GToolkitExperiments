Class {
	#name : #CDGtRelease,
	#superclass : #Object,
	#instVars : [
		'releasesPath',
		'releaseName'
	],
	#category : #ContinuousDelivery
}

{ #category : #accessing }
CDGtRelease >> command [
	| command |
	command := 'cd "' , self runPath
		, '" &&  "'
		, './glamoroustoolkit" "GlamorousToolkit.image" "--no-quit" "--interactive" &'.
	^command
]

{ #category : #accessing }
CDGtRelease >> gtButtonRun [
	|runButton|
	runButton := BrButton new.
	runButton look: (BrGlamorousButtonRectangularLook + BrGlamorousButtonExteriorLook + 
		(BrGlamorousButtonIconLook  new)).
	runButton icon: BrGlamorousIcons play.
	runButton action: [ self run].
	^ runButton
]

{ #category : #accessing }
CDGtRelease >> gtButtonRun: anEnvironment [
	self halt
]

{ #category : #accessing }
CDGtRelease >> gtButtonRun: aMe env: anEnvironment [
	self halt
]

{ #category : #accessing }
CDGtRelease >> imageSize [
	|image|
	image := self runPath asFileReference / 'GlamorousToolkit.image'.
	image exists ifFalse: [^'N/A'].
	^ image size asString
]

{ #category : #accessing }
CDGtRelease >> modificationTime [
	|image|
	image := self runPath asFileReference / 'GlamorousToolkit.image'.
	image exists ifFalse: [^'N/A'].
	^ image modificationTime asString
]

{ #category : #accessing }
CDGtRelease >> releaseName [
	^releaseName
]

{ #category : #accessing }
CDGtRelease >> releaseName: aName [
	releaseName := aName
]

{ #category : #accessing }
CDGtRelease >> releasesPath [
	^releasesPath
]

{ #category : #accessing }
CDGtRelease >> releasesPath: aPath [
	releasesPath := aPath
]

{ #category : #accessing }
CDGtRelease >> run [

	LibC runCommand: self command
]

{ #category : #accessing }
CDGtRelease >> runPath [
	^releasesPath fullName, '/', releaseName, 'GlamorousToolkitLinux64-', releaseName
]
