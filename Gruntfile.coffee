module.exports = ->

  @initConfig

    pkg: @file.readJSON 'package.json'

    stylus:
     dev:
        options:
          compress: false
        files:
          'src/css/main.css': 'src/stylus/main.styl'

    coffee:
     dev:
        options:
          join: true
        files:
          'src/js/app.js': 'src/coffee/app/*.coffee'
          'src/js/background.js': 'src/coffee/background.coffee'

    watch:
      stylus:
        files: 'src/stylus/**/*.styl'
        tasks: ['stylus:dev']
      coffeeMain:
        files: 'src/coffee/**/*.coffee'
        tasks: ['coffee:dev']

  # Load the plugins
  @loadNpmTasks 'grunt-contrib-watch'
  @loadNpmTasks 'grunt-contrib-stylus'
  @loadNpmTasks 'grunt-contrib-coffee'

  @registerTask 'default', [
    'stylus:dev'
    'coffee:dev'
    'watch'
  ]
