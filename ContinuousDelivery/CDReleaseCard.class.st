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
	self
		size: 120 @ 90;
		background: Color lightGray muchLighter;
		border: (BlBorder paint: Color lightGray muchLighter width: 1);
		layout: BlLinearLayout vertical;
		margin: (BlInsets all: 6);
		padding:
			(BlInsets
				top: 2
				left: 2
				bottom: 2
				right: 2);
		addAptitude: CDCardShadowAptitude new;
		addAptitude:
			(BrGlamorousWithContextMenuAptitude
				content: [ BrGlamorousSimpleContextMenuContent new
						items: self menuItems;
						yourself ]);
		addChild:
			(BrEditableLabel new
				aptitude:
					(CDEditableLabelAptitude new
						glamorousRegularFont;
						fontSize: 14);
				padding: (BlInsets all: 2);
				text: 'Prototype';
				when: BrEditorAcceptWish
					do: [ :aWish | 
					| valueString |
					valueString := aWish text asString trim.
					release imageData image: valueString.
					release commit ];
				yourself);
		addChild:
			(BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				padding: (BlInsets left: 2);
				text: '');
		addChild:
			(BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				padding: (BlInsets left: 2);
				text: '');
		addChild:
			(BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				padding: (BlInsets left: 2);
				text: '').
	self
		addEventHandler:
			(BlEventHandler
				on: BlPullEndEvent
				do: [ release imageData project: self parent parent project.
					release commit ])
]

{ #category : #accessing }
CDReleaseCard >> menuItems [

	| menu |
	menu := #(blue yellow red green) collect: [ :each | |color|
    color := (Color perform: ('light', each capitalized) asSymbol).
    ('Change to ',each capitalized) -> [ :e | 
        e background: color.
        e release imageData color: color.
        e release commit]].
    ^menu copyWith: (#'Run' -> [ :e | e release run]).
 
]

{ #category : #accessing }
CDReleaseCard >> release [
	^release
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
