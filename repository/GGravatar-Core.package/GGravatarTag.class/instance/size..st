as yet unclassified
size: anInteger
	| size |
	size := anInteger min: 512 max: 1.
	url addField: 'size' value: size asString.
	self
		height: size;
		width: size