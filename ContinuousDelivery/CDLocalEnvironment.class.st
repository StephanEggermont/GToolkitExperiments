Class {
	#name : #CDLocalEnvironment,
	#superclass : #Object,
	#instVars : [
		'rootPath'
	],
	#category : #'ContinuousDelivery-ContinuousDelivery'
}

{ #category : #accessing }
CDLocalEnvironment >> defaultRootPath [
	^(OSEnvironment current at: 'GTPATH' ifAbsent: ['/home/stephan/Documents/gthome']) asPath
]

{ #category : #accessing }
CDLocalEnvironment >> downloadPath [
	^self rootPath / 'downloads'
]

{ #category : #accessing }
CDLocalEnvironment >> ensureDirectories [
	self rootPath asFileReference ensureCreateDirectory.
	self downloadPath asFileReference ensureCreateDirectory.
	self releasesPath asFileReference ensureCreateDirectory.
]

{ #category : #accessing }
CDLocalEnvironment >> gtReleasesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Releases' translated;
		priority: 55;
		items: [ (self releasesPath asFileReference ) children 
			collect: [ :each | CDGtRelease new 
				releasesPath: self releasesPath;
				releaseName: each basenameWithIndicator;
				yourself ] ];
		column: 'Name' translated text: [ :each | 
			each releaseName ];
		column: 'Run' icon: #gtButtonRun width: 100
]

{ #category : #accessing }
CDLocalEnvironment >> hasRelease: aVersionString [
	^ (self releasesPath / aVersionString) asFileReference exists
]

{ #category : #accessing }
CDLocalEnvironment >> releasesPath [
	^self rootPath / 'releases'
]

{ #category : #accessing }
CDLocalEnvironment >> rootPath [
	^rootPath ifNil: [self defaultRootPath]
]

{ #category : #accessing }
CDLocalEnvironment >> rootPath: aPath [
	rootPath := aPath
]
