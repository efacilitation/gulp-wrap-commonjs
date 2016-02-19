'use strict'

PLUGIN_NAME = 'gulp-wrap-commonjs'

path            = require 'path'
fs              = require 'fs'
_               = require 'lodash'
through         = require 'through2'
Replacer        = require 'regexp-sourcemaps'
applySourceMaps = require 'vinyl-sourcemaps-apply'

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
        filePath: filePath
        autoRequire: options.autoRequire
        moduleExports: options.moduleExports

      if options.coffee || isCoffeeScript file.path
        wrappedReplace = templateCoffee params

      else
        wrappedReplace = templateJs params

      replacer = new Replacer(/^(.|\n)*$/, wrappedReplace, (filePath + '.commonjs-wrap'))

      res = replacer.replace (file.contents.toString 'utf8'), file.relative

      file.contents = new Buffer res.code

      if file.sourceMap
        applySourceMaps file, res.map


    next null, file
