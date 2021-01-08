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
	self size: 120@90;
	background: (Color lightGray muchLighter);
	layout: (BlLinearLayout vertical);
	margin: (BlInsets all: 6);
	padding: (BlInsets top: 2 left: 2 bottom: 2 right: 2);

	addChild: (BrEditableLabel new
	    look:(CDEditableLabelLook new
			glamorousRegularFont;
			fontSize: 14);
		padding: (BlInsets all: 2);
    	text: 'Prototype';
		when: BrEditorAcceptWish
		do: [ :aWish | 	| valueString |
			valueString := aWish text asString trim.
			release imageData image: valueString.
			release commit.
			];
 	   yourself);
 	addChild: (BrLabel new
 		look: BrGlamorousLabelLook;
		padding: (BlInsets left: 2);
 		text: '');
  	addChild: (BrLabel new
 		look: BrGlamorousLabelLook;
		padding: (BlInsets left: 2);
 		text: '');
  	addChild: (BrLabel new
 		look: BrGlamorousLabelLook;
		padding: (BlInsets left: 2);
 		text: '')
]

{ #category : #accessing }
CDReleaseCard >> release: aGtRelease [
	release := aGtRelease.
	self updateContents 
]

{ #category : #accessing }
CDReleaseCard >> updateContents [
	self background: release imageData color.
	(self childAt: 1) text: release imageData image.
	(self childAt: 2) text: release releaseName.
	(self childAt: 3) text: release imageSize.
	(self childAt: 4) text: release modificationTime.
	
]
