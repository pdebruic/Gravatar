as yet unclassified
email: anEmail

	url addToPath: (GRPlatform current md5String: (anEmail isString
		ifTrue: [anEmail asLowercase]
		ifFalse: ["assume a WAEmailAddress" anEmail address asLowercase])).
