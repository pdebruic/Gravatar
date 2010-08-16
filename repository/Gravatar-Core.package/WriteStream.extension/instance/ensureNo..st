*gravatar-core
ensureNo: aCharacter
	"If there is not one on the end, remove it."

	(position > 0 and: [ (collection at: position) = aCharacter ])
		ifTrue: [ self skip: -1 ]