module.exports = {
  plugins: [
    require('postcss-import'),
    require('tailwindcss')('./tailwind.config.js'),
    require('postcss-flexbugs-fixes'),
    require('autoprefixer'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    }),
    require('@fullhuman/postcss-purgecss')({
      content: [
        './app/**/*.haml',
        './app/helpers/**/*.rb',
        './app/javascript/**/*.js',
        './app/javascript/**/*.vue',
        './app/javascript/**/*.jsx',
      ],
      defaultExtractor: (content) => content.match(/[A-Za-z0-9-_:/]+/g) || []
    })
  ]
}
