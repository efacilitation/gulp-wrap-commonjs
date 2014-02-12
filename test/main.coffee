fs                    = require 'fs'
gutil                 = require 'gulp-util'
gulpCommonjsWrap  = require '../'

#expect = require 'expect'


describe 'gulp-commonjs-wrap', ->

  it 'should ', (next) ->

    expected = fs.readFileSync 'test/fixtures/test_expected.js', encoding: 'utf8'

    srcFile = new gutil.File
      cwd: 'test/'
      path: 'test/fixtures/test.js'
      base: 'test/fixtures'
      contents: fs.readFileSync 'test/fixtures/test.js'

    stream = gulpCommonjsWrap
      pathModifier: (path) ->
        path.replace '.js', ''

    stream.on 'error', (error) ->
      #expect(error)
      next(error)

    stream.on 'data', (file) ->
      content = file.contents.toString("utf8");
      console.log content
      next()

    stream.write srcFile
    stream.end()