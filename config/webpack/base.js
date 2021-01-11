const { webpackConfig } = require('@rails/webpacker');
const { merge } = require('webpack-merge');
custom = require('./custom.js')
module.exports = merge(webpackConfig, custom)
