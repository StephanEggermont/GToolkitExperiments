Class {
	#name : #CDLinux,
	#superclass : #CDPlatform,
	#category : #'ContinuousDelivery-ContinuousDelivery'
}

{ #category : #accessing }
CDLinux >> platformName [
	^'Linux'
]

{ #category : #accessing }
CDLinux >> runCommand [
	^'"./glamoroustoolkit" "GlamorousToolkit.image" "--no-quit" "--interactive" &'
]
