yOSON.AppSchema.modules=
	'default':
		controllers:
			'index':
				actions :
					'index' : ->
						yOSON.AppCore.runModule 'index'
					'byDefault': ->
				allActions: ->
			'eventos':
					actions :
						'index' : ->
							yOSON.AppCore.runModule 'mapa'
							yOSON.AppCore.runModule 'detalleEvento'
							yOSON.AppCore.runModule 'sliderimagen'
						'byDefault': ->
					allActions: ->
			byDefault : ->
			allActions: ->
		byDefault : ->
		allControllers : ->
	byDefault : ->
	allModules : ->