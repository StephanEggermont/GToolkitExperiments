Class {
	#name : #BrLeftLabelButtonAptitude,
	#superclass : #BrGlamorousButtonRectangularAptitude,
	#category : #'DrawingTool-Aptitudes'
}

{ #category : #accessing }
BrLeftLabelButtonAptitude >> initialize [
	super initialize.
	self addAll: {
		BrGlamorousButtonExteriorAptitude new.
		BrGlamorousButtonLabelAptitude new.
		BrGlamorousButtonWithLabelTooltipAptitude new
	}.
	self default geometry: ( BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
							topLeft: 4;
							topRight: 0;
							bottomLeft: 4;
							bottomRight: 0)).
	self add: (BrSizeAdjustmentAptitude new
		mini: [ :aStyle |
			aStyle
				vExact: 12;
				padding: (BlInsets left: 4 right: 4) ];
		tiny: [ :aStyle |
			aStyle
				vExact: 16;
				padding: (BlInsets left: 6 right: 6) ];
		small: [ :aStyle | 
			aStyle
				vExact: 20;
				padding: (BlInsets left: 8 right: 8) ];
		normal: [ :aStyle | 
			aStyle
				vExact: 24;
				padding: (BlInsets left: 10 right: 10) ];
		large: [ :aStyle |
			aStyle
				vExact: 30;
				padding: (BlInsets left: 10 right: 10) ];
		huge: [ :aStyle |
			aStyle
				vExact: 48;
				padding: (BlInsets left: 16 right: 16) ]).

	self add: BrGlamorousButtonLayoutAptitude new
 
]
