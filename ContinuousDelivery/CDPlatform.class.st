Class {
	#name : #CDPlatform,
	#superclass : #Object,
	#classInstVars : [
		'current'
	],
	#category : #'ContinuousDelivery-ContinuousDelivery'
}

{ #category : #accessing }
CDPlatform class >> current [ 
	current ifNil: [
		OSPlatform current family = 'MacOSX' ifTrue: [current := CDMac new].
		OSPlatform current family = 'Unix' ifTrue: [current := CDLinux new].
		OSPlatform current family = 'Windows' ifTrue: [current := CDWindows new]].
	^current 
]

{ #category : #accessing }
CDPlatform >> platformName [
	self subclassResponsibility
]

{ #category : #accessing }
CDPlatform >> runCommand [
	self subclassResponsibility
]
