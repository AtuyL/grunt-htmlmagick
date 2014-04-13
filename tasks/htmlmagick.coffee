module.exports = (grunt)->
  async = require 'async'
  htmlmagick = require '../'
  grunt.registerMultiTask 'htmlmagick',->
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
      magickTasks = for src in task.src when html = grunt.file.read src  
        do (src,html)-> (next)->
          magics.exec html,(error,html)->
            if error then throw new Error error
            destfile = task.dest or src
            grunt.file.write destfile,html
            do next
      async.series magickTasks,next

    tasks = for task in @files then do (task)->
      (next)-> doSingleTask task,next
    async.parallel tasks,done