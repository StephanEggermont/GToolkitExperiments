Class {
	#name : #DTEditableLabelAptitude,
	#superclass : #BrGlamorousEditorAptitude,
	#instVars : [
		'defaultBackground',
		'defaultForeground',
		'minWidth'
	],
	#category : #'DrawingTool-Aptitudes'
}

{ #category : #accessing }
DTEditableLabelAptitude >> defaultBackground [
	^defaultBackground
]

{ #category : #accessing }
DTEditableLabelAptitude >> defaultBackground: aBackground [
	defaultBackground := aBackground
]

{ #category : #accessing }
DTEditableLabelAptitude >> defaultForeground [
	^defaultForeground
]

{ #category : #accessing }
DTEditableLabelAptitude >> defaultForeground: aForeground [
	defaultForeground := aForeground
]

{ #category : #accessing }
DTEditableLabelAptitude >> initialize [ 
	super initialize.
	
	defaultBackground := Color white.
	defaultForeground := Color black.
	minWidth := 20.

	self
		addChangeProperty: #(widget constraints minWidth)
		with: [ self minWidth ].

	self
		add: (BrStyleCommonAptitude new
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

{ #category : #accessing }
DTEditableLabelAptitude >> initializeListeners [
	super initializeListeners.

	self when: BlClickEvent do: [ :anEvent | anEvent currentTarget dispatchEvent: (BlElementSelectedStateWish selected: true) ]
]

{ #category : #accessing }
DTEditableLabelAptitude >> minWidth [
	^minWidth
]

{ #category : #accessing }
DTEditableLabelAptitude >> minWidth: aNumber [
	minWidth := aNumber
]
