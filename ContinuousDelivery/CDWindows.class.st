Class {
	#name : #CDWindows,
	#superclass : #CDPlatform,
	#category : #'ContinuousDelivery-ContinuousDelivery'
}

{ #category : #accessing }
CDWindows >> platformName [
	^'Win' 
]

{ #category : #accessing }
CDWindows >> runCommand [
	^'/GlamorousToolkit.exe'
]
