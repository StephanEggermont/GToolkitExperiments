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
	^'./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkit.image --no-quit --interactive &'
"	^'open GlamorousToolkit.app'"
]
