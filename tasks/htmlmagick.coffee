colors = require 'colors'
colors.setTheme require 'colors/themes/winston-dark'

module.exports = (grunt)->
  async = require 'async'
  htmlmagick = require '../'
  grunt.registerMultiTask 'htmlmagick','mangle for html.',->
    done = do @async
    options = @options
      before:[]
      use:[]
      after:[]
    
    magics = new htmlmagick
    magics.add magic for magic in options.before
    magics.add magic for magic in options.use
    magics.add magic for magic in options.after

    doSingleTask = (task,next)->
      # normalize sources
      sources = if task.src and task.src.length then task.src else task.orig.src or []
      unless sources.length then do next
      sources = sources.filter (src)-> grunt.file.exists src
      buffer = []
      
      magickTasks = for src in sources
        html = grunt.file.read src
        do (src,html,buffer)-> (next)->
          magics.exec html,(error,html)->
            if error then throw new Error error
            
            destfile = task.dest or src
            if destfile is src
              console.log 'override:'.info,destfile.data
            else if sources.length is 1
              console.log 'convert:'.info,src.data,'-->',destfile.data
            else
              console.log 'concat:'.info,src.data,'-->',destfile.data
            
            buffer.push html
            if buffer.length is sources.length
              grunt.file.write destfile,buffer.join '\n'

            do next
      async.series magickTasks,next

    tasks = for task in @files
      do (task)-> (next)-> doSingleTask task,next
    async.parallel tasks,done