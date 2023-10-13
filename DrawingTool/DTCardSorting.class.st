Class {
	#name : #DTCardSorting,
	#superclass : #Object,
	#instVars : [
		'bar',
		'pane',
		'scene',
		'aSpace',
		'addNewCard',
		'newCardButton',
		'newCardEditor',
		'handler',
		'cardGroups',
		'textElement',
		'smallButton',
		'largeButton',
		'cardSize',
		'groupWidth'
	],
	#classInstVars : [
		'newCardButton'
	],
	#category : #'DrawingTool-Drag & Drop'
}

{ #category : #accessing }
DTCardSorting class >> open [
<gtExample>
	^self new open
]

{ #category : #accessing }
DTCardSorting >> addNewCard [
	| group el|
	group := (self columnBlock:1)value.
	el := self newCard: self newText.				
	group addChild: el.
	pane addChild: group.
	handler addPane: group.
]

{ #category : #accessing }
DTCardSorting >> columnBlock [
	^ [ BlElement new
		border: (BlBorder paint: Color lightGray lighter);
		background: Color yellow muchLighter muchLighter lighter;
		layout: BlFlowLayout new;
		margin: (BlInsets all: 2);
		padding: (BlInsets top: 10 left: 2 bottom: 2 right: 2);
		constraintsDo: [ :c | 
			c horizontal exact: groupWidth*3.
			c vertical fitContent ];
		addEventHandler: BlPullHandler new ]
]

{ #category : #accessing }
DTCardSorting >> columnBlock: nrOfColumns [
	^ [ BlElement new
		border: (BlBorder paint: Color lightGray lighter);
		background: Color yellow muchLighter muchLighter lighter;
		layout: BlFlowLayout new;
		margin: (BlInsets all: 2);
		padding: (BlInsets top: 10 left: 2 bottom: 2 right: 2);
		constraintsDo: [ :c | 
			c horizontal exact: groupWidth*nrOfColumns.
			c vertical fitContent ];
		addEventHandler: BlPullHandler new ]
]

{ #category : #accessing }
DTCardSorting >> contentsArea [

	| contentsPane |
	contentsPane := BlElement new
		size: 800 @ 600;
		background: Color lightGray muchLighter lighter;
		padding: (BlInsets all: 2);
		layout: BlBasicLayout new;
		yourself.
	cardGroups := OrderedCollection new.
	handler := DTPaneCreatingReorderingHandler new
		container: contentsPane;
		panes: cardGroups;
		yourself.
	^ contentsPane
]

{ #category : #accessing }
DTCardSorting >> handler [
	^handler
]

{ #category : #accessing }
DTCardSorting >> initialize [
	cardSize := 80@60.
	groupWidth := 86
]

{ #category : #accessing }
DTCardSorting >> large [
	cardSize := 120@80.
	groupWidth := 126
]

{ #category : #accessing }
DTCardSorting >> largeButton [
	^largeButton := BrButton new
		margin:
			(BlInsets
				top: 10
				left: 0
				bottom: 10
				right: 10);
		aptitude: BrRightLabelButtonAptitude;
		label: 'L'; 
		action: [ 
			self large];
		yourself.
]

{ #category : #accessing }
DTCardSorting >> newCard: aString [
	^DTCard new
		text: aString asRopedText;
		addEventHandler: handler;
		app: self;
		yourself.
]

{ #category : #accessing }
DTCardSorting >> newCardButton [
	^newCardButton := BrButton new
		margin:
			(BlInsets
				top: 10
				left: 0
				bottom: 10
				right: 10);
		aptitude: BrRectangularButtonAptitude;
		icon: BrGlamorousVectorIcons add;
		action: [ 
			self addNewCard.
			textElement text: ''.
			textElement requestFocus];
		yourself.
]

{ #category : #accessing }
DTCardSorting >> newCardEditor [
	^(BrEditor new
		aptitude: 
			(DTEditableLabelAptitude new
				glamorousRegularFont;
				fontSize: 14);
		margin:
			(BlInsets
				top: 11
				left: 10
				bottom: 7
				right: 10);
		padding: (BlInsets all: 2);
		text: '';
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination return;
				action: [ :anEvent | 
					self addNewCard.
					textElement text: ''.
					textElement requestFocus]);
		when: BrEditorAcceptWish
			do: [ :aWish | 
				self addNewCard.
				textElement text: ''.
				textElement requestFocus];
		yourself)
]

{ #category : #accessing }
DTCardSorting >> newText [
	^textElement text
]

{ #category : #accessing }
DTCardSorting >> open [
	textElement := self newCardEditor.
	bar := BlElement new
		size: 800 @ 40;
		background: Color lightGray muchLighter;
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 40 ];
		addChild: textElement;
		addChild: self newCardButton;
		addChild: self smallButton;
		addChild: self largeButton;
		yourself.
	pane := self contentsArea
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	scene := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout vertical;
		addChild: bar;
		addChild: pane;
		requestLayout;
		yourself.

	aSpace := BlSpace new
		addChild: scene;
		extent: 800 @ 600;
		title: 'Cards'.
	^ aSpace show
]

{ #category : #accessing }
DTCardSorting >> resizeContents [
]

{ #category : #accessing }
DTCardSorting >> small [
	cardSize := 80@60.
	groupWidth := 86.
	self resizeContents
]

{ #category : #accessing }
DTCardSorting >> smallButton [
	^smallButton := BrButton new
		margin:
			(BlInsets
				top: 10
				left: 10
				bottom: 10
				right: 0);
		aptitude: BrLeftLabelButtonAptitude;
		label: 'S'; 
		action: [ 
			self small];
		yourself.
]
