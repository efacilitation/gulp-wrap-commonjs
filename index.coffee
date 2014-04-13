'use strict'

PLUGIN_NAME = 'gulp-wrap-commonjs'

fs      = require 'fs'
_       = require 'lodash'
through = require 'through2'

defaultOptions =
  autoRequire: false
  moduleExports: false
  pathModifier: false

module.exports = (options = {}) ->

  _.defaults options, defaultOptions

  template = fs.readFileSync  "#{__dirname}/template.js", encoding: 'utf8'
  template = _.template template

  through.obj (file, enc, next) ->

    if file.isBuffer()

      if typeof options.pathModifier is "function"
        filePath = options.pathModifier file.path

      params =
        contents: file.contents.toString 'utf8'
        filePath: filePath
        autoRequire: options.autoRequire
        moduleExports: options.moduleExports

      file.contents = new Buffer template params


    next null, file
