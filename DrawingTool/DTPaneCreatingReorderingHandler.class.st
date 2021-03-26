Class {
	#name : #DTPaneCreatingReorderingHandler,
	#superclass : #DTMultiPaneReorderingHandler,
	#category : #'DrawingTool-Drag & Drop'
}

{ #category : #accessing }
DTPaneCreatingReorderingHandler >> columnBlock [
	^ [ BlElement new
		border: (BlBorder paint: Color lightGray lighter);
		background: Color yellow muchLighter muchLighter lighter;
		layout: BlFlowLayout new;
		margin: (BlInsets all: 2);
		padding: (BlInsets top: 10 left: 2 bottom: 2 right: 2);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		addEventHandler: BlPullHandler new ]
]

{ #category : #accessing }
DTPaneCreatingReorderingHandler >> dragStartEvent: anEvent [
	|draggable |
	anEvent consumed: true.
	draggable := anEvent currentTarget.
	parent := panes detect: [ :aPane | (aPane containsGlobalPoint: anEvent position) 
		and: [ draggable hasParent: aPane]].
	overlay := BlOverlayElement on: container.
	container parent addChild: overlay.

	"drag start position in parent"
	dragStartPosition := draggable globalPointToParent: anEvent position.

	"element position in parent"
	originalPosition := draggable position.
	placeholder := self placeholderFor: draggable.
	parent replaceChild: draggable with: placeholder.
	overlay addChild: draggable.

	anEvent currentTarget dispatchEvent: BlPullStartEvent new
]

{ #category : #accessing }
DTPaneCreatingReorderingHandler >> threeFittingColumns [
	<gtExample>
	| pane columnBlock toDo doing done columns handler |
	pane := BlElement new
		size: 800 @ 600;
		background: Color lightGray muchLighter;
		padding: (BlInsets all: 2);
		layout: BlBasicLayout new;
		yourself.
	columnBlock := self columnBlock.
	toDo := columnBlock value.
	doing := columnBlock value.
	done := columnBlock value.
	columns := {toDo.
	doing.
	done}.
	handler := self class new
		container: pane;
		panes: columns;
		yourself.
	pane addChildren: columns.
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
	^ pane
]
