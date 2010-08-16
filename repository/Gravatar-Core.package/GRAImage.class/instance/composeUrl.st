private
composeUrl
	^ String
		streamContents: [ :stream | 
			stream nextPutAll: 'http://www.gravatar.com/avatar/'.
			stream nextPutAll: self calculateHash.
			self attributes size > 0
				ifTrue: [ 
					stream nextPutAll: '?'.
					self attributes
						keysAndValuesDo: [ :key :value | 
							stream nextPutAll: key.
							stream nextPutAll: '='.
							stream nextPutAll: value asString.
							stream nextPutAll: '&' ].
					stream ensureNo: $& ] ]