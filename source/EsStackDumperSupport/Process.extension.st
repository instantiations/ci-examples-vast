Extension {
	#name : 'Process'
}

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
Process >> asEsStackDumpProcess [

	"Answer a BatchWalkbackProcess that is equivalent to the receiver."

	^self asEsStackDumpProcess: (NlsCatESj residentMsg: 'MxESj3')  "$NLS$ Unknown Error"

	"Processor activeProcess asEsStackDumpProcess"
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
Process >> asEsStackDumpProcess: errorString [

	"Answer a BatchWalkbackProcess that is equivalent to the receiver.
	 Store into it the pseudo process for eventual use by the debugger."

	^self stackDumpProcessClass 
		fromProcess: self 
		errorString: errorString

	"Processor activeProcess asEsStackDumpProcess"
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
Process >> createDumpStack [

	"Answer the information contained in the Process Stack identified
	 by the receiver, in a manner that is storeable for future analysis
	 by the stack dump debugger.  This method returns an Array where each
	 element contains an Array of size 10 + the number of args and
	 temps.  Each of these internal arrays represents a stack frame."

	| element array frame method context optimizedBlock args temps frameIndex |
	frameIndex := self numberOfFrames - 1.	
	array := Array new: frameIndex + 1 - 3. 
	3 to: frameIndex do: [:i |	
		context := self stackAtFrame: i offset: -6.
		method := self stackAtFrame: i offset: -9.			

		(optimizedBlock := (context class == BlockContextTemplate))
			ifTrue: [
				args := context argumentCount.
				temps := context tempCount] 
			ifFalse: [
				args := method argumentCount.
				temps := method tempCount].

		frame := Array new: 10 + args + temps.
		-9 to: 0  do: [:j | frame at: j + 10 put: (self stackAtFrame: i offset: j)].

		"Transform compact methods in compiled methods:"
		frame at: 1 put: (frame at: 1) asCompiledMethod.
		(frame at: 8) isNil ifFalse: [frame at: 8 put: (frame at: 8) asCompiledMethod].
		    
		1 to: args do: [:j |   
			(context == nil or: [optimizedBlock]) ifTrue: [
				element := (self stackAtFrame: i offset: temps + args - j + 1).
 				frame at: (temps + args - j + 1 + 10) put: element]].

		1 to: temps do: [:j |
			(context == nil or: [optimizedBlock]) ifTrue: [
				element := (self stackAtFrame: i offset: temps - j + 1).
				frame at: (temps - j + 1 + 10) put: element]].

		array at: (i + 1 - 3) put: frame].

	^array

	"Processor activeProcess createDumpStack"
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'],
  #vaVisibility : 'private' }
Process >> privateBreakBP [

	^breakBP
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'],
  #vaVisibility : 'private' }
Process >> privateDebugBP [

	^debugBP
	
	
	
	
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'],
  #vaVisibility : 'private' }
Process >> privatePriority [

	^priority
	
		
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'],
  #vaVisibility : 'private' }
Process >> privateProcessName [

	^processName
		
	
	
	
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'],
  #vaVisibility : 'private' }
Process >> privateReturnPoint [

	^returnPoint
	
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'],
  #vaVisibility : 'private' }
Process >> privateState [

	^state
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'],
  #vaVisibility : 'private' }
Process >> privateVmState [

	^vmState
]

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'],
  #vaVisibility : 'private' }
Process >> stackDumpProcessClass [

	^EsStackDumpProcess
]
