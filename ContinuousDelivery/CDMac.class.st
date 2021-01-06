Class {
	#name : #CDMac,
	#superclass : #CDPlatform,
	#category : #'ContinuousDelivery-ContinuousDelivery'
}

{ #category : #accessing }
CDMac >> platformName [
	^'OSX'
]

{ #category : #accessing }
CDMac >> runCommand [
	^'open GlamorousToolkit.app'
]
