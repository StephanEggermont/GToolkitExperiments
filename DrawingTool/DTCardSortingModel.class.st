Class {
	#name : #DTCardSortingModel,
	#superclass : #Object,
	#instVars : [
		'cardOrGroups',
		'events'
	],
	#category : #'DrawingTool-Model'
}

{ #category : #accessing }
DTCardSortingModel >> cardOrGroups [
	^ cardOrGroups
]

{ #category : #accessing }
DTCardSortingModel >> cardOrGroups: anObject [
	cardOrGroups := anObject
]

{ #category : #'as yet unclassified' }
DTCardSortingModel >> dragStart: aCard position: aPosition [
	events add: (DTEvent type: #startDragCard title: aCard text asString,' -',aPosition asString)
]

{ #category : #'as yet unclassified' }
DTCardSortingModel >> drop: aCard at: aPosition in: aGroup [
	events add: (DTEvent type: #dropCard title: aCard text asString,' -',aPosition asString)
]

{ #category : #accessing }
DTCardSortingModel >> events [
	^ events
]

{ #category : #accessing }
DTCardSortingModel >> events: anObject [
	events := anObject
]

{ #category : #'as yet unclassified' }
DTCardSortingModel >> initialize [
	cardOrGroups := OrderedCollection new.
	events := OrderedCollection new
]

{ #category : #'as yet unclassified' }
DTCardSortingModel >> newCard: aText [.
	events add: (DTEvent type: #newCard
		title: aText)
]
