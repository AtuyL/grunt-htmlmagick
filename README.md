# grunt-htmlmagick v1.0.0

> mangle for html.

## Getting Started
This plugin requires Grunt `~0.4.0`

```shell
npm install --save-dev grunt-htmlmagick
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-htmlmagick');
```

## Example (coffee-style)

```coffee

# addAlt is most simple magick.
# Please your imagine.
addAlt = (html,callback)->
  # this.$ is jQuery 2.1.0 (current version)
  this.$('img:not([alt])').attr 'alt',''
  return callback null
  
  # if task is error then call this.
  # in that case then block the task.
  return callback 'errortype'

grunt.initConfig
  htmlmagick:
    imgfix:
      options:
        use:[addAlt] # subscribe the addAlt magick
      files:[
        'test/after/index.html':['test/before/index.html']
        'test/after/aboutme.html':['test/before/aboutme.html']
        'test/after/contact.html':['test/before/contact.html']
      ]
```

## For more information, please see below.
`node_modules/grunt-htmlmagick/test/gruntfile.coffee`

## Release History

 * 2014-04-26 1.0.0 bundle the jquery

---

Task submitted by [AtuyL](http://atuyl.jp)

*This document is extended from **grunt-contrib-coffee** document.*  
*thank you for reading. :)*