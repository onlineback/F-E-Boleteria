yOSON.AppSchema.modules=
	'default':
		controllers:
			'index':
				actions :
					'index' : ->
						#yOSON.AppCore.runModule 'showAds', {"callbackShow": "#homeAds"}
						yOSON.AppCore.runModule 'datatableCfg'
					'reports' : ->
						#yOSON.AppCore.runModule 'showAds', {"callbackShow": "#homeAds"}
						yOSON.AppCore.runModule 'datatableRep'
					'login' : ->
						#yOSON.AppCore.runModule 'showAds', {"callbackShow": "#homeAds"}
						yOSON.AppCore.runModule 'datatableCfg'
					'eventos' : ->
						yOSON.AppCore.runModule 'detalleEvento'
					'mapa' : ->
						yOSON.AppCore.runModule 'mapa'
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