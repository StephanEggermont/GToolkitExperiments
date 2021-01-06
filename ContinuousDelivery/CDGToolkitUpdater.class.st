Class {
	#name : #CDGToolkitUpdater,
	#superclass : #Object,
	#instVars : [
		'lastUpdated',
		'latestVersion',
		'zipName'
	],
	#category : #ContinuousDelivery
}

{ #category : #accessing }
CDGToolkitUpdater >> downloadUpdate: aLocalEnvironment [
	| downloadLink |
	downloadLink := 'https://dl.feenk.com/gt/', zipName.
	ZnClient new
		url: downloadLink;
		downloadTo: aLocalEnvironment downloadPath
]

{ #category : #accessing }
CDGToolkitUpdater >> extractUpdate: aLocalEnvironment [
	| command |
	command := 'cd "' , aLocalEnvironment downloadPath fullName
		, '" && unzip ', zipName, ' -d "'
		, (aLocalEnvironment releasesPath / latestVersion) fullName
		, '"'.
	LibC runCommand: command.
	^ command
]

{ #category : #accessing }
CDGToolkitUpdater >> getLatestVersion [
	|foundVersion|
	foundVersion := (STONJSON fromString: (ZnEasy get: 'https://api.github.com/repos/feenkcom/gtoolkit/releases/latest') contents) at: #tag_name.
	lastUpdated := DateAndTime now.
	latestVersion := foundVersion
]

{ #category : #accessing }
CDGToolkitUpdater >> lastUpdated [
	^lastUpdated 
]

{ #category : #accessing }
CDGToolkitUpdater >> latestVersion [
	^latestVersion
]

{ #category : #accessing }
CDGToolkitUpdater >> moveDownloadedZip: aLocalEnvironment [
	| command |
	command := 'mv "' ,( aLocalEnvironment downloadPath / zipName) fullName,'" "'
		, (aLocalEnvironment releasesPath / latestVersion) fullName
		, '"'.
	LibC runCommand: command.
	^ command
]

{ #category : #accessing }
CDGToolkitUpdater >> updateIn: aLocalEnvironment [
	zipName := 'GlamorousToolkit', CDPlatform current platformName, '64-release.zip'. 
	self downloadUpdate: aLocalEnvironment.
	self extractUpdate: aLocalEnvironment.
	self moveDownloadedZip: aLocalEnvironment
]
