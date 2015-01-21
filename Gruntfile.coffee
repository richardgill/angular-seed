module.exports = (grunt) ->
  mountFolder = (connect, dir) -> connect.static(require('path').resolve(dir))

  devUrl = () => 
    if process.env.HOST then "http://#{process.env.HOST.substring(6,process.env.HOST.length - 5)}:#{process.env.SERVICES_SEARCH_SERVER_PORT_3000_TCP_PORT}/api/v1/" else "http://setHostEnvironmentVariable.com"

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    concurrent:
      appwatch: ['connect:app:keepalive', 'watch']
      testwatch: ['connect:test:keepalive', 'watch']
      e2etests: ['connect:test:keepalive', 'protractor:e2e']

      options: logConcurrentOutput: true


    clean:
      files: ["tmp/", "dist/"]

    haml:
      app:
        files: [
          expand: true
          cwd: './_app/'
          src: ['**/*.haml']
          dest: 'dist/app/'
          ext: '.html'
          flatten: false
        ]

    less:
      dist:
        files: [
          expand: true,
          cwd: "_app/css",
          src: ["styles.less"],
          dest: "dist/app/css",
          ext: ".css"
        ]

      
    bowerComponents:
      dist:
        files:
          'bower_components/**/*' : 'dist/app/bower_components'

    coffee:
      scripts:
        files: [
          expand: true,
          cwd: './_app/js',
          src: ['**/*.coffee'],
          dest: 'dist/app/js',
          ext: '.js'
        ,
          expand: true,
          cwd: './_test/e2e',
          src: ['**/*.coffee'],
          dest: 'dist/test/e2e',
          ext: '.js'
        ,
          expand: true,
          cwd: './_test/unit',
          src: ['**/*.coffee'],
          dest: 'dist/test/unit',
          ext: '.js'
        ]

    watch:
      options:
        spawn: false
        livereload: false

      coffee:
        files: ['_app/js/**/*.coffee', '_test/**/*']
        tasks: ['coffee']

      css:
        files: ['_app/css/*']
        tasks: ['less']

      haml:
        files: ['_app/*.haml', '_app/partials/**/*.haml']
        tasks: ['haml', 'wiredep']

      static:
        files: ['_app/public/*']
        tasks: ['copy:public']

      js:
        files: ['_app/**/*.js']
        tasks: ['copy:js']
        
      html:
        files: ['_app/**/*.html']
        tasks: ['copy:htmlPartials']  

    connect:
      app:
        options:
          port: process.env.PORT || 9000
          middleware: (connect, options) ->
            [
              # Either grap our ip from environment variable or from ip library.
              # require('connect-livereload')(src: "http://#{process.env.HOST.substring(6,process.env.HOST.length - 5)}:35729/livereload.js?snipver=1"),
              mountFolder(connect, '.tmp'),
              mountFolder(connect, 'dist/app')
            ]

      test:
        options:
          port: 9000
          middleware: (connect, options) ->
            process.env.ENVIRONMENT = "TEST"
            [
              # Either grap our ip from environment variable or from ip library.
              # require('connect-livereload')(src: "http://#{process.env.HOST.substring(6,process.env.HOST.length - 5)}:35729/livereload.js?snipver=1"),
              mountFolder(connect, '.tmp'),
              mountFolder(connect, 'dist/app')
            ]

    wiredep:
      target:
        src: [
          "dist/app/index.html"
        ]

    copy:
      bowerComponents:
        files: [
          expand: true, src: ['bower_components/**/*'], dest: 'dist/app/'
        ]
      public:
        files: [
          expand: 'true', cwd: '_app/public/', src: ['**/*'], dest: 'dist/app/'
        ]
      htmlPartials:
        files: [
          expand: 'true', cwd: '_app/', src: ['**/*.html'], dest: 'dist/app/'
        ]
      js:
        files: [
          expand: 'true', cwd: '_app/', src: ['**/*.js'], dest: 'dist/app/'
        ]


    karma:
      unit:
        configFile: 'config/karma.conf.coffee'

    protractor:
      e2e:
        configFile: "config/protractor-e2e.conf.js",
        keepAlive: false
        noColor: true


    ngconstant:
      options:
        name: 'config'
        dest: 'dist/app/js/config.js'
        constants:
          version: '0.9.0'

      development:
        constants:
          environment: 'development'
          endpoint: devUrl()

      test:
        constants:
          environment: 'test'
          endpoint: 'http://backend-service/service'

      uat:
        constants:
          environment: 'uat'
          endpoint: 'http://backend-service/api/v1/'
          
      production:
        constants:
          environment: 'production'
          endpoint: 'http://backend-service/api/vi'

    replace:
      dist:
        options:
          patterns: [
            match: 'googleAnalyticsId'
            replacement: if process.env.NODE_ENV == 'production' then 'UA-56163657-1' else 'UA-56160662-1'
          ]
        files: [
          expand: true, flatten: true, src: ['_app/js/analyticsIdConstant.js'], dest: 'dist/app/js/'
        ]


  grunt.loadTasks "tasks"

  grunt.loadNpmTasks('grunt-haml')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-less')

  grunt.loadNpmTasks('grunt-concurrent')
  grunt.loadNpmTasks('grunt-karma')
  grunt.loadNpmTasks('grunt-protractor-runner')
  grunt.loadNpmTasks('grunt-ng-constant')
  grunt.loadNpmTasks('grunt-replace');
  grunt.loadNpmTasks('grunt-wiredep')

  grunt.registerTask "default", ["build"]
  grunt.registerTask "build", ["clean", "haml", "coffee", "less", "wiredep", "copy:bowerComponents", "copy:htmlPartials", "copy:js", "copy:public", "ngconstant:#{process.env.NODE_ENV}", "replace"]
  grunt.registerTask "serve", ["build", "concurrent:appwatch"]
  grunt.registerTask "test-serve", ["build", "ngconstant:test", "concurrent:testwatch"]
  grunt.registerTask "e2e-tests", ["build", "ngconstant:test", "concurrent:e2etests"]
  grunt.registerTask "unit-tests-watch", ["karma"]
