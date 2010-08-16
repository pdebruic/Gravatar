accessing
imgSize: anObject
	"By default, images are presented at 80px by 80px if no size parameter is supplied. You may request images anywhere from 1px up to 512px, however note that many users have lower resolution images, so requesting larger sizes may result in pixelation/low-quality images."

	self attributes at: 's' put: anObject