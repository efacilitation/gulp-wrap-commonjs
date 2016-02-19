'use strict'

PLUGIN_NAME = 'gulp-wrap-commonjs'

fs      = require 'fs'
path    = require 'path'
_       = require 'lodash'
through = require 'through2'

defaultOptions =
  autoRequire: false
  moduleExports: false
  relativePath: false
  pathModifier: false
  coffee: false

isCoffeeScript = (filePath) ->
  filePath.slice(-7) is '.coffee'

module.exports = (options = {}) ->

  _.defaults options, defaultOptions

  templateJs     = _.template fs.readFileSync  "#{__dirname}/templates/js.tpl", encoding: 'utf8'
  templateCoffee = _.template fs.readFileSync  "#{__dirname}/templates/coffee.tpl", encoding: 'utf8'

  through.obj (file, enc, next) ->
    if file.isBuffer()

      filePath = file.path
      if typeof options.pathModifier is "function"
        filePath = options.pathModifier file.path
      if typeof options.relativePath is "string"
        filePath = path.relative(path.join(process.cwd(), options.relativePath), filePath)

      params =
        contents: file.contents.toString 'utf8'
        filePath: filePath
        autoRequire: options.autoRequire
        moduleExports: options.moduleExports

      if options.coffee || isCoffeeScript file.path
        wrappedContent = templateCoffee params

      else
        wrappedContent = templateJs params

      file.contents = new Buffer wrappedContent


    next null, file
