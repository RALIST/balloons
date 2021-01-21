const { webpackConfig, merge } = require('@rails/webpacker');
const custom = require('./custom')
module.exports = merge(webpackConfig, custom)
