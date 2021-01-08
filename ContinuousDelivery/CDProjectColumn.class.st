Class {
	#name : #CDProjectColumn,
	#superclass : #BlElement,
	#category : #'ContinuousDelivery-ContinuousDelivery'
}

{ #category : #accessing }
CDProjectColumn >> initialize [
	|bar|
	super initialize.
	bar := BlElement new
		size: 300 @ 40;
		background: (Color lightGray muchLighter);
		layout: (BlLinearLayout horizontal);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 40 ];
		yourself.
	self size: 300@600.
	self addChild: bar
]
