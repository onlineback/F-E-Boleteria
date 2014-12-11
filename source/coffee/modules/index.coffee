#-----------------------------------------------------------------------------------------------
 # @Module: dataTableCfg
 # @autor: JeanPaulDiaz
 # @Description: Modulo para tabla del home
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "datatableCfg", ((Sb) ->
	st=
		"datatable": "#mainTable"
		"cuzSearch": "#searchMain"
		"trueSearch":"#mainTable_filter input"
		"picker":".datepicker"
		"status":"#status"
		"amount":"#amount"
		"openPops":".menu-bar li a"
		"pops":".custoPop"
	dom= {}
	mainTable= {}
	catchDom= ()->
		dom.datatable= $(st.datatable)
		dom.cuzSearch= $(st.cuzSearch)
		dom.trueSearch= $(st.trueSearch)
		dom.picker= $(st.picker)
		dom.status= $(st.status)
		dom.amount= $(st.amount)
		dom.openPops= $(st.openPops)
		dom.pops= $(st.pops)
	declareTable= ()->
		mainTable = dom.datatable.DataTable
			"lengthChange": false
			#"searching": false
			"pagingType": "simple_numbers"
			"info": false
	mainSearch= ()->
		dom.cuzSearch.keyup ()->
			dom.trueSearch = $("#mainTable_filter input")
			dom.trueSearch.val $(this).val()
			dom.trueSearch.trigger 'keyup'
	calenSearch= ()->
		dom.picker.datepicker()
		dom.picker.on "change", ()->
			$this = $(this)
			mainTable.search( $this.val() ).draw()
	# statusSearch= ()->
	# 	dom.status
	searchFun= ()->
		mainSearch()
		calenSearch()
		openSearch()
	openSearch= ()->
		cus = ""
		dom.openPops.on "click", ()->
			$this = $(this)
			console.log $this
			console.log cus
			custo = $this.parent().find(".custoPop")
			if custo.is(":visible")
				custo.hide()
			else
				dom.pops.hide()
				custo.show()
			cus = $this
	closeOthers= ()->
		$(".shown .glyph-plus.color1").click()
	dropInfo= ()->
		$("#mainTable tbody").on "click", ".btnDD", ->
			$this = $(this)
			tr = $(this).closest("tr")
			row = mainTable.row tr
			if row.child.isShown()
				# This row is already open - close it
				$this.removeClass "color1"
				row.child.hide()
				tr.removeClass "shown"
			else
				# Open this row
				closeOthers()
				data = {}
				data.backlog = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim."
				data.effect = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
				data.solution = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium."
				row.child(format(data),'childRow').show()
				tr.addClass "shown"
				$this.addClass "color1"
	format= (d) ->
		return '<table class="innerTable">' +
			'<tr>' +
			'<td rowspan=3 class="sonSparate"></td>'+
			'<td class="titleSubTable">DETALLE DE BACKLOG</td>' +
			'<td colspan="8" class="sonCtn">' + d.backlog + '</td>' +
			'</tr>' +
			'<tr>' +
			'<td class="titleSubTable">DETALLE DE EFECTO</td>' +
			'<td colspan="8" class="sonCtn">' + d.effect + '</td>' +
			'</tr>' +
			'<tr>' +
			'<td class="titleSubTable">DETALLE DE SOLUCIÓN</td>' +
			'<td colspan="8" class="sonCtn">' + d.solution + '</td>' +
			'</tr>' +
			'</table>'
	checkMsg = ()->
		$(".ctnCtrls input[type=checkbox]").attr "checked", false
		$("#mainTable tbody").on "click", ".checkBtn", ->
			$this = $(this)
			inpt = $this.parent().find("input")
			if !inpt.is(":checked")
				inpt.click()
				$this.removeClass "glyph-mail"
				$this.addClass "glyph-check"
				flagChk = true
			else
				inpt.click()
				$this.removeClass "glyph-check"
				$this.addClass "glyph-mail"
				flagChk = false
	bindEvents= ()->
		declareTable()
		searchFun()
		dropInfo()
		checkMsg()
	init: (oParams) ->
		catchDom()
		bindEvents()
),["plugins/jqDatatable.js","plugins/jqUI.js"]
#-----------------------------------------------------------------------------------------------
# @Module: datatableRep
# @autor: JeanPaulDiaz
# @Description: Modulo para tabla de reports
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "datatableRep", ((Sb) ->
	st=
		"datatable": "#tblReport"
	dom= {}
	mainTable= {}
	catchDom= ()->
		dom.datatable= $(st.datatable)
	declareTable= ()->
		mainTable = dom.datatable.DataTable
			"lengthChange": false
		#"searching": false
			"paging": false
			"info": false
			"aoColumns": [bSortable: false]
	bindEvents= ()->
		declareTable()
	init: (oParams) ->
		catchDom()
		bindEvents()
),["plugins/jqDatatable.js"]
#-----------------------------------------------------------------------------------------------
# @Module: index
# @autor: joseluis
# @Description: jose
#-----------------------------------------------------------------------------------------------

