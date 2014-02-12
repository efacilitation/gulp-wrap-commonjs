'use strict'

PLUGIN_NAME = 'gulp-commonjs-enhanced'

fs                    = require 'fs'
_ = require 'lodash'
through = require 'through2'

defaultOptions =
  pathModifier: (path) ->
    path

module.exports = (options = {}) ->

  _.defaults options, defaultOptions

  template = fs.readFileSync  "#{__dirname}/template.js", encoding: 'utf8'
  template = _.template template

  through.obj (file, enc, next) ->

    if file.isBuffer()

      filePath = options.pathModifier file.relative

      params =
        contents: file.contents.toString 'utf8'
        filePath: filePath

      file.contents = new Buffer template params

    next null, file
    #console.log this
