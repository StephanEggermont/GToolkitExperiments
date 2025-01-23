Class {
	#name : #DTCardSortingDragHandler,
	#superclass : #DTPaneCreatingReorderingHandler,
	#instVars : [
		'model'
	],
	#category : #DrawingTool
}

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
		self addPaneWith: draggable at: anEvent].
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
