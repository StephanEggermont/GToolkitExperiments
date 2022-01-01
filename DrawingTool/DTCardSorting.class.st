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
		'textElement'
	],
	#classInstVars : [
		'newCardButton'
	],
	#category : #'DrawingTool-Drag & Drop'
}

{ #category : #accessing }
DTCardSorting class >> newMethod [
	"This is a new method"
]

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
			c horizontal exact: 86*3.
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
			c horizontal exact: 86*nrOfColumns.
			c vertical fitContent ];
		addEventHandler: BlPullHandler new ]
]

{ #category : #accessing }
DTCardSorting >> contentsArea [

	| contentsPane columnBlock cardGroup doing done |
	contentsPane := BlElement new
		size: 800 @ 600;
		background: Color lightGray muchLighter;
		padding: (BlInsets all: 2);
		layout: BlBasicLayout new;
		yourself.
	columnBlock := self columnBlock.
	cardGroup := columnBlock value.
	cardGroups := {cardGroup} asOrderedCollection.
	handler := DTPaneCreatingReorderingHandler new
		container: contentsPane;
		panes: cardGroups;
		yourself.
	cardGroups do: [:group |
		group when: BlPullStartEvent do: [ handler makeLast: group]]. 
	contentsPane addChildren: cardGroups.
	10
		timesRepeat: [ | element |
			element := self newCard: ''.
			cardGroup addChild: element ].
	^ contentsPane
]

{ #category : #accessing }
DTCardSorting >> newCard: aString [
	^BlTextElement new
		text: aString asRopedText;
		size: 74 @ 54;
		border: (BlBorder paint: Color black);
		background: Color random;
		margin: (BlInsets all: 2);
		padding: (BlInsets all: 3);
		
		addEventHandler: handler;
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
				top: 10
				left: 10
				bottom: 10
				right: 10);
		padding: (BlInsets all: 2);
		text: 'Prototype';
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
		background: Color lightGray lighter;
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 40 ];
		addChild: textElement;
		addChild: self newCardButton;
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
