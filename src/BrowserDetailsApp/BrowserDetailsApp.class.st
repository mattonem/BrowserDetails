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
		class: 'container';
		with: [
			html div
				class: 'card col-10 mx-auto text-center';
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
				class: 'card col-10 mx-auto text-center';
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
				class: 'card col-10 mx-auto text-center';
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
				class: 'card col-10 mx-auto text-center';
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
BrowserDetailsApp >> ipv4Regex [

	^ '((\d+)\.(\d+)\.(\d+)\.(\d+))'
]

{ #category : 'initialize-release' }
BrowserDetailsApp >> ipv6Regex [

	^ '(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))'
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
				('(' , self ipv4Regex , '|' , self ipv6Regex , ')')asRegex
					matchesIn: ligne
					do: [ :ip |
						console log: ip.
						iptext innerHTML: ip ] ] ]
]
