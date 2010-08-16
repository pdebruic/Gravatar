testing
testComposeUrl
	self img email: ' NiGol@nigol.cz   '.
	self assert: self img composeUrl = 'http://www.gravatar.com/avatar/3952cf1670e0256f4fe9089e70d71d49'.
	self img imgSize: 120.
	self assert: self img composeUrl = 'http://www.gravatar.com/avatar/3952cf1670e0256f4fe9089e70d71d49?s=120'.
	self img defaultImage: #mm.
	self assert: self img composeUrl = 'http://www.gravatar.com/avatar/3952cf1670e0256f4fe9089e70d71d49?s=120&d=mm'.
	self img defaultImage: #identicon.
	self assert: self img composeUrl = 'http://www.gravatar.com/avatar/3952cf1670e0256f4fe9089e70d71d49?s=120&d=identicon'.
	self img defaultImage: #monsterid.
	self assert: self img composeUrl = 'http://www.gravatar.com/avatar/3952cf1670e0256f4fe9089e70d71d49?s=120&d=monsterid'.
	self img defaultImage: #wavatar.
	self assert: self img composeUrl = 'http://www.gravatar.com/avatar/3952cf1670e0256f4fe9089e70d71d49?s=120&d=wavatar'.
	self img rating: #g.
	self
		assert: self img composeUrl = 'http://www.gravatar.com/avatar/3952cf1670e0256f4fe9089e70d71d49?s=120&d=wavatar&r=g'.
	self img rating: #pg.
	self
		assert: self img composeUrl = 'http://www.gravatar.com/avatar/3952cf1670e0256f4fe9089e70d71d49?s=120&d=wavatar&r=pg'.
	self img rating: #r.
	self
		assert: self img composeUrl = 'http://www.gravatar.com/avatar/3952cf1670e0256f4fe9089e70d71d49?s=120&d=wavatar&r=r'.
	self img rating: #x.
	self
		assert: self img composeUrl = 'http://www.gravatar.com/avatar/3952cf1670e0256f4fe9089e70d71d49?s=120&d=wavatar&r=x'