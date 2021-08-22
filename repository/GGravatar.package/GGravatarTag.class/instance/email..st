as yet unclassified
email: anEmail

	url addToPath: (self class md5String: (anEmail isString
		ifTrue: [anEmail]
		ifFalse: ["assume a WAEmailAddress" anEmail address])).
