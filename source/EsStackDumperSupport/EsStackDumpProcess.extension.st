Extension {
	#name : 'EsStackDumpProcess'
}

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
EsStackDumpProcess class >> fromProcess: aProcess [

	"Create and answer an instance of the receiver
	 which will represent aProcess but won't be active."

	^self new
		returnPoint: aProcess privateReturnPoint;
		vmState: aProcess privateVmState;
		stack: aProcess createDumpStack;
		priority: aProcess privatePriority;
		state: aProcess privateState;
		queue: aProcess queue;
		debugBP: aProcess privateDebugBP;
		processName: aProcess privateProcessName;
		errorHandler: aProcess errorHandler;
		resumeable: aProcess isResumable;
		breakBP: aProcess privateBreakBP;
		interruptBlocks: nil;
		yourself

	"Processor activeProcess asEsStackDumpProcess"

]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
EsStackDumpProcess class >> fromProcess: aProcess errorString: aString [

	"Create and answer an instance of the receiver
	 which will represent aProcess but won't be active and
	 which will have aString as error string."

	^self new
		returnPoint: aProcess privateReturnPoint;
		vmState: aProcess privateVmState;
		stack: aProcess createDumpStack;
		priority: aProcess privatePriority;
		state: aProcess privateState;
		queue: aProcess queue;
		debugBP: aProcess privateDebugBP;
		processName: aProcess privateProcessName;
		errorHandler: aProcess errorHandler;
		resumeable: aProcess isResumable;
		breakBP: aProcess privateBreakBP;
		interruptBlocks: nil;
		errorString: aString;
		yourself

	"Processor activeProcess asEsStackDumpProcess"

]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
EsStackDumpProcess >> breakBP: backPointer [

	breakBP := backPointer
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
EsStackDumpProcess >> debugBP: backPointer [

	debugBP := backPointer
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'],
  #vaVisibility : 'private' }
EsStackDumpProcess >> debugMode [

	"Answer a Boolean indicating whether or not the receiver is in 
	 debug mode."

	^true
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
EsStackDumpProcess >> interruptBlocks: blocks [

	interruptBlocks := blocks
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
EsStackDumpProcess >> priority: anInteger [

	priority := anInteger
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
EsStackDumpProcess >> resumeable: aBoolean [

	resumeable := aBoolean
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
EsStackDumpProcess >> returnPoint: anInteger [

	returnPoint := anInteger
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
EsStackDumpProcess >> shouldNotImplement [

	"Report to the user that the receiver's class or superclasses do
	 not have an appropriate implementation for the method from which
	 this message was invoked."

	^self error: (NlsCatESj indexedMsg: 1)  "$NLS$ Should not implement"
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
EsStackDumpProcess >> stack: anArray [

	stack := anArray
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
EsStackDumpProcess >> state: anEsAtom [

	state := anEsAtom
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
EsStackDumpProcess >> vmState: anInteger [

	vmState := anInteger
]
