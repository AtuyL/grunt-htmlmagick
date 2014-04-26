beforeMagick = (html,callback)->
  callback null,html
  return

afterMagick = (html,callback)->
  callback null
  return

addAlt = (html,callback)->
  this.$('img:not([alt])').attr 'alt',''
  return callback null

module.exports = (grunt)->
  grunt.file.setBase '../'
  
  for taskname of grunt.file.readJSON('package.json').devDependencies when /^grunt-/.test taskname
    grunt.loadNpmTasks taskname
  grunt.loadTasks 'tasks'

  grunt.initConfig
    clean:['test/before','test/after']
    
    jade:
      options:
        pretty:true
      makebefore:
        options:
          data:(dest,srcs)->
            title:dest
        files:[expand:true,cwd:'test/src',src:"*.jade",dest:'test/before',ext:'.html']
    
    htmlmagick:
      options:
        before:[beforeMagick]
        after:[afterMagick]
      error:
        options:
          use:[addAlt]
        src:['test/before/error.html']
      a:
        options:
          use:[addAlt]
        src:['test/before/a.html']
      bc:
        options:
          use:[addAlt]
        files:
          'test/after/b.html':['test/before/b.html']
          'test/after/c.html':['test/before/c.html']
      multisource:
        options:
          use:[addAlt]
        files:'test/after/abc.html':['test/before/a.html','test/before/b.html','test/before/c.html']

    connect:
      options:
        keepalive:true
        hostname:'*'
        open:"http://#{do require('my-ip')}:8000"
      server:
        base:'test/after'
  
  grunt.registerTask 'default',['clean','jade','htmlmagick']