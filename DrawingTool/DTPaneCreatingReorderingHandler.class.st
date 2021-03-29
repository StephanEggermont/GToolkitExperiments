"
!A drag and drop handler for grouping and ordering elements
As a subclass of ${class:BlCustomEventHandler}$ I need to specify which events I want to handle. As a drag-and-drop handler, they are defineed in ${method:DTReorderingHandler>>#eventsToHandle}$. The container is the parent element of the groups and elements. It limits where they can be dragged. Panes are the groups that can be moved around using a BlPullHandler. I am attached to each individual element, not to the groups. I am shared between those individual elements. 
!! Handling the start of drag
The element that is going to be dragged is the currentTarget of the event. Let's call it the dragable. To correctly position it later, record the offset from its position in draggableOffset. The draggable can be in a group, and so also record its position relative to its parent (the group) in dragStartPosition. 
!!!!Overlay
The group often has a layout interfering withthe smooth dragging of the draggable, so create an overlay for the container and add it to the container. Create a placeholder for the draggable, and swap the draggable for it in the pane. Put the draggable in the overlay.  
!!Dragging
When moving the mouse, the placeholder should provide a preview of what happens when the dragging stops. As long as the mouse position is still over the current group and that is the topmost group, the placeholder will be swapped with the element currently under the cursor. If the mouse moves over a different group, the placeholder needs to be swapped with the corresponding child of the new group. At the moment, the placeholder remains on the last group it was on when the mouse position is over the container, but not over a group. Both the old and the new group get to be re-layout to be as square as possible. The event has a global position, but the draggable is now in an overlay of the container that has local coordinates. 
!!Dropping
When dropping, the draggable is first  removed from the overlay, so the overlay can be disposed of. If the mouse position is still over the group, the placeholder is swapped with the draggable. Otherwise, a new group is created ad added to the container containing the draggable. The groups are re-layouted, and empty groups are removed.
"
Class {
	#name : #DTPaneCreatingReorderingHandler,
	#superclass : #DTMultiPaneReorderingHandler,
	#instVars : [
		'draggableOffset'
	],
	#category : #'DrawingTool-Drag & Drop'
}

{ #category : #accessing }
DTPaneCreatingReorderingHandler >> addPaneWith: draggable at: anEvent [ 
	|column|
	column := self columnBlock value.
	panes add: column.
	column addChild: draggable.
	container addChild: column.
	column relocate: (column globalPointToParent: anEvent position) - draggableOffset + (-4@ -12). 
	column when: BlPullStartEvent do: [ self makeLast: column]. 

]

{ #category : #accessing }
DTPaneCreatingReorderingHandler >> columnBlock [
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
DTPaneCreatingReorderingHandler >> dragEndEvent: anEvent [
	"anEvent consumed: true."
	| draggable |
	draggable := anEvent currentTarget.
	overlay removeChild: draggable.
	(parent containsGlobalPoint: anEvent position) ifTrue: [
		parent replaceChild: placeholder with: draggable] 
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
	draggableOffset := dragStartPosition - draggable position.
	"element position in parent"
	originalPosition := draggable position.
	placeholder := self placeholderFor: draggable.
	parent replaceChild: draggable with: placeholder.
	overlay addChild: draggable.

	anEvent currentTarget dispatchEvent: BlPullStartEvent new
]

{ #category : #accessing }
DTPaneCreatingReorderingHandler >> fittingColumns [
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
	columns := {toDo} asOrderedCollection.
	handler := self class new
		container: pane;
		panes: columns;
		yourself.
	columns do: [:column |
		column when: BlPullStartEvent do: [ handler makeLast: column]]. 
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

{ #category : #accessing }
DTPaneCreatingReorderingHandler >> makeLast: aPane [
	panes swap: (panes indexOf: aPane) with: panes size.
	container removeChildren.
	container addChildren: panes
]

{ #category : #accessing }
DTPaneCreatingReorderingHandler >> movePlaceholderToCorrectParent: anEvent [
	| currentPane |
	currentPane := panes reversed
		detect: [ :aPane |(aPane containsGlobalPoint: anEvent position)]
	ifNone: [ parent ].
	currentPane = parent
		ifFalse: [ 
			parent removeChild: placeholder.
			parent constraintsDo: [ :c | 
				c horizontal exact: 86*(parent childrenCount sqrt roundUpTo: 1)].
			parent := currentPane.
			parent addChild: placeholder.
			parent constraintsDo: [ :c | 
				c horizontal exact: 86*(parent childrenCount sqrt roundUpTo: 1)].
 ]
]
