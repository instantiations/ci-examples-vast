Class {
	#name : 'SeasideTrafficLightEntryPoint',
	#superclass : 'Object',
	#category : 'SeasideTrafficLight'
}

{ #category : 'Not categorized' }
SeasideTrafficLightEntryPoint class >> startApplication [
	SeasideTrafficLightRootComponent register.
	self startSeasideAdapotors.
]

{ #category : 'Not categorized' }
SeasideTrafficLightEntryPoint class >> startSeasideAdapotors [

	| adaptor |

	WASstServerAdaptor allInstances do: [:each | each stop].
	adaptor := WASstServerAdaptor port: 7777.
	adaptor codec: (GRCodec forEncoding: 'utf-8').
	adaptor start
]
