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
# @Module: eventos
# @autor: joseluis
# @Description: jose
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "detalleEvento", ((Sb) ->
	st=
		"tab": "#tabs"
	dom= {}
	mainTable= {}
	catchDom= ()->
		dom.tab= $(st.tab)
	declareTable= ()->
		$("#tabs").tabulous()

	bindEvents= ()->
		declareTable()
	init: (oParams) ->
		catchDom()
		bindEvents()

),["plugins/tabulous.js"]
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
# @Module: slider
# @autor: joseluis
# @Description: jose
#-----------------------------------------------------------------------------------------------

yOSON.AppCore.addModule "sliderimagen", ((Sb) ->
	st=
		"slider": "#bxslider"
	dom= {}
	mainTable= {}
	catchDom= ()->
		dom.mapa= $(st.mapa)
	declareTable= ()->
		$(".bxslider").bxSlider
			pagerCustom: "#bx-pager"
			controls: false
	declareTable2= ()->
		$(".video-principal").bxSlider
			pagerCustom: "#videomini"
			controls: false
			video: true
			useCSS: false
	bindEvents= ()->
		declareTable()
		declareTable2()
	init: (oParams) ->
		catchDom()
		bindEvents()

),["plugins/jquery.bxslider.min.js","plugins/jquery.fitvids.js"]