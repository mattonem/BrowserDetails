Class {
	#name : #BaselineOfBrowserDetailsApp,
	#superclass : #BaselineOf,
	#category : #BaselineOfBrowserDetailsApp
}

{ #category : #dependencies }
BaselineOfBrowserDetailsApp >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'Camping'
			with: [ spec repository: 'github://mattonem/WildCamping:master' ].
				spec
			baseline: 'PjHttpClient'
			with: [ spec repository: 'github://mattonem/RestClientApp:master' ].

		spec package: #BrowserDetailsApp ]
]
