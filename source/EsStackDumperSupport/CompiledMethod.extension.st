Extension {
	#name : 'CompiledMethod'
}

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
CompiledMethod >> asCompiledMethod [

	"Answer a copy of the receiver, which shares the receiver's
	 instance variables."

	^self shallowCopy
]
