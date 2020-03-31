Extension {
	#name : 'EsCompactMethod'
}

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
EsCompactMethod >> asCompiledMethod [

	"Answer a copy of the receiver, which shares the receiver's
	 instance variables."

	| cm literal |
	(cm := CompiledMethod new: self size)
		bytecodes: (EsByteCodeArray uncompressBytecodeArray: self bytecodes copy);
		methodClass: self methodClass;
		selector: self selector.
	1 to: self size do: [:i |
		((literal := self at: i) class == BlockContextTemplate or: [
			literal class == EsCompactBlockContextTemplate])
		ifTrue: [
			literal := BlockContextTemplate new
				methodContext: cm;
				startPC: literal climStartPC + 1 * 2 - (self size * 4 + 8) + 12 // 2;
				argsAndTemps: literal climArgsAndTemps;
				markReadOnly: true;
				yourself.
		].
		cm at: i put: literal].
	^cm
]
