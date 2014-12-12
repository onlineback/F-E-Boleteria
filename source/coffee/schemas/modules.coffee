yOSON.AppSchema.modules=
	'default':
		controllers:
			'index':
				actions :
					'index' : ->
						yOSON.AppCore.runModule 'index'
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
					allActions: ->
			byDefault : ->
			allActions: ->
		byDefault : ->
		allControllers : ->
	byDefault : ->
	allModules : ->