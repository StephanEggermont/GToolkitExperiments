Class {
	#name : #CDEditableLabelLook,
	#superclass : #BrGlamorousEditorLook,
	#instVars : [
		'defaultBackground',
		'defaultForeground',
		'minWidth'
	],
	#category : #ContinuousDelivery
}

{ #category : #accessing }
CDEditableLabelLook >> defaultBackground [
	^ defaultBackground
]

{ #category : #accessing }
CDEditableLabelLook >> defaultBackground: anObject [
	defaultBackground := anObject
]

{ #category : #accessing }
CDEditableLabelLook >> defaultForeground [
	^ defaultForeground
]

{ #category : #accessing }
CDEditableLabelLook >> defaultForeground: anObject [
	defaultForeground := anObject
]

{ #category : #initialization }
CDEditableLabelLook >> initialize [
	super initialize.
	
	defaultBackground := Color transparent.
	defaultForeground := Color black.
	minWidth := 20.

	self
		addChangeProperty: #(widget constraints minWidth)
		with: [ self minWidth ].

	self
		add: (BrStyleCommonLook new
			default: [ :aStyle |
				aStyle geometry: (BlRoundedRectangleGeometry cornerRadius: 2).
				aStyle background: self defaultBackground.
				aStyle border: BlBorder empty ];
			when: BrEditorModeState editable
				style: [ :aStyle | aStyle background: Color white ];
			when: [ :aState | aState focused not and: BrEditorModeState editable ]
				style: [ :aStyle | aStyle border: (BlBorder paint: BrGlamorousColors editorBorderColor width: 1) ];
			when: [ :aState | aState focused and: BrEditorModeState editable ]
				style: [ :aStyle | aStyle border: (BlBorder paint: BrGlamorousColors focusedEditorBorderColor width: 1) ];
			when: [ :aState | aState hovered and: BrEditorModeState readOnly ]
				style: [ :aStyle | aStyle background: BrGlamorousColors neutralBackgroundColor darker ];
			when: [ :aState | aState focused and: BrEditorModeState readOnly ]
				style: [ :aStyle |
					aStyle background: BrGlamorousColors focusedEditorBorderColor.
					aStyle do: [ self foreground: Color white ] after: [ self foreground: self defaultForeground ] ])
]

{ #category : #initialization }
CDEditableLabelLook >> initializeListeners [
	super initializeListeners.
	
	self when: BlClickEvent do: [ :anEvent | anEvent currentTarget dispatchEvent: (BlElementSelectedStateWish selected: true) ]
]

{ #category : #accessing }
CDEditableLabelLook >> minWidth [
	^ minWidth
]

{ #category : #accessing }
CDEditableLabelLook >> minWidth: anObject [
	minWidth := anObject
]
