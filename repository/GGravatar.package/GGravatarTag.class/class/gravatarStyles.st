as yet unclassified
gravatarStyles

	^ GravatarStyles ifNil: [GravatarStyles := {
		#none -> '404' .
		#mysteryMan -> 'mm' .
		#identicon -> 'identicon' .
		#monsterid -> 'monsterid' .
		#wavatar -> 'wavatar' .
		#retro -> 'retro'
	} as: Dictionary]