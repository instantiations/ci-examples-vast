Class {
	#name : 'SeasideTrafficLightComponent',
	#superclass : 'WAComponent',
	#instVars : [
		'redLightStatus',
		'yellowLightStatus',
		'greenLightStatus'
	],
	#category : 'SeasideTrafficLight'
}

{ #category : 'Initialization' }
SeasideTrafficLightComponent >> initialize [

	super initialize.
	self turnAllOff.
	self setRedLight: true.
]

{ #category : 'Rendering' }
SeasideTrafficLightComponent >> renderContentOn: html [

	html div
		class: 'container';
		with: [
			self renderRedLightOn: html.
			html div class: 'spacer'.
			self renderYellowLightOn: html.
			html div class: 'spacer'.
			self renderGreenLightOn: html]


]

{ #category : 'Rendering' }
SeasideTrafficLightComponent >> renderGreenLightOn: html [

	html anchor
		callback: [self toggleGreenLight];
		with: [
			html div
				class: 'light';
				class: 'light-visible' if: greenLightStatus;
				id: 'green']
]

{ #category : 'Rendering' }
SeasideTrafficLightComponent >> renderRedLightOn: html [

	html anchor
		callback: [self toggleRedLight];
		with: [
			html div
				class: 'light';
				class: 'light-visible' if: redLightStatus;
				id: 'red']
]

{ #category : 'Rendering' }
SeasideTrafficLightComponent >> renderYellowLightOn: html [

	html anchor
		callback: [self toggleYellowLight];
		with: [
			html div
				class: 'light';
				class: 'light-visible' if: yellowLightStatus;
				id: 'yellow']
]

{ #category : 'Accessing' }
SeasideTrafficLightComponent >> setGreenLight: aBoolean [
 
	greenLightStatus := true
]

{ #category : 'Accessing' }
SeasideTrafficLightComponent >> setRedLight: aBoolean [

	redLightStatus := true
]

{ #category : 'Accessing' }
SeasideTrafficLightComponent >> setYellowLight: aBoolean [

	yellowLightStatus := true
]

{ #category : 'Actions' }
SeasideTrafficLightComponent >> toggleGreenLight [

	Halt halt.
	self turnAllOff.
	self setGreenLight: true
]

{ #category : 'Actions' }
SeasideTrafficLightComponent >> toggleRedLight [

	self turnAllOff.
	self setRedLight: true
]

{ #category : 'Actions' }
SeasideTrafficLightComponent >> toggleYellowLight [

	self turnAllOff.
	self setYellowLight: true
]

{ #category : 'Actions' }
SeasideTrafficLightComponent >> turnAllOff [

	redLightStatus := false.
	yellowLightStatus := false.
	greenLightStatus := false
]
