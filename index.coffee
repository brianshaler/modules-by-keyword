path = require 'path'
_ = require 'lodash'
Promise = require 'when'
fs = require 'q-io/fs'

defaultPath = path.resolve __dirname, '..'

getModules = (dir, moduleNames) ->
  Promise.all _.map moduleNames, (moduleName) ->
    getPackageJson path.join dir, moduleName
  .then (pkgs) ->
    pkgs

getPackageJson = (dir, moduleName) ->
  exists = false
  pkgPath = path.join dir, 'package.json'
  fs.exists pkgPath
  .then (_exists) ->
    fs.read pkgPath if _exists
  .then (contents) ->
    JSON.parse contents if contents
  .then (obj) ->
    if obj?.name is moduleName
      return obj
    obj
  .catch (err) ->
    null
  .then (obj) ->
    obj

filterByKeyword = (keyword, modules) ->
  filtered = _.filter modules, (obj) ->
    obj?.keywords?.length > 0 and -1 != obj.keywords.indexOf keyword
  filtered

pluckNames = (objs) ->
  _.pluck objs, 'name'

module.exports = (keyword, dir = defaultPath) ->
  _getModules = _.curry(getModules) dir
  _filterByKeyword = _.curry(filterByKeyword) keyword
  fs.list dir
  .then _getModules
  .then _filterByKeyword
  .then pluckNames
