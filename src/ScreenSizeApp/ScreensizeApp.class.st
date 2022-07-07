Class {
	#name : #ScreensizeApp,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'text'
	],
	#category : #ScreenSizeApp
}

{ #category : #description }
ScreensizeApp class >> appClasses [
	<pharoJsSkip>
	^super appClasses
]

{ #category : #'initialize-release' }
ScreensizeApp >> start [

	super start.
	text := document getElementById: #screensize.
	window addEventListener: #resize block: [ 
		text innerHTML:
			window innerWidth asString , 'x' , window innerHeight asString ].

	text innerHTML:
		window innerWidth asString , 'x' , window innerHeight asString
]
