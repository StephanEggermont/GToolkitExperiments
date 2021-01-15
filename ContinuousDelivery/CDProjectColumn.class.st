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
CDProjectColumn >> commit [
]

{ #category : #accessing }
CDProjectColumn >> initialize [
	|bar |
	super initialize.
	self layout: (BlLinearLayout vertical).
	self border: (BlBorder paint: Color black lighter).
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent].

	bar := BlElement new
		size: 100 @ 40;
		background: (Color lightGray muchLighter);
		layout: (BlLinearLayout horizontal);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 40 ];
		yourself.
	label :=(BrEditableLabel new
		margin: (BlInsets all: 5);
	    look:(CDEditableLabelLook new
			defaultBackground: Color transparent;
 			glamorousCodeFont;
           fontSize: 10);
   	 text: 'Prototype';
		when: BrEditorAcceptWish
		do: [ :aWish | 	| valueString |
			valueString := aWish text asString trim.
			project := valueString.
			pane childrenDo: [ :card | 
				card release imageData project: project.
				card release commit].
			];
 	   yourself).
	bar addChild: label.
	self border: (BlBorder paint: Color lightGray muchLighter width: 1).
	pane := BlElement new
		border: (BlBorder paint: Color lightGray lighter);
		background: Color yellow muchLighter muchLighter lighter;
		layout: BlFlowLayout new;
		margin: (BlInsets all: 2);
		padding: (BlInsets all: 2);
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
	project := aString.
	label text: project
]
