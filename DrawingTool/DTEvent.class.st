Class {
	#name : #DTEvent,
	#superclass : #Object,
	#instVars : [
		'type',
		'title'
	],
	#category : #DrawingTool
}

{ #category : #'as yet unclassified' }
DTEvent class >> type: aString title: aText [ 
	^self new
		type: aString;
		title: aText;
		yourself
]

{ #category : #'as yet unclassified' }
DTEvent >> title: aText [ 
	title := aText
]

{ #category : #'as yet unclassified' }
DTEvent >> type: aString [ 
	type := aString
]
