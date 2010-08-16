accessing
rating: anObject
	"Gravatar allows users to self-rate their images so that they can indicate if an image is appropriate for a certain audience. By default, only 'G' rated images are displayed unless you indicate that you would like to see higher ratings. Using the r= or rating= parameters, you may specify one of the following ratings to request images up to and including that rating:

g: suitable for display on all websites with any audience type.
pg: may contain rude gestures, provocatively dressed individuals, the lesser swear words, or mild violence.
r: may contain such things as harsh profanity, intense violence, nudity, or hard drug use.
x: may contain hardcore sexual imagery or extremely disturbing violence."

	self attributes at: 'r' put: anObject