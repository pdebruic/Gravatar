as yet unclassified
email: anEmail

	url addToPath: (GRPlatform current md5String: (anEmail isString
		ifTrue: [anEmail]
		ifFalse: ["assume a WAEmailAddress" anEmail address])).
