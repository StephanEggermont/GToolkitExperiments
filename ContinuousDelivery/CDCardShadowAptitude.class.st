Class {
	#name : #CDCardShadowAptitude,
	#superclass : #BrShadowAptitude,
	#category : #'ContinuousDelivery-ContinuousDelivery'
}

{ #category : #accessing }
CDCardShadowAptitude >> initialize [
	super initialize.
	self addChangeProperty: #(widget effect) withCopy: [ self shadow ].
	shadow := BlGaussianShadowEffect
		color: (Color black alpha: 0.3)
		width: 5
		offset: 1 @ 3
]
