as yet unclassified
rating: aSymbol

	url addField: 'rating' value: (self class gravatarRatings
		at: aSymbol 
		ifAbsent: [self class gravatarRatings at: self class gravatarDefaultRating]).