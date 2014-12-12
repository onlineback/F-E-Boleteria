yOSON.AppSchema.modules=
	'default':
		controllers:
			'index':
				actions :
					'index' : ->
						yOSON.AppCore.runModule 'index'
					'byDefault': ->
				allActions: ->
			'contacto':
					actions :
						'index' : ->
							yOSON.AppCore.runModule 'validation',{'form':'#formcontacto'}
						'byDefault': ->
					allActions: ->
			'noticias':
				actions :
					'index' : ->
						yOSON.AppCore.runModule 'noticia'
					'byDefault': ->
					'detalle' : ->
						yOSON.AppCore.runModule 'noticia'
						'byDefault': ->
				allActions: ->
			'eventos':
					actions :
						'index' : ->
							yOSON.AppCore.runModule 'mapa'
							yOSON.AppCore.runModule 'evento'
						'byDefault': ->
						'resultados' : ->
							yOSON.AppCore.runModule 'resultados'
						'byDefault': ->
					allActions: ->
			byDefault : ->
			allActions: ->
		byDefault : ->
		allControllers : ->
	byDefault : ->
	allModules : ->