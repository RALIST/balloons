process.env.NODE_ENV = process.env.NODE_ENV || 'development';

const environment = require('./environment');
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;
environment.plugins.append('bundleAnalyzer', new BundleAnalyzerPlugin())
module.exports = environment.toWebpackConfig();

