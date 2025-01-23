Class {
	#name : #DTCardEditor,
	#superclass : #BrHorizontalGrid,
	#instVars : [
		'titleEditor',
		'card'
	],
	#category : #'DrawingTool-Drag & Drop'
}

{ #category : #accessing }
DTCardEditor >> card [
	^card ifNil: [card := DTCardView new]
]

{ #category : #accessing }
DTCardEditor >> card: aCard [
	card := aCard.
	titleEditor text: self card text
]

{ #category : #accessing }
DTCardEditor >> initialize [
	| aContainer |
	super initialize.
	
	self hFitContent;
		vFitContentLimited;
		padding: (BlInsets all: 3).
		
	aContainer := BrVerticalPane new
		hFitContent;
		vFitContentLimited.
	aContainer addChild: (
			BrLabel new
			aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
			margin: (BlInsets top: 5 left: 5 bottom: 2 right: 0);
			text: 'Title:').	
	aContainer addChild: (titleEditor := BrEditableLabel new
		aptitude: (BrGlamorousEditableLabelAptitude new fontSize: 1.0 fontEm);
		fitContent;
		text: self card text;
		when: BrEditorAcceptWish
		do: [ :aWish | 
			| aNewTitle |
			aNewTitle := aWish text asString .
			self model changeText: self card text to: aNewTitle in: self card position.
			self card text: aNewTitle ]).
	aContainer addChild: (
			BrButton new
			beSmallSize;
			aptitude: (BrGlamorousButtonWithLabelAptitude new);
			margin: (BlInsets top: 10 left: 5 bottom: 5 right: 0);
			label: 'Delete';
			action: [ 
				self fireEvent: BrDropdownHideWish new.
				card delete ]).	
		
	self addChild: (BrScrollPane new
		aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
		vFitContentLimited;
		hFitContent;
		content: aContainer)
]

{ #category : #'as yet unclassified' }
DTCardEditor >> model [
	^card app model
]
