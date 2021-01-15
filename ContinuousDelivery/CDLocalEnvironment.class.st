Class {
	#name : #CDLocalEnvironment,
	#superclass : #Object,
	#instVars : [
		'rootPath',
		'server'
	],
	#category : #'ContinuousDelivery-ContinuousDelivery'
}

{ #category : #accessing }
CDLocalEnvironment class >> on: aCDServer [
	^ self new
		server: aCDServer;
		yourself
]

{ #category : #accessing }
CDLocalEnvironment >> columnsFor: items handler: handler [ 
	|columns|
	columns := OrderedCollection new.
	columns add: (CDProjectColumn new project: ''; yourself).
	items do: [ :each | |foundColumn projectTitle|
		projectTitle := each imageData project.
		foundColumn := columns detect: [:column | column project =  projectTitle]
			ifNone: [columns add: (CDProjectColumn new project: projectTitle; yourself)].
		foundColumn pane addChild: (CDReleaseCard new release: each; addEventHandler: handler; yourself)].
	^columns.
]

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
CDLocalEnvironment >> gtButton [
	^ BrButton new
		margin:
			(BlInsets
				top: 10
				left: 10
				bottom: 10
				right: 0);
		label: 'Open Development Environment';
		look: BrLeftButtonLook;
		icon: BrGlamorousVectorIcons gt;
		action: [ GtWorld openDefault ];
		yourself
]

{ #category : #accessing }
CDLocalEnvironment >> gtCardsFor: aView [
	<gtView>
	| columns handler |
	^ aView explicit
		title: 'Cards' translated;
		priority: 45;
		stencil: [ | items pane bar scene gtButton runButton |
			items := self releases.
			gtButton := self gtButton.
			runButton := self runButton.
			bar := BlElement new
				size: 800 @ 40;
				background: Color lightGray muchLighter;
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical exact: 40 ];
				addChild: gtButton;
				addChild: runButton;
				yourself.
			pane := BlElement new
				size: 800@600;
				background: Color lightGray muchLighter;
				padding: (BlInsets all: 2);
				layout: BlLinearLayout horizontal;
				yourself.
			handler := DTMultiPaneReorderingHandler new.
			columns := self columnsFor: items handler: handler.
			handler
				container: pane;
				panes: (columns collect: #pane).
			pane addChildren: columns.
			pane constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ].
	
			scene := BlElement new
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				layout: BlLinearLayout vertical;
				addChild: bar;
				addChild: pane;
				yourself ]
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
				releaseName: each basename;
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
CDLocalEnvironment >> openCardsInSpace [
| space |
	space := BlSpace new.
	(self gtCardsFor: GtPhlowEmptyView new)
   	asElementDo: [ :anAppElement | space addChild: anAppElement ].
	space title: 'Launcher'.
	space show
]

{ #category : #accessing }
CDLocalEnvironment >> releases [
	^ self releasesPath asFileReference directories
		collect: [ :each | 
			CDGtRelease new
				releasesPath: self releasesPath;
				releaseName: each basename;
				yourself ]
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

{ #category : #accessing }
CDLocalEnvironment >> runButton [
	^ BrButton new
		margin:
			(BlInsets
				top: 10
				left: 0
				bottom: 10
				right: 10);
		label: 'Check & Download Update';
		look: BrRightButtonLook;
		icon: BrGlamorousVectorIcons play;
		action: [ server run ];
		yourself
]

{ #category : #accessing }
CDLocalEnvironment >> server: aCDServer [ 
	server := aCDServer
]
