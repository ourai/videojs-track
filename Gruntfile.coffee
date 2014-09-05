module.exports = ( grunt ) ->
  pkg = grunt.file.readJSON "package.json"
  info =
    name: pkg.name.charAt(0).toUpperCase() + pkg.name.substring(1)
    version: pkg.version
  npmTasks = [
      "grunt-contrib-concat"
      "grunt-contrib-compass"
      "grunt-contrib-coffee"
      "grunt-contrib-uglify"
      "grunt-contrib-copy"
      "grunt-contrib-clean"
    ]

  grunt.initConfig
    repo: info
    pkg: pkg
    meta:
      src: "src"
      style: "<%= meta.src %>/stylesheets"
      script: "<%= meta.src %>/javascripts"
      dest: "dest"
      dest_style: "<%= meta.dest %>/stylesheets"
      dest_script: "<%= meta.dest %>/javascripts"
      dest_image: "<%= meta.dest %>/images"
      tests: "test"
    concat:
      coffee_progress:
        src: [
            "<%= meta.script %>/intro.coffee"
            "<%= meta.script %>/progress.coffee"
            "<%= meta.script %>/outro.coffee"
          ]
        dest: "<%= meta.dest %>/<%= pkg.name %>.coffee"
      sass:
        src: [
            "<%= meta.style %>/progress.scss"
          ]
        dest: "<%= meta.dest %>/<%= pkg.name %>.scss"
    compass:
      compile:
        options:
          outputStyle: "compressed"
          sassDir: "<%= meta.dest %>"
          cssDir: "<%= meta.dest %>"
          imagesDir: "<%= meta.dest_image %>"
    coffee:
      compile:
        options:
          bare: false
          separator: "\x20"
        expand: true
        cwd: "<%= meta.dest %>"
        src: ["*.coffee"]
        dest: "<%= meta.dest %>"
        ext: ".js"
    uglify:
      options:
        banner: "/*!\n" +
                " * <%= repo.name %> v<%= repo.version %>\n" +
                " * <%= pkg.homepage %>\n" +
                " *\n" +
                " * Copyright 2014, <%= grunt.template.today('yyyy') %> Ourairyu, http://ourai.ws/\n" +
                " *\n" +
                " * Date: <%= grunt.template.today('yyyy-mm-dd') %>\n" +
                " */\n"
        sourceMap: true
      build:
        src: "<%= meta.dest %>/<%= pkg.name %>.js"
        dest: "<%= meta.dest %>/<%= pkg.name %>.min.js"
    copy:
      test:
        expand: true
        cwd: "<%= meta.dest %>"
        src: ["*.js", "*.css"]
        dest: "<%= meta.tests %>"
    clean:
      compiled: [
          "<%= meta.dest %>/**/*.scss"
        ]

  grunt.loadNpmTasks task for task in npmTasks

  grunt.registerTask "script", ["concat:coffee_progress", "coffee", "uglify"]
  grunt.registerTask "css", ["concat:sass", "compass"]
  grunt.registerTask "default", ["script", "css", "copy", "clean"]
