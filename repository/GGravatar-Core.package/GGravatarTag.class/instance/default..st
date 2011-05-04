as yet unclassified
default: aSymbol

	url addField: 'd' value: (self class gravatarStyles 
		at: aSymbol 
		ifAbsent: [self class gravatarStyles at: self class gravatarDefaultStyle]).