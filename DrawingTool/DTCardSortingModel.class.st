Class {
	#name : #DTCardSortingModel,
	#superclass : #Object,
	#instVars : [
		'cardOrGroups',
		'events'
	],
	#category : #DrawingTool
}

{ #category : #accessing }
DTCardSortingModel >> cardOrGroups [
	^ cardOrGroups
]

{ #category : #accessing }
DTCardSortingModel >> cardOrGroups: anObject [
	cardOrGroups := anObject
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
