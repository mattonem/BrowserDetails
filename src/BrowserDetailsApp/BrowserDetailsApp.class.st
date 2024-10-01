Class {
	#name : 'BrowserDetailsApp',
	#superclass : 'PjFileBasedWebApp',
	#category : 'BrowserDetailsApp',
	#package : 'BrowserDetailsApp'
}

{ #category : 'description' }
BrowserDetailsApp class >> appClasses [
	<pharoJsSkip>
	^super appClasses
]

{ #category : 'description' }
BrowserDetailsApp class >> bridgeClientClass [
	<pharoJsSkip>
	
	^ PjZnHostedBrowserBridgeClient
]

{ #category : 'description' }
BrowserDetailsApp class >> exporterClass [
	<pharoJsSkip>
	
	^ PjFileExporterWithIndexHtml
]

{ #category : 'description' }
BrowserDetailsApp class >> generateHtmlUsing: html [

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
						with: 'User agent:'.
					html div
						class: 'card-body';
						with: [
							html preformatted
								id: 'userAgent';
								with: '' ] ].
			html div
				class: 'card text-center';
				with: [
					html div
						class: 'card-header';
						with: 'User language:'.
					html div
						class: 'card-body';
						with: [
							html preformatted
								id: 'userLanguage';
								with: '' ] ].
			html div
				class: 'card text-center';
				with: [
					html div
						class: 'card-header';
						with: 'Your IP address is:'.
					html div
						class: 'card-body';
						with: [
							html heading
								level: 1;
								id: 'ipAddress';
								with: '' ] ] ]
]

{ #category : 'description' }
BrowserDetailsApp class >> updateHtmlRoot: root [

	<pharoJsSkip>
	root language: 'en'.
	root stylesheet url:
		'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'
]

{ #category : 'initialize-release' }
BrowserDetailsApp >> start [

	| client iptext uaText langText |
	super start.
	iptext := document getElementById: #screensize.
	uaText := document getElementById: #userAgent.
	langText := document getElementById: #userLanguage.

	window addEventListener: #resize block: [
		iptext innerHTML:
			window innerWidth asString , 'x' , window innerHeight asString ].

	iptext innerHTML:
		window innerWidth asString , 'x' , window innerHeight asString.

	uaText innerHTML: navigator userAgent.
	langText innerHTML: navigator language.
	iptext := document getElementById: #ipAddress.
	client := PjHttpClient new.
	client
		getUrl: 'https://www.cloudflare.com/cdn-cgi/trace'
		do: [ :response :status |
			'ip=(.*)\n' asRegex matchesIn: response do: [ :ligne |
				'(\d+)\.(\d+)\.(\d+)\.(\d+)' asRegex
					matchesIn: ligne
					do: [ :ip | iptext innerHTML: ip ] ] ]
]
