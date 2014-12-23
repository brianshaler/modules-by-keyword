# modules-by-keyword

Get package names for locally installed modules that contain a given keyword in
their package.json `keywords` field.

### Install

    npm install modules-by-keyword

### Usage

```js
var modulesByKeyword = require('modules-by-keyword');
modulesByKeyword('gulpplugin')
.then(function (moduleNames) {
  console.log('gulp plugins:', moduleNames);
});

// optionally, set directory to search
modulesByKeyword('gulpplugin', __dirname + '/node_modules')
.then(function (moduleNames) {
  console.log('gulp plugins:', moduleNames);
});
```
