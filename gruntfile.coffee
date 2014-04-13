module.exports = (grunt)->
  grunt.loadNpmTasks key for key,value of grunt.file.readJSON('package.json').devDependencies when /^grunt-/.test key
  grunt.loadTasks 'tasks'
  
  ip = do -> return b.address for b in a when not b.internal and b.family is 'IPv4' for key,a of do require('os').networkInterfaces
  port = 8000

  beforeMagick = (html,callback)->
    # html += 'he'
    callback null,html
    return
  afterMagick = (html,callback)->
    callback null
    return
  localMagick = (html,callback)->
    window = this
    for img in window.document.querySelectorAll 'img'
      img.setAttribute 'src','hoge'
    callback null
    return

  grunt.initConfig
    clean:['test/**/*.html']
    jade:
      options:pretty:true
      a:
        options:data:title:'a'
        files:'test/a.html':'test/index.jade'
      b:
        options:data:title:'b'
        files:'test/b.html':'test/index.jade'
      c:
        options:data:title:'c'
        files:'test/c.html':'test/index.jade'
    htmlmagick:
      options:
        before:[beforeMagick]
        after:[afterMagick]
      nodest:
        options:use:[localMagick,localMagick]
        src:['test/a.html']
      # nodestmulti:
      #   options:use:[localMagick,localMagick]
      #   src:['test/b.html','test/c.html']
      # hasdest:
      #   options:use:[localMagick,localMagick]
      #   files:
      #     'test/b_magick.html':['test/b.html']
      #     'test/c_magick.html':['test/c.html']
      # multisource:
      #   options:use:[localMagick,localMagick]
      #   files:'test/c_magick.html':['test/a.html','test/b.html','test/c.html']
    browse:["http://#{ip}:#{port}"]
    connect:server:base:'test'
  
  grunt.registerMultiTask 'browse',->require('child_process').exec "open #{@data}"
  grunt.registerTask 'default',['clean','jade','htmlmagick']