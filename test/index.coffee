htmlmagick = new (require '../')

htmlmagick.add (html,callback)->
	html += '1'
	callback null,html
htmlmagick.add (html,callback)->
	html += '2'
	callback null,html
htmlmagick.add rm = (html,callback)->
	html += 'removable'
	callback null,html
htmlmagick.add (html,callback)->
	html += '3'
	callback null,html
htmlmagick.add (html,callback)->
	html += '4'
	callback null,html

htmlmagick.remove rm

htmlmagick.exec 'start:',(err,html)->
	console.log err,html