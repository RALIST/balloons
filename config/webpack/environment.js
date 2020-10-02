const { environment } = require('@rails/webpacker');
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;

const webpack = require('webpack');

environment.plugins.append('Provide', new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    "window.jQuery": "jquery",
    "window.$": "jquery",
    Popper: ['popper.js', 'default'],
    Rails: ['@rails/ujs']
}));
environment.plugins.append('bundleAnalyzer', new BundleAnalyzerPlugin())
const erb = require('./loaders/erb');
environment.loaders.prepend('erb', erb)
environment.splitChunks()
module.exports = environment;