yOSON.AppCore.addModule "index", ((Sb) ->
	st=
		"slider": ".contenido-slider"
		"picker":".fecha1"
		"picker2":".fecha2"
	dom= {}
	mainTable= {}
	catchDom= ()->
		dom.mapa= $(st.mapa)
		dom.picker= $(st.picker)
		dom.picker2= $(st.picker2)
	declareTable= ()->
		$(".contenido-slider").bxSlider
			auto: true
			autoControls: true
	calenSearch= ()->
		dom.picker.datepicker
			altField: "#from"
			altFormat: "yy-mm-dd"
			changeMonth: true
			onClose: (selectedDate) ->
				$(".fecha2").datepicker "option", "minDate", selectedDate
				return
	calenSearch2= ()->
		dom.picker2.datepicker
			altField: "#to"
			altFormat: "yy-mm-dd"
			changeMonth: true
			onClose: (selectedDate) ->
				$(".fecha1").datepicker "option", "maxDate", selectedDate
				return
	bindEvents= ()->
		declareTable()
		calenSearch()
		calenSearch2()
	init: (oParams) ->
		catchDom()
		bindEvents()

),["plugins/jquery.bxslider.min.js","plugins/jqUI.js"]

#-----------------------------------------------------------------------------------------------
# @Module: mapa
# @autor: joseluis
# @Description: jose
#-----------------------------------------------------------------------------------------------

yOSON.AppCore.addModule "mapa", ((Sb) ->
	st=
		"mapa": "#mapa"
	dom= {}
	mainTable= {}
	catchDom= ()->
		dom.mapa= $(st.mapa)
	declareTable= ()->
		map = new GMaps(
			el: "#mapa"
			lat: -12.043333
			lng: -77.028333
			panControl: false
			zoomControl: false
			disableDefaultUI: true
			streetViewControl: false
			overviewMapControl: false
		)
		map.addMarker
			lat: -12.042
			lng: -77.028333
			title: "Marker with InfoWindow"
			infoWindow:
				content: "<p>HTML Content</p>"
	bindEvents= ()->
		declareTable()
	init: (oParams) ->
		catchDom()
		bindEvents()

),["plugins/gmaps.js"]

#-----------------------------------------------------------------------------------------------
# @Module: evento
# @autor: joseluis
# @Description: jose
#-----------------------------------------------------------------------------------------------

yOSON.AppCore.addModule "evento", ((Sb) ->
	st=
		"slider": ".bxslider"
		"tab":"#tabs"
		"video":".video-principal"
	dom= {}
	mainTable= {}
	catchDom= ()->
		dom.slider= $(st.slider)
		dom.tab= $(st.tab)
		dom.video= $(st.video)
	sliderimagen= ()->
		dom.slider.bxSlider
			pagerCustom: "#bx-pager"
			preloadImages: "all"
			controls: false
	slidervideo= ()->
		dom.video.bxSlider
			pagerCustom: "#videomini"
			controls: false
			video: true
			useCSS: false
	facebook= ()->
		((d, s, id) ->
				js = undefined
				fjs = d.getElementsByTagName(s)[0]
				return  if d.getElementById(id)
				js = d.createElement(s)
				js.id = id
				js.src = "//connect.facebook.net/es_LA/sdk.js#xfbml=1&appId=404966819653618&version=v2.0"
				fjs.parentNode.insertBefore js, fjs
				return
		) document, "script", "facebook-jssdk"
	twitter= ()->
		((d, s, id) ->
			js = undefined
			fjs = d.getElementsByTagName(s)[0]
			p = (if /^http:/.test(d.location) then "http" else "https")
			unless d.getElementById(id)
				js = d.createElement(s)
				js.id = id
				js.src = p + "://platform.twitter.com/widgets.js"
				fjs.parentNode.insertBefore js, fjs
			return
			) document, "script", "twitter-wjs"
	eventotab= ()->
		dom.tab.tabs()
	bindEvents= ()->
		sliderimagen()
		slidervideo()
		facebook()
		twitter()
		eventotab()
	init: (oParams) ->
		catchDom()
		bindEvents()

),["plugins/jquery.bxslider.min.js","plugins/jquery.fitvids.js","plugins/jquery-ui.min.js"]
#-----------------------------------------------------------------------------------------------
# @Module: noticia
# @autor: joseluis
# @Description: jose
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "noticia", ((Sb) ->
	st=
		"tab": "#tabs"
	dom= {}
	mainTable= {}
	catchDom= ()->
		dom.tab= $(st.tab)
	facebook= ()->
		((d, s, id) ->
			js = undefined
			fjs = d.getElementsByTagName(s)[0]
			return  if d.getElementById(id)
			js = d.createElement(s)
			js.id = id
			js.src = "//connect.facebook.net/es_LA/sdk.js#xfbml=1&appId=404966819653618&version=v2.0"
			fjs.parentNode.insertBefore js, fjs
			return
		) document, "script", "facebook-jssdk"
	twitter= ()->
		((d, s, id) ->
			js = undefined
			fjs = d.getElementsByTagName(s)[0]
			p = (if /^http:/.test(d.location) then "http" else "https")
			unless d.getElementById(id)
				js = d.createElement(s)
				js.id = id
				js.src = p + "://platform.twitter.com/widgets.js"
				fjs.parentNode.insertBefore js, fjs
			return
		) document, "script", "twitter-wjs"
	google= ()->
		(->
			po = document.createElement("script")
			po.type = "text/javascript"
			po.async = true
			po.src = "https://apis.google.com/js/plusone.js"
			s = document.getElementsByTagName("script")[0]
			s.parentNode.insertBefore po, s
			return
		)()
	bindEvents= ()->
		facebook()
		twitter()
		google()
	init: (oParams) ->
		catchDom()
		bindEvents()

),["plugins/jquery-ui.min.js"]