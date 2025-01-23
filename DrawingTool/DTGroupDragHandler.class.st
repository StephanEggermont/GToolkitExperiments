Class {
	#name : #DTGroupDragHandler,
	#superclass : #BlPullHandler,
	#instVars : [
		'model'
	],
	#category : #'DrawingTool-Drag & Drop'
}

{ #category : #'as yet unclassified' }
DTGroupDragHandler >> dragEndEvent: anEvent [
	model dropGroup: anEvent currentTarget position: anEvent position.
	super dragEndEvent: anEvent
]

{ #category : #'as yet unclassified' }
DTGroupDragHandler >> dragStartEvent: anEvent [
	model dragGroup: anEvent currentTarget position: anEvent position.
	super dragStartEvent: anEvent
]

{ #category : #accessing }
DTGroupDragHandler >> model [
	^ model
]

{ #category : #accessing }
DTGroupDragHandler >> model: anObject [
	model := anObject
]
