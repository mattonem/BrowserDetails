Class {
	#name : #ScreensizeApp,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'text'
	],
	#category : #ScreensizeApp
}

{ #category : #description }
ScreensizeApp class >> appClasses [
	<pharoJsSkip>
	^super appClasses
]

{ #category : #description }
ScreensizeApp class >> bridgeClientClass [
	<pharoJsSkip>
	
	^ PjZnHostedBrowserBridgeClient
]

{ #category : #description }
ScreensizeApp class >> exporterClass [
	<pharoJsSkip>
	
	^ PjFileExporterWithIndexHtml
]

{ #category : #description }
ScreensizeApp class >> generateHtmlUsing: html [

	<pharoJsSkip>
	html div
		class: 'container-fluid';
		with: [
			html div
				class: 'card text-center';
				with: [
					html div
						class: 'card-header';
						with: 'Your viewport size is:'.
					html div
						class: 'card-body';
						with: [
							html heading
								level: 1;
								id: 'screensize';
								with: '' ] ] ]
]

{ #category : #description }
ScreensizeApp class >> updateHtmlRoot: root [

	<pharoJsSkip>
	root stylesheet url:
		'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'.
	root meta language: 'en'
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
