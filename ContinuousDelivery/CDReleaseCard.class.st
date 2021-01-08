Class {
	#name : #CDReleaseCard,
	#superclass : #BlElement,
	#instVars : [
		'release'
	],
	#category : #'ContinuousDelivery-ContinuousDelivery'
}

{ #category : #accessing }
CDReleaseCard >> initialize [
	super initialize.
	self size: 100@60;
	background: (Color lightGray muchLighter);
	layout: (BlLinearLayout vertical);
	addChild: (BrEditableLabel new
	    look:(BrGlamorousEditableLabelLook new
            glamorousCodeFont;
            defaultForeground: Color black;
            defaultBackground: Color lightYellow;
            fontSize: 10);
   	 text: 'Prototype';
 	   yourself).	
]

{ #category : #accessing }
CDReleaseCard >> release: aGtRelease [
	release := aGtRelease.
	self updateContents 
]

{ #category : #accessing }
CDReleaseCard >> updateContents [
	self background: release imageData color.
	
]
