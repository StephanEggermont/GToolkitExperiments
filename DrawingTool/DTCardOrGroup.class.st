Class {
	#name : #DTCardOrGroup,
	#superclass : #Object,
	#instVars : [
		'title',
		'color',
		'position',
		'children'
	],
	#category : #'DrawingTool-Model'
}

{ #category : #accessing }
DTCardOrGroup >> children [
	^ children
]

{ #category : #accessing }
DTCardOrGroup >> children: anObject [
	children := anObject
]

{ #category : #accessing }
DTCardOrGroup >> color [
	^ color
]

{ #category : #accessing }
DTCardOrGroup >> color: anObject [
	color := anObject
]

{ #category : #'as yet unclassified' }
DTCardOrGroup >> initialize [
	children := OrderedCollection new
]

{ #category : #accessing }
DTCardOrGroup >> position [
	^ position
]

{ #category : #accessing }
DTCardOrGroup >> position: anObject [
	position := anObject
]

{ #category : #accessing }
DTCardOrGroup >> title [
	^ title
]

{ #category : #accessing }
DTCardOrGroup >> title: anObject [
	title := anObject
]
