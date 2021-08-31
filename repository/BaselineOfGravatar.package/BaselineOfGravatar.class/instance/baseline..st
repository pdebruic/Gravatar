baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'Seaside3'
				with: [ spec
						repository: 'github://SeasideSt/Seaside:master/repository';
						loads: #('Seaside-Core' 'Seaside-Canvas') ].
			spec package: 'GGravatar-Core' with: [ spec requires: 'Seaside3' ] ].
	spec
		for: #squeakCommon
		do: [ spec
				package: 'GGravatar-SqueakPharo'
				with: [ spec requires: #('GGravatar-Core') ].
			spec group: 'default' with: #('GGravatar-SqueakPharo').
			spec group: 'Core' with: #('GGravatar-SqueakPharo') ].
	spec
		for: #gemstone
		do: [ spec
				package: 'GGravatar-GemStone-Core'
				with: [ spec requires: #('GGravatar-Core') ].
			spec group: 'default' with: #('GGravatar-GemStone-Core').
			spec group: 'Core' with: #('GGravatar-GemStone-Core') ]