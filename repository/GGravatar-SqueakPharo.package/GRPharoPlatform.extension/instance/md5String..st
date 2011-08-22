*GGravatar-SqueakPharo-Core
md5String: aString
	"one-method helper for calculating the MD5 based on Cryptography's MD5NonPrimitive class"  
|	
	state processBuffer processFinalBufferBitLength storeLength
	rounds roundFuncIndex  stepTemplFunc
	SinTable ShiftTable IndexTable ABCDTable finalHash
	fABCDMST fXYZ gXYZ hXYZ iXYZ
	cx
	startPosition buf bitLength 
	reverseLoadFrom byteArrayFrom32Reg
	aPositionableStream resultArray
|
	aPositionableStream := aString withBlanksTrimmed asLowercase readStream.

	cx := 2 raisedTo: 32.
	SinTable := Array new: 64.
	1 to: 64 do: [ :i |
		SinTable
			at: i
			put: (ThirtyTwoBitRegister new load: (cx * i sin abs) truncated)].
	ShiftTable := {
		#(7 12 17 22).
		#(5 9 14 20).
		#(4 11 16 23).
		#(6 10 15 21)
		}.
	IndexTable := {
		#(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16).
		#(2 7 12 1 6 11 16 5 10 15 4 9 14 3 8 13).
		#(6 9 12 15 2 5 8 11 14 1 4 7 10 13 16 3).
		#(1 8 15 6 13 4 11 2 9 16 7 14 5 12 3 10)
		}.
	ABCDTable := {
		#(1 2 3 4).
		#(4 1 2 3).
		#(3 4 1 2).
			#(2 3 4 1)
			}.
			
	state := OrderedCollection newFrom: {
			(ThirtyTwoBitRegister new load: 16r67452301).
			(ThirtyTwoBitRegister new load: 16rEFCDAB89).
			(ThirtyTwoBitRegister new load: 16r98BADCFE).
			(ThirtyTwoBitRegister new load: 16r10325476)}.

	reverseLoadFrom := [:register :ba :i | register 
			instVarNamed: #hi put: ((ba at: i + 3) bitShift: 8) + ( ba at: i + 2);
			instVarNamed: #low put: ((ba at: i + 1) bitShift: 8) + ( ba at: i);
			yourself].


	fABCDMST := [:f :a :b :c :d :m :s :t |
		 a += (f value: b value: c value: d); += m; += t; leftRotateBy: s; += b].
	fXYZ := [:x :y :z | x copy bitAnd: y; bitOr: (x copy bitInvert; bitAnd: z)] .
	gXYZ  :=  [:x :y :z| x copy bitAnd: z; bitOr: (z copy bitInvert; bitAnd: y)].
	hXYZ  :=  [:x :y :z| x copy bitXor: y; bitXor: z].
	iXYZ  :=  [:x :y :z| y copy bitXor: (z copy bitInvert; bitOr: x)].

	stepTemplFunc := [:data :item :func |
		"Perform one step in the round"

		| args |
		args :=  {
			func.
			state at: (item at: 1).
			state at: (item at: 2).
			state at: (item at: 3).
			state at: (item at: 4).
			data at: (item at: 5).
			item at: 6.
			item at: 7
			}.
		fABCDMST valueWithPossibleArguments: args].

	roundFuncIndex := [:data :func :round| 
			| shiftIndex template abcd |
		1 to: 16 do: [ :i |
			shiftIndex := (i - 1) \\ 4 + 1.
			abcd := ABCDTable at: shiftIndex.
			template := {
				abcd at: 1. abcd at: 2. abcd at: 3. abcd at: 4.
				(IndexTable at: round) at: i.
				(ShiftTable at: round) at: shiftIndex.
				SinTable at: round - 1 * 16 + i }.
			stepTemplFunc value: data value: template value: func]].

	rounds := [:data |
		"Perform the four rounds with different functions"
		{
		fXYZ .
		gXYZ .
		hXYZ .
		iXYZ 
		} doWithIndex: [ :func :index |
			roundFuncIndex value: data value: func value: index.]].

	processBuffer := [:aByteArray |
	
		| saveState data |
		saveState := state collect: [ :item | item copy ].
		data := Array new: 16.
		1 to: 16 do: [ :index |
			data at: index put:
				(reverseLoadFrom value: ThirtyTwoBitRegister new value: aByteArray value: (index * 4) - 3)].
		rounds value: data.
		1 to: 4 do: [ :index | (state at: index) += (saveState at: index) ]].

	storeLength := [:bLength :aByteArray |
		"Fill in the final 8 bytes of the given ByteArray with a 64-bit
		little-endian representation of the original message length in bits."

		| n i |
		n := bLength.
		i := aByteArray size - 8 + 1.
		[n > 0] whileTrue: [
			aByteArray at: i put: (n bitAnd: 16rFF).
			n := n bitShift: -8.
			i := i + 1]].

	processFinalBufferBitLength := [ :byteArray :length |
		"Pad the buffer until we have an even 64 bytes, then transform"

		| out |
		out := ByteArray new: 64.
		out replaceFrom: 1 to: byteArray size with: byteArray startingAt: 1.
		byteArray size < 56 
			ifTrue: [
				out at: byteArray size + 1 put: 128. "trailing bit"
				storeLength value: length value: out.
				processBuffer value: out]
			ifFalse: [
				"not enough room for the length, so just pad this one, then..."
				byteArray size < 64 ifTrue: [ out at: byteArray size + 1 put: 128 ].
				processBuffer value: out.

				"process one additional block of padding ending with the length"
				out := ByteArray new: 64.  "filled with zeros"
				byteArray size = 64 ifTrue: [ out at: 1 put: 128].
				storeLength value: length value: out.
				processBuffer value: out ]].

	byteArrayFrom32Reg := [:reg |  ByteArray with: (reg low bitAnd: 16rFF) with: (reg low bitShift: -8) with: (reg hi bitAnd: 16rFF) with: (reg hi bitShift: -8)].

	finalHash := [
		(byteArrayFrom32Reg value: (state at: 1)), 
		(byteArrayFrom32Reg value: (state at: 2)), 
		(byteArrayFrom32Reg value: (state at: 3)), 
		(byteArrayFrom32Reg value: (state at: 4))].


	resultArray := aPositionableStream atEnd 
		ifTrue: [
			buf := ByteArray new: 64.
			buf at: 1 put: 128.
			processBuffer value: buf.
			finalHash value]
		ifFalse: [
			startPosition := aPositionableStream position.
			[aPositionableStream atEnd] whileFalse: [
				buf := aPositionableStream next: 64.
				(aPositionableStream atEnd not and: [buf size = 64])
					ifTrue: [processBuffer value: buf]
					ifFalse: [
						bitLength := (aPositionableStream position - startPosition) * 8.
						processFinalBufferBitLength value: buf value: bitLength]].
			finalHash value].
		
	^ resultArray hex