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
		'newCardEditor'
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
DTCardSorting >> contentsArea [

	| contentsPane columnBlock toDo doing done columns handler |
	contentsPane := BlElement new
		size: 800 @ 600;
		background: Color lightGray muchLighter;
		padding: (BlInsets all: 2);
		layout: BlBasicLayout new;
		yourself.
	columnBlock := self columnBlock.
	toDo := columnBlock value.
	columns := {toDo} asOrderedCollection.
	handler := DTPaneCreatingReorderingHandler new
		container: contentsPane;
		panes: columns;
		yourself.
	columns do: [:column |
		column when: BlPullStartEvent do: [ handler makeLast: column]]. 
	contentsPane addChildren: columns.
	10
		timesRepeat: [ | element |
			element := BlElement new
				size: 80 @ 60;
				border: (BlBorder paint: Color black);
				background: Color random;
				margin: (BlInsets all: 2);
				addEventHandler: handler;
				yourself.
			toDo addChild: element ].
	^ contentsPane
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
		action: [ | subject toDo el|
			toDo := self columnBlock value.

			el := BlTextElement new
				text: newCardEditor text;
				size: 80 @ 60;
				border: (BlBorder paint: Color black);
				background: Color random;
				margin: (BlInsets all: 2);
				yourself.
			toDo addChild: el.
			pane addChild: toDo
			 ];
		yourself.
]

{ #category : #accessing }
DTCardSorting >> newCardEditor [
	^(BrEditableLabel new
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
			| valueString |
			valueString := aWish text asString trim.
			 ];
		yourself)
]

{ #category : #accessing }
DTCardSorting >> open [
	bar := BlElement new
		size: 800 @ 40;
		background: Color lightGray lighter;
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 40 ];
		addChild: self newCardEditor;
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
