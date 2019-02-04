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
			spec package: 'GGravatar-Core' with: [ spec requires: 'Seaside3' ].
			spec group: 'default' with: #('GGravatar-Core') ].
	spec
		for: #squeakCommon
		do: [ spec
				package: 'GGravatar-Core'
					with: [ spec includes: #('GGravatar-SqueakPharo') ];
				package: 'GGravatar-SqueakPharo'
					with: [ spec requires: #('GGravatar-Core') ] ].
	spec
		for: #gemstone
		do: [ spec
				package: 'GGravatar-Core'
					with: [ spec includes: #('GGravatar-GemStone-Core') ];
				package: 'GGravatar-GemStone-Core'
					with: [ spec requires: #('GGravatar-Core') ] ]