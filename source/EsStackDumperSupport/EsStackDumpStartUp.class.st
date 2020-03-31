Class {
	#name : 'EsStackDumpStartUp',
	#superclass : 'EsBatchStartUp',
	#category : 'EsStackDumperSupport'
}

{ #category : 'ES-Internal' }
EsStackDumpStartUp class >> outputWalkback: aString [

	"Output a walkback for the active process i.e. try to dump the
	 stack in the file defined by StackDumpFileName.
	 If it fails, default to the super class."

	[self stackDumperClass shouldCreateStackDumpFile 
		ifTrue: [
			self stackDumperClass dumpStack: aString.
			ExitAfterWalkback ~~ false ifTrue: [
				System primitiveExit: PrimErrExitDueToStackDump withObject: nil]]
		ifFalse: [super outputWalkback: aString]
	]
		when: ExError
		do: [:sig | 
			super outputWalkback: aString.
			sig exitWith: nil]
]

{ #category : 'ES-Internal' }
EsStackDumpStartUp class >> stackDumperClass [

	^EsStackDumper
]

{ #category : 'ES-Internal' }
EsStackDumpStartUp class >> startApplication [

	"Replace this method using standard packager techniques (i.e. in the 
	 class mappings browser, select this method and select the menu option
	 to replace the method with another method).  Do not modify it directly.
	 If this class is subclassed, this method must be copied in the subclass."
]
