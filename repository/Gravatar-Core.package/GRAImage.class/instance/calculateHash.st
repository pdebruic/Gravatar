private
calculateHash
	^ (MD5 hashMessage: self email translateToLowercase withBlanksTrimmed) hex