const { environment } = require('@rails/webpacker')

module.exports = environment

// bootstrap設定(jqueryの読み込み設定)
const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)