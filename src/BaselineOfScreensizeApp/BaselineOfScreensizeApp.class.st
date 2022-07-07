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
			baseline: 'PharoJS'
			with: [ spec repository: 'github://PharoJS/PharoJS:pharo9' ].
		spec package: #ScreensizeApp ]
]
