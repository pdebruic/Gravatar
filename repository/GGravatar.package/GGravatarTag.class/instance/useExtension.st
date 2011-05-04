as yet unclassified
useExtension

	| last |
	last := url path removeLast.
	url addToPath: last, self class gravatarExtension.