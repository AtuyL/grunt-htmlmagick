async = require 'async'
jsdom = require 'jsdom'
module.exports = class htmlmagick
  $:null
  magicks:null
  add:(magick)->
    @remove magick
    @magicks.push magick
    return
  remove:(magick)->
    @magicks ?= []
    while ~(index = @magicks.indexOf magick) then @magicks.splice index,1
    return
  exec:(html,callback)->
    document = jsdom.jsdom html
    window = document.parentWindow
    doMagick = (html,magick,next)=> magick.call window,html,(error,html)->
      if html instanceof String or html is ''
        next error,html
      else
        next error,[document.doctype.toString(),document.documentElement.outerHTML].join '\n'
      
    async.reduce @magicks,html,doMagick,callback
    return