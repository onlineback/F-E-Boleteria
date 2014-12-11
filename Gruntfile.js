 var pathCoffee = 'source/coffee/',
    pathJade= 'source/jade/',
    destJs= '../resource/js/library',
    jades2Html={
        '../source/application/layouts/scripts/layout.phtml': pathJade + 'layout/layout.jade',
        '../source/application/layouts/scripts/layout-interno.phtml': pathJade + 'layout/layout-interno.jade',
        '../source/application/layouts/scripts/include/head.phtml': pathJade + 'layout/include/head.jade',
        '../source/application/modules/default/views/scripts/index/index.phtml': pathJade + 'index.jade',
        '../source/application/modules/default/views/scripts/noticias/index.phtml': pathJade + 'noticia.jade',
        '../source/application/modules/default/views/scripts/noticias/detalle.phtml': pathJade + 'detalle-noticia.jade',
        '../source/application/modules/default/views/scripts/eventos/index.phtml': pathJade + 'eventos.jade',
        '../source/application/modules/default/views/scripts/eventos/resultados.phtml': pathJade + 'resultados.jade',
        '../source/application/modules/default/views/scripts/contacto/index.phtml': pathJade + 'contacto.jade',
        '../source/application/modules/default/views/scripts/venue/index.phtml': pathJade + 'local.jade',
        '../source/application/modules/default/views/scripts/seller/index.phtml': pathJade + 'seller.jade',
        //'../resource/index.html': pathJade + 'index.jade',
        //'../resource/noticias.html': pathJade + 'noticia.jade',
        //'../resource/detalle-noticias.html': pathJade + 'detalle-noticia.jade',
        //'../resource/resultados.html': pathJade + 'resultados.jade',
        //'../resource/contacto.html': pathJade + 'contacto.jade',
        //'../resource/eventos.html': pathJade + 'eventos.jade'
    },
    arrYOSON=[
        pathCoffee + 'yoson/yoson.coffee',
        pathCoffee + 'modules/index.coffee',
        pathCoffee + 'reusables/index.coffee',
        pathCoffee + 'schemas/modules.coffee',
        pathCoffee + 'yoson/appLoad.coffee'
    ];

module.exports = function(grunt){
    grunt.initConfig({
        jade:{
            compile: {
                options:{
                    pretty: true,
                    data: grunt.file.readJSON("source/jade/config/data.json")
                },
                files:jades2Html
            }
        },
        coffee:{
            options:{
                bare: true
            },
            compile:{
                files:{
                    '../source/public/static/js/library/library.js': arrYOSON
                }
            }
        },
        uglify:{
            options: {
                compress: {
                    drop_console: true
                }
            },
            my_target:{
                files:[{
                    expand: true,
                    cwd: destJs,
                    src: '*.js',
                    dest: destJs
                }]
            }
        },
        exec:{
            styflux: {
                cmd: 'cd source/styflux/ && node init.njs'
            }
        },
        sprite:{
            all:{
                src: '../source/public/static/img/sprites/*.png',
                destImg: '../source/public/static/img/icon-set.png',
                cssFormat: 'stylus',
                destCSS: 'source/styflux/library/styflux/utils/sprites.styl'
            }
        },
        webfont:{
            icons:{
                src: 'source/fonticon/*.svg',
                dest: '../source/public/static/css/fonts/fontCoomuna',
                destCss: 'source/styflux/views/style/vhelpers',
                options:{
                    destHtml: 'source/',
                    hashes: false,
                    engine: 'node',
                    autoHint:false,
                    styles: 'icon',
                    //fontHeight: 1,
                    stylesheet: 'styl',
                    font: 'fontCoomuna',
                    templateOptions:{
                        baseClass: 'glyph-icon',
                        classPrefix: 'glyph-'
                    }
                }
            }
        },
        watch: {
            scripts: {
                files: 'source/coffee/**/*.coffee',
                tasks: [ 'scripts' ]
            },
            jade:{
                files: 'source/jade/**/*.jade',
                tasks: [ 'jades' ]
            },
            styflux:{
                files: 'source/styflux/**/*.styl',
                tasks: [ 'exec' ]
            }
        }
    });

    //loadNpmTasks
    grunt.loadNpmTasks('grunt-exec');
    grunt.loadNpmTasks('grunt-contrib-jade');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-webfont');
    grunt.loadNpmTasks('grunt-spritesmith');

    //execute the tasks
    grunt.registerTask('server', ['watch']);
    grunt.registerTask('scripts', 'Compiles the JavaScript files.', ['coffee']);
    grunt.registerTask('jades', 'Compiles the Jade files.', ['jade']);
};
