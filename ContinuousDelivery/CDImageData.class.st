Class {
	#name : #CDImageData,
	#superclass : #Object,
	#instVars : [
		'project',
		'image',
		'color'
	],
	#category : #'ContinuousDelivery-ContinuousDelivery'
}

{ #category : #accessing }
CDImageData >> color [
	^color ifNil: [Color white]
]

{ #category : #accessing }
CDImageData >> color: aColor [
	color := aColor
]

{ #category : #accessing }
CDImageData >> image [
	^image ifNil: ['']
]

{ #category : #accessing }
CDImageData >> image: aString [
	image := aString
]

{ #category : #accessing }
CDImageData >> project [
	^project ifNil: ['']
]

{ #category : #accessing }
CDImageData >> project: aString [
	project := aString
]
