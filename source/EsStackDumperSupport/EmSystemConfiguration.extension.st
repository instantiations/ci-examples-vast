Extension {
	#name : 'EmSystemConfiguration'
}

{ #category : '*EsStackDumperSupport',
 #vaCategories : ['ES-Internal'] }
EmSystemConfiguration >> primitiveDumpStack: imageFileName imageType: imageType [

	"Dump the current stack under imageFileName with imageType format.
	 When the image is restarted, execution will continue
	 here and true will be answered. The error code 	
	 and errorArgument are saved in case the restart code
	 has code which modifies them."

	| errorCode errorArg |
	<primitive: VMprSystemConfigurationPrimitiveSaveImage>
	errorCode := self primitiveErrorCode.
	errorArg := self primitiveBadArgumentNumber.
	^self 
		restart; 
		primitiveFailed:  errorCode withArgument: errorArg backUp: 0
]
