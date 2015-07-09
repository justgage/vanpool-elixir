exports.config =
  files:
    javascripts:
      # joinTo: 'js/app.js'
      joinTo:
        'js/app.js': /^(web\/static\/js)/
        'js/vendor.js': /^(web\/static\/vendor)/
    stylesheets: joinTo: 'css/app.css'
    templates: joinTo: 'js/app.js'
  conventions: assets: /^(web\/static\/assets)/
  paths:
    watched: [
      'web/static'
      'test/static'
    ]
    public: 'priv/static'
  plugins:
    babel: ignore: [ /^(web\/static\/vendor)/ ]
    react: transformOptions:
      harmony: true
      sourceMap: true
      stripTypes: true

