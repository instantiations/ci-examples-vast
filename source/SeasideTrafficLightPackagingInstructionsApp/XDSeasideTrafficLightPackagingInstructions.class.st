Class {
	#name : 'XDSeasideTrafficLightPackagingInstructions',
	#superclass : 'AbtXDSingleImagePackagingInstructions',
	#category : 'SeasideTrafficLightPackagingInstructionsApp'
}

{ #category : 'Not categorized' }
XDSeasideTrafficLightPackagingInstructions class >> allGreaseApplicationNamesToPackage [

	^((OrderedCollection new)
		add: #GreaseCoreApp;
		add: #GreaseVASTCoreApp;
		yourself)
]

{ #category : 'EP-API (Modifiable)' }
XDSeasideTrafficLightPackagingInstructions class >> allProjectApplicationNamesToPackage [

	^OrderedCollection new
		add: #SeasideTrafficLight;
		yourself
]

{ #category : 'Not categorized' }
XDSeasideTrafficLightPackagingInstructions class >> allSeasideApplicationNamesToPackage [

	^((OrderedCollection new)
		add: #SeasideAdaptorsSstApp;
		add: #SeasideCanvasApp;
		add: #SeasideComponentApp;
		add: #SeasideCoreApp;
		add: #SeasideEmailApp;
		add: #SeasideEnvironmentApp;
		add: #SeasideFlowApp;
		add: #SeasideInternetExplorerApp;
		add: #SeasideJSONCoreApp;
		add: #SeasideRenderLoopApp;
		add: #SeasideRESTCoreApp;
		add: #SeasideSecurityApp;
		add: #SeasideSessionApp;
		add: #SeasideToolsCoreApp;
		add: #SeasideVASTContinuationApp;
		add: #SeasideVASTCoreApp;
		add: #SeasideVASTEmailApp;
		add: #SeasideVASTEnvironmentApp;
		add: #SeasideVASTFlowApp;
		add: #SeasideVASTJSONCoreApp;
		add: #SeasideVASTRESTCoreApp;
		add: #SeasideVASTSecurityApp;
		add: #SeasideVASTWidgetsApp;
		add: #SeasideWidgetsApp;
		"add: #RSSCoreApp;
		add: #RSSExamplesApp;"
		add: #JavascriptCoreApp;
		add: #JavascriptVASTCoreApp;
		add: #JQueryCoreApp;
		add: #JQueryJSONApp;
		"add: #JQueryUIApp;"
		add: #JQueryVASTCoreApp;
		"add: #PrototypeCoreApp;
		add: #ScriptaculousComponentsApp;
		add: #ScriptaculousCoreApp;"
		yourself)
]

{ #category : 'Not categorized' }
XDSeasideTrafficLightPackagingInstructions class >> applicationLaunchBlock [

	^[SeasideTrafficLightEntryPoint startApplication]
]

{ #category : 'EP-API (Modifiable)' }
XDSeasideTrafficLightPackagingInstructions class >> applicationLaunchCode [

	^'%1 value' bindWith: self applicationLaunchBlock epBlockPrintString
]

{ #category : 'EP-API (Modifiable)' }
XDSeasideTrafficLightPackagingInstructions class >> applicationNamesToPackage [

	^super applicationNamesToPackage
		add: #SstDebuggingSupport;
		addAll: self allGreaseApplicationNamesToPackage;
		addAll: self allSeasideApplicationNamesToPackage;
		addAll: self allProjectApplicationNamesToPackage;
		yourself
]

{ #category : 'Not categorized' }
XDSeasideTrafficLightPackagingInstructions class >> controlPanelName [

	^ 'Seaside Traffic Light Headless Image'
]

{ #category : 'Not categorized' }
XDSeasideTrafficLightPackagingInstructions class >> description [

	^ 'XD Single Runtime-reduced Headless Seaside Traffic Light Image'
]

{ #category : 'EP-API (Modifiable)' }
XDSeasideTrafficLightPackagingInstructions class >> dumperOptions [

	^EpDumperOptions new
		createSnapshot;
		removeCategories;
		removeSourcePointers;
		optimizeAssociations;
		uniqueEmptyMethodDictionary;
		dumperClass: EsRomerImageDumper;
		outputDirectoryName: ''; "$NON-NLS$"
		makeMessageCatalogsResident;
		correctManagerStructures;
		removeUnusedMetaclasses;
		enable: EpAllStatistics;
		imageFileName: self imageFileName;
		yourself
]

{ #category : 'Not categorized' }
XDSeasideTrafficLightPackagingInstructions class >> imageFileName [

	^'seasideTrafficLight.icx'
]

{ #category : 'EP-API (Modifiable)' }
XDSeasideTrafficLightPackagingInstructions class >> isKeptByDefault [

	^false
]

{ #category : 'EP-API (Modifiable)' }
XDSeasideTrafficLightPackagingInstructions class >> isSavedByDefault [

	^false
]

{ #category : 'EP-API (Modifiable)' }
XDSeasideTrafficLightPackagingInstructions class >> packagingRulesFor: aRuleCreationInterface [

	super packagingRulesFor: aRuleCreationInterface.
	self applicationNamesToPackage
		do: [:each | aRuleCreationInterface doNotReduceSubApplicationNamed: each]
]

{ #category : 'EP-API (Modifiable)' }
XDSeasideTrafficLightPackagingInstructions class >> startUpClassName [
	"For binary stack dump, use AbtStackDumpStartUp. 
	 For interactive remote debugger, use AbtInteractiveDebugStartUp.
	 For regular string-based walkback.log use AbtHeadlessRuntimeStartUp.
	 "
	^ #AbtStackDumpStartUp
	
	
]
