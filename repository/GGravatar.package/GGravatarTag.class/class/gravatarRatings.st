as yet unclassified
gravatarRatings

	^ GravatarRatings ifNil: [GravatarRatings := {
		#generalAudiences -> 'g' .
		#parentalGuidance -> 'pg' .
		#restricted -> 'r'.
		#adult -> 'x'
	} as: Dictionary]