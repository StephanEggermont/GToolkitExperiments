Class {
	#name : #DTCard,
	#superclass : #BlElement,
	#instVars : [
		'label',
		'app'
	],
	#category : #'DrawingTool-Drag & Drop'
}

{ #category : #accessing }
DTCard >> app: aCardSorting [
	app := aCardSorting
]

{ #category : #accessing }
DTCard >> delete [
	| group |
	group := self parent.
	group removeChild: self.
	group childrenCount = 0 ifTrue: [
		group parent removeChild: group.
		app handler removePane: group] 
	ifFalse: [
		group constraintsDo: [ :c | 
			c horizontal exact: 86*(group childrenCount sqrt roundUpTo: 1)]].
]

{ #category : #accessing }
DTCard >> initialize [
	super initialize.
	label :=BlTextElement new
		text: '' asRopedText;
		size: 74 @ 54;
		padding: (BlInsets all: 3);		
		yourself.
	self background: Color yellow muchLighter;
		border: (BlBorder paint: Color black);
		margin: (BlInsets all: 2);
		size: 80@60.	
	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent].
	self addChild: label.
	self addAptitude: (BrGlamorousWithContextMenuAptitude
			handle: [ BlElement new
					size: 2@2;
					geometry: BlEllipseGeometry new ]
			content: [ DTCardEditor new
				card: self;
				requestFocus ])
]

{ #category : #accessing }
DTCard >> large [
	self size: 120@80
]

{ #category : #accessing }
DTCard >> small [
	self size: 80@60
]

{ #category : #accessing }
DTCard >> text [
	^ label text
]

{ #category : #accessing }
DTCard >> text: aString [
	label text: aString asRopedText
]
