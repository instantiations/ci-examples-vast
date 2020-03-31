Class {
	#name : 'SeasideTrafficLightRootComponent',
	#superclass : 'WAComponent',
	#instVars : [
		'trafficLightComponent'
	],
	#category : 'SeasideTrafficLight'
}

{ #category : 'Not categorized' }
SeasideTrafficLightRootComponent class >> register [

	| application |

	application := WAAdmin register: self asApplicationAt: 'trafficlight'.
	application exceptionHandler: WANullErrorHandler.
	application addLibrary: JQDeploymentLibrary.
	application addLibrary: SeasideTrafficLightFileLibrary.
	^application
]

{ #category : 'Not categorized' }
SeasideTrafficLightRootComponent >> renderContentOn: html [

	html div
		class: 'text-container';
		with: [html text: 'Seaside Traffic Light'].
		
	self renderTrafficLightOn: html.	
]

{ #category : 'Not categorized' }
SeasideTrafficLightRootComponent >> renderTrafficLightOn: html [
	
	html render: self trafficLightComponent.
]

{ #category : 'Not categorized' }
SeasideTrafficLightRootComponent >> trafficLightComponent [

	^trafficLightComponent ifNil: [trafficLightComponent := SeasideTrafficLightComponent new]
]
