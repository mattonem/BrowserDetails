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
								with: '' ] ].
			html div
				class: 'card text-center';
				with: [
					html div
						class: 'card-header';
						with: 'Your IP adress is:'.
					html div
						class: 'card-body';
						with: [
							html heading
								level: 1;
								id: 'ipAddress';
								with: '' ] ] ]
]

{ #category : #description }
ScreensizeApp class >> updateHtmlRoot: root [

	<pharoJsSkip>
	root language: 'en'.
	root stylesheet url:
		'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'
]

{ #category : #'initialize-release' }
ScreensizeApp >> start [

	| client req iptext |
	super start.
	text := document getElementById: #screensize.
	window addEventListener: #resize block: [
		text innerHTML:
			window innerWidth asString , 'x' , window innerHeight asString ].

	text innerHTML:
		window innerWidth asString , 'x' , window innerHeight asString.
	iptext := document getElementById: #ipAddress.
	client := PjHttpClient new.
	client onLoad: [ :aClient |
		| response |
		response := aClient currentTarget responseText.
		'ip=(.*)\n' asRegex
			matchesIn: response
			do: [ :ligne | 
				'(\d+)\.(\d+)\.(\d+)\.(\d+)' asRegex
			matchesIn: ligne
			do:[:ip |
				
				iptext innerHTML: ip] ] ].
	req := client
		       method: 'GET'
		       url: 'https://www.cloudflare.com/cdn-cgi/trace'.
	req send: ''
]
