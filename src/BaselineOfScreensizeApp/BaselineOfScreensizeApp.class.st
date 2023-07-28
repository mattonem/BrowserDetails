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

		spec package: #ScreensizeApp ]
]
