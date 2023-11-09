Class {
	#name : #BaselineOfScreensizeApp,
	#superclass : #BaselineOf,
	#category : #BaselineOfScreensizeApp
}

{ #category : #dependencies }
BaselineOfScreensizeApp >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'Camping'
			with: [ spec repository: 'github://mattonem/WildCamping:master' ].
				spec
			baseline: 'PjHttpClient'
			with: [ spec repository: 'github://mattonem/RestClientApp:master' ].

		spec package: #ScreensizeApp ]
]
