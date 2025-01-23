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

{ #category : #event }
DTCardSortingModel >> changeText: oldText to: newText in: aPosition [
	events add: (DTEvent type: #changeText title: oldText asString,' - ',newText asString,' - ',aPosition asString)
]

{ #category : #event }
DTCardSortingModel >> dragStart: aCard position: aPosition [
	events add: (DTEvent type: #startDragCard title: aCard text asString,' - ',aPosition asString)
]

{ #category : #event }
DTCardSortingModel >> drop: aCard at: aPosition [
	events add: (DTEvent type: #dropCard title: aCard text asString,' - ',aPosition asString)
]

{ #category : #event }
DTCardSortingModel >> drop: aCard at: aPosition in: aGroup [
	events add: (DTEvent type: #dropCardIn title: aCard text asString,' - ',aPosition asString,' - ',aGroup position asString)
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

{ #category : #event }
DTCardSortingModel >> newCard: aText [.
	events add: (DTEvent type: #newCard
		title: aText)
]
