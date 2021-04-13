Class {
	#name : #CDEditableLabelAptitude,
	#superclass : #BrGlamorousEditorAptitude,
	#instVars : [
		'defaultBackground',
		'defaultForeground',
		'minWidth'
	],
	#category : #'ContinuousDelivery-ContinuousDelivery'
}

{ #category : #accessing }
CDEditableLabelAptitude >> defaultBackground [
	^defaultBackground
]

{ #category : #accessing }
CDEditableLabelAptitude >> defaultBackground: aBackground [
	defaultBackground := aBackground
]

{ #category : #accessing }
CDEditableLabelAptitude >> defaultForeground [
	^defaultForeground
]

{ #category : #accessing }
CDEditableLabelAptitude >> defaultForeground: aForeground [
	defaultForeground := aForeground
]

{ #category : #accessing }
CDEditableLabelAptitude >> initialize [ 
	super initialize.
	
	defaultBackground := Color transparent.
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
CDEditableLabelAptitude >> initializeListeners [
	super initializeListeners.

	self when: BlClickEvent do: [ :anEvent | anEvent currentTarget dispatchEvent: (BlElementSelectedStateWish selected: true) ]
]

{ #category : #accessing }
CDEditableLabelAptitude >> minWidth [
	^minWidth
]

{ #category : #accessing }
CDEditableLabelAptitude >> minWidth: aNumber [
	minWidth := aNumber
]
