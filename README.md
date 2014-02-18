## Information

<table>
<tr> 
<td>Package</td><td>gulp-commonjs-wrap</td>
</tr>
<tr>
<td>Description</td>
<td>Wraps .js files into CommonJS into require.register for client-side usage.</td>
</tr>
</table>

## Usage

First, install `gulp-commonjs-wrap` as a development dependency:

```shell
npm install --save-dev gulp-commonjs-wrap
```

Then, add it to your `gulpfile.js`:

```javascript
var commonjsWrap = require('gulp-commonjs-wrap');

gulp.task('commonjs', function(){
  gulp.src(['lib/*.js'])
    .pipe(commonjsWrap())
    .pipe(gulp.dest('build/'));
});
```


### CommonJS loader
You'll need a loader to detect your wrapped packages. You can use this simple [CommonJS loader](https://github.com/brunch/commonjs-require-definition) which is based off how [brunch.io](http://brunch.io) loads CommonJS packages.

[grunt]: https://github.com/gruntjs/grunt
[getting_started]: https://github.com/gruntjs/grunt/wiki/Getting-started

## API

### commonjsWrap(options)

#### options.autoRequire
Type: `Boolean`  
Default: `false`

Whether to append a require() on the `filepath` directly after the wrap.

Example:

```javascript
var commonjsWrap = require('gulp-commonjs-wrap');

gulp.task('commonjs', function(){
  gulp.src(['lib/*.js'])
    .pipe(commonjsWrap({
      autoRequire: true
    }))
    .pipe(gulp.dest('build/'));
});
```

#### options.pathModifier
Type: `Function`  
Default: `false`

Allows you to set a function in which you can modify the filepath.

Example:

```javascript
var commonjsWrap = require('gulp-commonjs-wrap');

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


## License
Licensed under the MIT license.
