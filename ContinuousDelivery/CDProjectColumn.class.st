Class {
	#name : #CDProjectColumn,
	#superclass : #BlElement,
	#instVars : [
		'project',
		'pane',
		'label'
	],
	#category : #'ContinuousDelivery-ContinuousDelivery'
}

{ #category : #accessing }
CDProjectColumn >> cardsPane [
	pane := BlElement new
		background: Color yellow muchLighter muchLighter lighter;
		layout: BlFlowLayout new;
		padding: (BlInsets all: 2);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent];
		yourself.
	^pane
]

{ #category : #accessing }
CDProjectColumn >> commit [
]

{ #category : #accessing }
CDProjectColumn >> initialize [
	super initialize.
	self layout: (BlLinearLayout vertical);
		border: (BlBorder paint: Color lightGray  width: 1);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent].	
	self addChild: self titleBar.
	self addChild: self cardsPane
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
	project := aString.
	label text: project
]

{ #category : #accessing }
CDProjectColumn >> titleBar [
	| bar |
	bar := BlElement new
		size: 100 @ 40;
		background: Color lightGray muchLighter;
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 40 ];
		yourself.
	label := BrEditableLabel new
		margin: (BlInsets all: 5);
		aptitude:
			(CDEditableLabelAptitude new
				defaultBackground: Color transparent;
				glamorousCodeFont;
				fontSize: 10);
		text: 'Prototype';
		when: BrEditorAcceptWish
			do: [ :aWish | 
			| valueString |
			valueString := aWish text asString trim.
			project := valueString.
			pane
				childrenDo: [ :card | 
					card release imageData project: project.
					card release commit ] ];
		yourself.
	bar addChild: label.
	^ bar
]
