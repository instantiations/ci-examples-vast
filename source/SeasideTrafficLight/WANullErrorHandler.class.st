Class {
	#name : 'WANullErrorHandler',
	#superclass : 'WAErrorHandler',
	#category : 'SeasideTrafficLight'
}

{ #category : 'Not categorized' }
WANullErrorHandler >> handleException: anException [

	^ 	anException pass
]
