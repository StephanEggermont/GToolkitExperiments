Class {
	#name : #DTCardSortingDragHandler,
	#superclass : #DTPaneCreatingReorderingHandler,
	#instVars : [
		'model'
	],
	#category : #'DrawingTool-Drag & Drop'
}

{ #category : #'as yet unclassified' }
DTCardSortingDragHandler >> columnBlock [
	^ [ BlElement new
		border: (BlBorder paint: Color lightGray lighter);
		background: Color yellow muchLighter muchLighter lighter;
		layout: BlFlowLayout new;
		margin: (BlInsets all: 2);
		padding: (BlInsets top: 10 left: 2 bottom: 2 right: 2);
		constraintsDo: [ :c | 
			c horizontal exact: 86*3.
			c vertical fitContent ];
		addEventHandler: (DTGroupDragHandler new
			model: self model;
			yourself) ]
]

{ #category : #'as yet unclassified' }
DTCardSortingDragHandler >> dragEndEvent: anEvent [
	"anEvent consumed: true."
	| draggable |
	draggable := anEvent currentTarget.
	overlay removeChild: draggable.
	(parent containsGlobalPoint: anEvent position) ifTrue: [
		parent replaceChild: placeholder with: draggable.
		model drop: draggable at: anEvent position in: parent] 
	ifFalse: [ 
		parent removeChild: placeholder.
		self addPaneWith: draggable at: anEvent.
		model drop: draggable at: anEvent position].
	overlay detach.
	panes do: [:each | |nrOfChildren|
		nrOfChildren := each childrenCount.
		nrOfChildren = 0 ifTrue: [ container removeChild: each]
		ifFalse: [ each constraintsDo: [ :c | 
			c horizontal exact: 86*(nrOfChildren sqrt roundUpTo: 1)]].
].
	(panes removeAllSuchThat: [:each | each childrenCount = 0]).
	anEvent currentTarget dispatchEvent: BlPullEndEvent new
]

{ #category : #'as yet unclassified' }
DTCardSortingDragHandler >> dragStartEvent: anEvent [
	model dragStart: anEvent currentTarget position: anEvent position.
	super dragStartEvent: anEvent
]

{ #category : #accessing }
DTCardSortingDragHandler >> model [
	^ model
]

{ #category : #accessing }
DTCardSortingDragHandler >> model: anObject [
	model := anObject
]
