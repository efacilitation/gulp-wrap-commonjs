## Information

<table>
<tr>
<td>Package</td><td>gulp-wrap-commonjs</td>
</tr>
<tr>
<td>Description</td>
<td>Wrap files into a CommonJS module definition compatible with the Node.js require() API.</td>
</tr>
</table>

## Usage

First, install `gulp-wrap-commonjs` as a development dependency:

```shell
npm install --save-dev gulp-wrap-commonjs
```

Then, add it to your `gulpfile.js`:

```javascript
var wrapCommonjs = require('gulp-wrap-commonjs');

gulp.task('commonjs', function(){
  gulp.src(['lib/*.js'])
    .pipe(wrapCommonjs())
    .pipe(gulp.dest('build/'));
});
```

Works with JavaScript- and CoffeeScript-Files.



### CommonJS Require

You need a `require.register` function in the scope where you add the wrapped files. It's recommended to use [commonjs-require](https://github.com/efacilitation/commonjs-require) for this purpose.


## API

### commonjsWrap(options)

#### options.autoRequire
Type: `Boolean`
Default: `false`

Whether to append a require() on the `filepath` directly after the wrap.

Example:

```javascript
var commonjsWrap = require('gulp-wrap-commonjs');

gulp.task('commonjs', function(){
  gulp.src(['lib/*.js'])
    .pipe(commonjsWrap({
      autoRequire: true
    }))
    .pipe(gulp.dest('build/'));
});
```

#### options.relativePath
Type: `String`
Default: `false`

Allows you to set a base directory, which will allow modules to use relative
paths.

Example:

```javascript
var commonjsWrap = require('gulp-wrap-commonjs');

gulp.task('commonjs', function(){
  gulp.src(['lib/*.js'])
    .pipe(commonjsWrap({
      relativePath: 'lib'
    }))
    .pipe(gulp.dest('build/'));
});

```

produces modules that look like:

```js
require.register("module.js", function(exports, require, module){
```

instead of

```js
require.register("/path/to/project/lib/module.js", function(exports, require, module){
```

#### options.pathModifier
Type: `Function`
Default: `false`

Allows you to set a function in which you can modify the filepath.

Example:

```javascript
var commonjsWrap = require('gulp-wrap-commonjs');

gulp.task('commonjs', function(){
  gulp.src(['lib/*.js'])
    .pipe(commonjsWrap({
      pathModifier: function (path) {
        path = path.replace /.js$/, ''
        return path
      }
    }))
    .pipe(gulp.dest('build/'));
});
```



#### options.moduleExports
Type: `Function` or `String`
Default: `null`

Allows you to set a `module.exports` at the end of the `content`

Example using Jade:

```javascript
var wrapCommonjs = require('gulp-wrap-commonjs');

gulp.task('commonjs', function(){
  gulp.src(['lib/*.jade'])
    .pipe(wrapCommonjs({moduleExports: "template"}))
    .pipe(gulp.dest('build/'));
});
```

When passed in a function the value of `module.exports` can be determined dynamically.
When used the path of each processed file is passed as argument to the function.
If the function returns `null` or `undefined` no `module.exports` will be set.

```javascript
var wrapCommonjs = require('gulp-wrap-commonjs');

gulp.task('commonjs', function(){
  gulp.src(['lib/*.jade'])
    .pipe(wrapCommonjs({
      moduleExports: function(path) {
        if (path.indexOf('some-module') > 0) {
          return 'someExports';
        }
      }
    }))
    .pipe(gulp.dest('build/'));
});
```

#### options.coffee
Type: `Boolean`
Default: `false`

Force wrapping into CoffeeScript. By default this will get set by detecting the file-extension `.coffee`.

Example:

```javascript
var wrapCommonjs = require('gulp-wrap-commonjs');

gulp.task('commonjs', function(){
  gulp.src(['lib/*.txt'])
    .pipe(wrapCommonjs({coffee: true}))
    .pipe(gulp.dest('build/'));
});
```


## License

MIT

Copyright (c) 2014 efa GmbH (http://efa-gmbh.com/)
