testing
testCalculateHash
	self img email: ' NiGol@nigol.cz   '.
	self assert: self img calculateHash = '3952cf1670e0256f4fe9089e70d71d49'