Class {
	#name : 'EsStackDumperSupport',
	#superclass : 'Application',
	#pools : [
		'NlsCatESj'
	],
	#category : 'EsStackDumperSupport'
}

{ #category : 'ES-Internal' }
EsStackDumperSupport class >> loaded [

	"The application has just been loaded :
	 Localize it."

	self localize	"#localize must reset any cached strings"
]

{ #category : 'ES-Internal' }
EsStackDumperSupport class >> localize [
	"Localize the receiver application to the default messages locale.
	This method MUST reset any strings that are being 
	cached by the application or its classes. This must be done after 
	the relocalizeTo: line."

	NlsCatESj relocalizeTo: self defaultMessagesLocale.

]

{ #category : 'ES-Internal',
  #vaVisibility : 'private' }
EsStackDumperSupport class >> stackDumperClass [

	^EsStackDumper
]

{ #category : 'ES-Internal',
  #vaVisibility : 'private' }
EsStackDumperSupport class >> startUpClass [

	^EsStackDumpStartUp
]
