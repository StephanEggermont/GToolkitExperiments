Class {
	#name : #CDGtRelease,
	#superclass : #Object,
	#instVars : [
		'releasesPath',
		'releaseName',
		'imageData'
	],
	#category : #ContinuousDelivery
}

{ #category : #accessing }
CDGtRelease >> command [
	| command |
	self isNew ifFalse: [
		command := 'cd "' , self runPath
		, '" && '
		, CDPlatform current runCommand] 
		ifTrue: [
		command := 'cd "' , self runPath
		, '" && '
		, CDPlatform current newRunCommand		].
	^command
]

{ #category : #accessing }
CDGtRelease >> commit [
	|reference|
	reference := (releasesPath / releaseName / 'imageData.json') asFileReference.
	reference writeStreamDo: [ :w |
		w nextPutAll: (STON toString: imageData)]
]

{ #category : #accessing }
CDGtRelease >> gtButtonRun [
	| runButton |
	runButton := BrButton new.
	runButton
		aptitude:
			BrGlamorousButtonRectangularAptitude
				+ BrGlamorousButtonExteriorAptitude
				+ BrGlamorousButtonIconAptitude new.
	runButton icon: BrGlamorousVectorIcons play.
	runButton action: [ self run ].
	^ runButton
]

{ #category : #accessing }
CDGtRelease >> imageData [
	^imageData ifNil: [self readOrCreateImageData . imageData] 
	
]

{ #category : #accessing }
CDGtRelease >> imageSize [
	|image|
	image := self runPath asFileReference / 'GlamorousToolkit.image'.
	image exists ifFalse: [^'N/A'].
	^ image size asString
]

{ #category : #accessing }
CDGtRelease >> isNew [
	^releaseName numericSuffix > 900
]

{ #category : #accessing }
CDGtRelease >> modificationTime [
	|image|
	image := self runPath asFileReference / 'GlamorousToolkit.image'.
	image exists ifFalse: [^'N/A'].
	^ image modificationTime asStringYMDHM
]

{ #category : #accessing }
CDGtRelease >> readOrCreateImageData [
	|reference|
	reference := (releasesPath / releaseName / 'imageData.json') asFileReference.
	reference exists 
		ifFalse: [imageData := CDImageData new]
		ifTrue: [imageData := STON fromString:reference contents]
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
	 self isNew ifFalse: [
		^(releasesPath / releaseName / ('GlamorousToolkit', 
	CDPlatform current platformName, '64-', releaseName)) fullName]
	ifTrue: [
		^(releasesPath / releaseName) fullName
	]
]
