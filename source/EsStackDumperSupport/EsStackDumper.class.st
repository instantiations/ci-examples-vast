Class {
	#name : 'EsStackDumper',
	#superclass : 'Object',
	#classVars : [
		'StackDumpFileName'
	],
	#pools : [
		'NlsCatESj'
	],
	#classInstVars : [
		'globalNamespace'
	],
	#category : 'EsStackDumperSupport'
}

{ #category : 'ES-Internal' }
EsStackDumper class >> doNotCreateStackDumpFile [

	"Specify that the Runtime should not output a stack dump file"

	self stackDumpFileName: nil
]

{ #category : 'ES-Internal' }
EsStackDumper class >> dumpStack: errorString [

	"Dump the current stack in a file.
	 This file is an image file which contains an instance of 
	 EsStackDumpInfo at slot 53 in the Core registry."

	| dumpImageName stackDump process indirectInstVars |
	20 timesRepeat: [System scavenge].
10 timesRepeat: [System globalGarbageCollect].
	self globalNamespace: Smalltalk.

	dumpImageName := self stackDumpFileName.
	stackDump := self stackDumpDebugInfoClass new.
	process := Processor activeProcess asEsStackDumpProcess: errorString.
	process snapshotIds: System componentSnapshotIds.
	
	"We must reference the 'IndirectInstVars' class variable in Behavior indirectly
	 to avoid bootstrapping problems when the stack dump debugger is loaded into a
	 passive image at the	 same time as Kernel."
 	indirectInstVars := 
		(Smalltalk classAt: #Behavior) classPool at: 'IndirectInstVars'. "$NON-NLS$"
	stackDump 
		process: process;
		dateString: Date today printString;
		timeString: Time now printString;
		vmVersion: System vmVersion;
		copyright: System copyright;
		configuration: System configuredSubsystems;
		patchList: self patchList;
		indirectInstVars: indirectInstVars.

	"Slot 53 is used for Debug Info"
	Core registry at: 53 put: stackDump. 	
	TranscriptTTY default cr; show: (MxESj1 bindWith: dumpImageName).  "$NLS$ Dumping Stack File %1 ..."
	System primitiveDumpStack: dumpImageName nullTerminated imageType: 3.
	TranscriptTTY default cr; show: (MxESj2 bindWith: dumpImageName); cr  "$NLS$ ...Finished Dumping Stack File %1"
]

{ #category : 'ES-Internal' }
EsStackDumper class >> globalNamespace [

	"Answer the Smalltalk dictionary at the time the stack was dump."

	^globalNamespace
]

{ #category : 'ES-Internal' }
EsStackDumper class >> globalNamespace: anEsSmalltalkDictionary [

	"Set the Smalltalk dictionary at the time the stack was dump."

	globalNamespace := anEsSmalltalkDictionary
]

{ #category : 'ES-Internal',
  #vaVisibility : 'private' }
EsStackDumper class >> patchList [

	"Answer a Set of method patches (Array).
	 For a normal stack dumper, this set is empty."

	^Set new
]

{ #category : 'ES-Internal' }
EsStackDumper class >> shouldCreateStackDumpFile [

	"Answer true if a binary stack dump file should be 
	 created and false otherwise."

	^self stackDumpFileName notNil
]

{ #category : 'ES-Internal',
  #vaVisibility : 'private' }
EsStackDumper class >> stackDumpDebugInfoClass [

	^EsStackDumpDebugInfo
]

{ #category : 'ES-Internal',
  #vaVisibility : 'private' }
EsStackDumper class >> stackDumpFileName [

	^StackDumpFileName 
]

{ #category : 'ES-Internal' }
EsStackDumper class >> stackDumpFileName: aName [

	StackDumpFileName := aName
]
