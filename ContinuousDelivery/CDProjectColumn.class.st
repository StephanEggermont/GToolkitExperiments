Class {
	#name : #CDProjectColumn,
	#superclass : #BlElement,
	#instVars : [
		'project',
		'pane'
	],
	#category : #'ContinuousDelivery-ContinuousDelivery'
}

{ #category : #accessing }
CDProjectColumn >> commit [
]

{ #category : #accessing }
CDProjectColumn >> initialize [
	|bar label|
	super initialize.
	self layout: (BlLinearLayout vertical).
	bar := BlElement new
		size: 300 @ 40;
		background: (Color lightGray muchLighter);
		layout: (BlLinearLayout horizontal);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 40 ];
		yourself.
	label :=(BrEditableLabel new
		margin: (BlInsets all: 5);
	    look:(BrGlamorousEditableLabelLook new
			defaultBackground: Color transparent;
 			glamorousCodeFont;
           fontSize: 10);
   	 text: 'Prototype';
		when: BrEditorAcceptWish
		do: [ :aWish | 	| valueString |
			valueString := aWish text asString trim.
			project := valueString.
			self commit.
			];
 	   yourself).
	bar addChild: label.
	self size: 300@600;
	border: (BlBorder paint: Color lightGray muchLighter width: 1).
	pane := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent].
		
	self addChild: bar.
	self addChild: pane
]

{ #category : #accessing }
CDProjectColumn >> pane [
	^pane
]

{ #category : #accessing }
CDProjectColumn >> project [
	^project ifNil: ['']
]

{ #category : #accessing }
CDProjectColumn >> project: aString [
	project := aString
]