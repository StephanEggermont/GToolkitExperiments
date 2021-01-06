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
	^(OSEnvironment current at: 'GTPATH' ifAbsent: [FileLocator home / 'gt']) asPath
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
		items: [ ((self releasesPath asFileReference ) directories 
			collect: [ :each | CDGtRelease new 
				releasesPath: self releasesPath;
				releaseName: each basenameWithIndicator;
				yourself ]) sorted: [ :a :b | a releaseName < b releaseName]];
		column: 'Run' icon: #gtButtonRun width: 50;
		column: 'Name' translated text: [ :each | 
			each releaseName ];
		column: 'Size' translated text: [ :each | each imageSize ] width: 80;
		column: 'Changed' translated text: [ :each | each modificationTime]
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
