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
	margin: (BlInsets all: 5);
	padding: (BlInsets all: 5);

	addChild: (BrEditableLabel new
	    look:(BrGlamorousEditableLabelLook new
            glamorousCodeFont;
            defaultForeground: Color black;
            defaultBackground: Color lightYellow;
            fontSize: 10);
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
 		text: '');
  	addChild: (BrLabel new
 		look: BrGlamorousLabelLook;
 		text: '');
  	addChild: (BrLabel new
 		look: BrGlamorousLabelLook;
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
