Class {
	#name : 'SeasideTrafficLightFileLibrary',
	#superclass : 'WAFileLibrary',
	#category : 'SeasideTrafficLight'
}

{ #category : 'Not categorized' }
SeasideTrafficLightFileLibrary >> SeasideTrafficLightMainCss [
	^ ' 

body {
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-weight: 200;
  font-size: 2em;
  background-color: #eafeea;
  border: 0;
  margin: 0;
}

.text-container{
  text-align: center;
  padding: 20px;
}

.container{
  background: #000;
  width: 132px;
  height: 380px;
  box-shadow: 0 0 15px rgba(0,0,2, .9);
  margin: auto;
  padding: 15px;
  border-radius: 10px;
}

.spacer{
  padding: 2px;
}

.light{
  border-radius: 100%;
  width: 100px;
  height: 100px;
  opacity: 0.3;
  padding: 10px;
  border: 2px inset white;
  margin: auto;
  box-shadow: 0 0 5px rgba(255,255,255, 1);
}

#red{
	background-color: red;
}

#yellow{
	background-color: #e6e600;
}

#green{
  background-color: #27e833;
}

.light-visible {
  opacity: 1;
}


'
]

{ #category : 'Not categorized' }
SeasideTrafficLightFileLibrary >> selectorsToInclude [
	^ #( #SeasideTrafficLightMainCss )
]
