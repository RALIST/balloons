const webpack = require('webpack')
module.exports = {
  module: {
    rules: [
      {
        test: /\.s[ac]ss$/i,
        use: [
          // Compiles Sass to CSS
          "sass-loader",
        ],
      },
      {
        test: /\.erb$/,
        enforce: 'pre',
        exclude: /node_modules/,
        use: [{
          loader:  "rails-erb-loader",
          options:  {
            runner:  (/^win/.test(process.platform) ? "ruby " : "") + "bin/rails runner",
            engine: 'erb',
            env:        {
              ...process.env,
              DISABLE_SPRING: 1,
            },
          },
        }],
      }
    ],
  },
  plugins: [
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      "window.jQuery": "jquery",
      "window.$": "jquery",
    }),
  ],
  watchOptions: {
    poll: true,
    ignored: 'node_modules/**'
  }
};

