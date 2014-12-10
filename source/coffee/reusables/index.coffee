#-----------------------------------------------------------------------------------------------
 # @Module: Validate Form
 # @autor: BrayanBp
 # @Description: Validacion de formularios
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "validation", ((Sb) ->
	init: (oParams) ->
		forms= oParams.form.split(",")
		extraOpt= oParams.config
		$.each forms,(index,value)->
			settings= {}
			value= $.trim value
			for prop of yOSON.require[value]	
				settings[prop]= yOSON.require[value][prop]
			if typeof extraOpt isnt "undefined"
				settings= $.extend settings,extraOpt
			$(value).validate settings
), ["data/require.js","plugins/jqValidate.js"]
#-----------------------------------------------------------------------------------------------
 # @Module: modResponsive
 # @autor: BrayanBp
 # @Description: Modulo para responsive
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "modResponsive", ((Sb) ->
	win= $(window)
	htm= $("html")[0]
	body= $("body")
	currentWidth= 0
	tmpWidth= 0
	resetClass= ()->
		body.removeClass "columns-4 columns-5 columns-6 columns-7 columns-8 columns-9"
	dispatchResponsive= (wdth)->
		if wdth > 1024
			number= Math.floor(wdth/250)
			classNumber= if number > 9 then "columns-9" else "columns-"+number
			if !body.hasClass(classNumber)
				resetClass()
				body.addClass classNumber
		else
			resetClass()
			body.addClass "columns-4"
	init: (oParams) ->
		win.on "resize",(e)->
			tmpWidth= htm.clientWidth
			if tmpWidth isnt currentWidth
				currentWidth= tmpWidth
				dispatchResponsive currentWidth
		win.trigger "resize"
)
#-----------------------------------------------------------------------------------------------
 # @Module: menuHead
 # @autor: BrayanBp
 # @Description: Modulo para mostrar/ocultar menus en el head
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "menuHead", ((Sb) ->
	st=
		"lnkMenu": ".lnkDropDown"
		"ctnMenu": ".head-menu"
	dom= {}
	zindex= 90
	catchDom= ()->
		dom.lnkMenu= $ st.lnkMenu
	bindEvents= ()->
		if dom.lnkMenu.length > 0
			dom.lnkMenu.on "click",(e)->
				e.preventDefault()
				$this= $(this)
				target= $this.parent().find(".head-menu")
				if target.is(":visible")
					animateHide target
				else
					zindex++
					animateShow target
				return
	animateShow= (el)->
		el.css "z-index", zindex
		el.show()
		el.animate
			"top": "110%",
			"opacity": 1
		,300,"easeInExpo"
	animateHide= (el)->
		el.animate
			"top": "81%",
			"opacity": 0
		,300,"easeOutExpo",()->
			el.hide()
	init: (oParams) ->
		catchDom()
		bindEvents()
)
#-----------------------------------------------------------------------------------------------
 # @Module: modalInfo
 # @autor: BrayanBp
 # @Description: Modulo para mostrar modal info
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "modalInfo", ((Sb) ->
	opts=
		tpl: "#tplAlert"
		body: "body"
		btnClose: false
		classBtnClose: ".lnk-closeAlertModal"
	dom= {}
	catchDom= ()->
		dom.tplAlert= _.template $(opts.tpl).html()
		dom.body= $ opts.body
	bindEvents= ()->
		ctn= $ dom.tplAlert(opts).replace(/[\n\r]/g, "")
		templateModal= setTemplate()
		wrapModal= templateModal.find('.wrap-alertModal')
		wrapModal.css "visibility": "hidden"
		wrapModal.append ctn
		dom.body.append templateModal
		stylModal= getStylModal(ctn)
		wrapModal.css stylModal
		evtCloseModal(templateModal)
		return
	setTemplate= ()->
		tpl= $ "<div class='overlay-alertModal'><div class='wrap-alertModal'></div></div>"
		return tpl
	getStylModal= (target)->
		wdth= target.width()
		hght= target.height()
		"margin-left": -wdth/2
		"margin-top": -hght/2
		"visibility": "visible"
	evtCloseModal= (el)->
		el.on "click",(e)->
			target= $ e.target
			if target.hasClass("overlay-alertModal")
				removeModal el
		if opts.btnClose
			$(opts.classBtnClose,el).on "click",()->
				removeModal el
	removeModal= (el)->
		el.fadeOut 400,()->
			el.remove()
	init: (oParams) ->
		yOSON.AppCore.chargeDepends ["plugins/jqUnderscore.js","data/alerts.js"],()->
			opts= $.extend opts,yOSON.alertModal[oParams.modal]
			catchDom()
			bindEvents()
)
#-----------------------------------------------------------------------------------------------
 # @Module: modalConfirm
 # @autor: BrayanBp
 # @Description: Modulo para confirmar modal
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "modalConfirm", ((Sb) ->
	opts=
		tplConfirm: "#tplConfirm"
		body: "body"
		#btnClose: false
		classBtnClose: ".lnk-closeAlertModal"
	dom= {}
	catchDom= ()->
		dom.tplConfirm= _.template $(opts.tplConfirm).html()
		dom.body= $ opts.body
	bindEvents= ()->
		ctn= $ dom.tplAlert(opts).replace(/[\n\r]/g, "")
		templateModal= setTemplate()
		wrapModal= templateModal.find('.wrap-alertModal')
		wrapModal.css "visibility": "hidden"
		wrapModal.append ctn
		dom.body.append templateModal
		stylModal= getStylModal(ctn)
		wrapModal.css stylModal
		evtCloseModal(templateModal)
		return
	setTemplate= ()->
		tpl= $ "<div class='overlay-alertModal'><div class='wrap-alertModal'></div></div>"
		return tpl
	getStylModal= (target)->
		wdth= target.width()
		hght= target.height()
		"margin-left": -wdth/2
		"margin-top": -hght/2
		"visibility": "visible"
	evtCloseModal= (el)->
		el.on "click",(e)->
			target= $ e.target
			if target.hasClass("overlay-alertModal")
				removeModal el
		if opts.btnClose
			$(opts.classBtnClose,el).on "click",()->
				removeModal el
	removeModal= (el)->
		el.fadeOut 400,()->
			el.remove()
	init: (oParams) ->
		yOSON.AppCore.chargeDepends ["plugins/jqUnderscore.js","data/alerts.js"],()->
			opts= $.extend opts,yOSON.alertModal[oParams.modal]
			catchDom()
			bindEvents()
)
#-----------------------------------------------------------------------------------------------
 # @Module: changeRadios
 # @Description: Modulo para mostrar radiobtns personalizables
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "changeRadios", ((Sb) ->
	st=
		"inactivo": ".decorOpt-label"
	dom= {}
	catchDom= ()->
		dom.inactivo= $ st.inactivo
	bindEvents= ()->
		cont = 0
		dom.inactivo.on "click",(e)->
			$this = $(this)
			if !$this.hasClass "fix2quad"
				activo = $this.parents('.form-group').find ".active"
				if activo
					activo.removeClass "active"
					$(this).addClass "active"
	init: (oParams) ->
		catchDom()
		bindEvents()
)
#-----------------------------------------------------------------------------------------------
# @Module: changeCheckbox
# @Description: Modulo para mostrar radiobtns personalizables
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "changeCheckbox", ((Sb) ->
	st=
		"inactivo": ".fix2quad"
	dom= {}
	catchDom= ()->
		dom.inactivo= $ st.inactivo
	bindEvents= ()->
		dom.inactivo.on "click",(e)->
			$this = $(this)
			if e.target.localName == "label"
				if  $this.hasClass "active"
					$(this).removeClass "active"
				else
					$(this).addClass "active"
		dom.inactivo.on "change", ()->
			$this = $(this)
			if $this.hasClass "error"
				#console.log "error"
			else
				#console.log "no error"
	init: (oParams) ->
		catchDom()
		bindEvents()
)
#-----------------------------------------------------------------------------------------------
# @Module: hideShowComponent
# @Description: Modulo mostrar u ocultar un compente segun la opcion seleccionada
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "hideShowComponent", ((Sb) ->
	st=
		"ctnHideShow":".ctnHideShow"
		"lnkHideShow": ".lnkHideShow"
	dom= {}
	catchDom= ()->
		dom.lnkHideShow= $ st.lnkHideShow
	bindEvents= ()->
		dom.lnkHideShow.on "click", (e)->
			$this = $(this)
			visible= $this.data "visible"
			tag= e.target.tagName.toLowerCase()
			if tag isnt "input"
				parent= $this.parents(st.ctnHideShow)
				target= $ parent.data("target")
				if visible and !target.is(":visible")
					target.slideDown "fast"
				if !visible and target.is(":visible")
					target.slideUp "fast"
		$(st.lnkHideShow+".active").trigger "click"
	init: (oParams) ->
		catchDom()
		bindEvents()
)
#-----------------------------------------------------------------------------------------------
# @Module: chckHideShow
# @Description: Modulo para mostrar segun el check
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "chckHideShow", ((Sb) ->
	st=
		"chck":".chckHShow"
	dom= {}
	catchDom= ()->
		dom.chck= $ st.chck
	evtChck= ()->
		$this = $(this)
		target= $ $this.data("target")
		if $this.is(":checked")
			target.slideDown "fast"
		else
			target.slideUp "fast"
	bindEvents= ()->
		dom.chck.on "click", (e)->
			evtChck.call this
		dom.chck.each ()->
			evtChck.call this
	init: (oParams) ->
		catchDom()
		bindEvents()
)
#-----------------------------------------------------------------------------------------------
# @Module: multiHSComponent
# @Description: Modulo mostrar u ocultar componentes asociados
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "multiHSComponent", ((Sb) ->
	st=
		"ctnMultiHS":".ctnMultiHS"
		"lnkMultiHS": ".lnkMultiHS"
	dom= {}
	catchDom= ()->
		dom.ctnMultiHS= $ st.ctnMultiHS
	bindEvents= ()->
		dom.ctnMultiHS.each ()->
			parent= $(this)
			targets= $ "."+parent.data("class")
			lnks= parent.find st.lnkMultiHS
			lnks.on "click",(e)->
				$this= $(this)
				tag= e.target.tagName.toLowerCase()
				target= $ $this.data("target")
				if tag isnt "input"
					targets.not(target).hide()
					target.show()
		$(st.lnkMultiHS+".active").trigger "click"
		###lnk.on "click", (e)->
			$this = $(this)
			visible= $this.data "visible"
			tag= e.target.tagName.toLowerCase()
			if tag isnt "input"
				parent= $this.parents(st.ctnHideShow)
				target= $ parent.data("target")
				if visible and !target.is(":visible")
					target.slideDown "fast"
				if !visible and target.is(":visible")
					target.slideUp "fast"
		$(st.lnkHideShow+".active").trigger "click"###
	init: (oParams) ->
		catchDom()
		bindEvents()
)
#-----------------------------------------------------------------------------------------------
# @Module: multiSelect
# @Description: Modulo mostrar u ocultar componentes asociados
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "multiSelect", ((Sb) ->
	st=
		"obj":".multiselect"
	dom= {}
	catchDom= ()->
		dom.obj= $ st.obj
	bindEvents= ()->
		dom.obj.chosen({no_results_text: "Oops, no se han encontrado resultados."})
	init: (oParams) ->
		catchDom()
		bindEvents()
), ["plugins/jqChosen.js"]
#-----------------------------------------------------------------------------------------------
# @Module: countCharacters
# @Description: Modulo para contar los caracteres
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "countCharacters", ((Sb) ->
	st=
		"obj":".countCharacters"
	dom= {}
	valor = 0
	catchDom= ()->
		dom.obj= $ st.obj
	countCharacters= (obj)->
		numChar = obj.data "count"
		dom.obj.on "input", ()->
			$this = $(this)
			left = numChar - $this.val().length
			if left >= 0
				$this.parent().find(".charLeft").html "Le quedan "+ left + " caracteres."
			else
				valor = $this.val().substring 0, 140
				$this.val valor
	bindEvents= ()->
		countCharacters(dom.obj)
	init: (oParams) ->
		catchDom()
		bindEvents()
), ["plugins/jqChosen.js"]
#-----------------------------------------------------------------------------------------------
# @Module: datePicker
# @Description: Modulo para embeber datepicker
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "datePicker", ((Sb) ->
	st=
		"obj":".datePicker"
	dom= {}
	valor = 0
	catchDom= ()->
		dom.obj= $ st.obj
	bindDatePicker= (obj)->
		dom.obj.datepicker
			format: "dd-mm-yyyy",
			changeMonth: true,
			changeYear: true,
			maxDate: "0"
			yearRange: "1912:2014"
	bindEvents= ()->
		bindDatePicker(dom.obj)
	init: (oParams) ->
		catchDom()
		bindEvents()
),["plugins/jqUI.js"]
#-----------------------------------------------------------------------------------------------
# @Module: tipsy
# @Description: Modulo mostrar u ocultar componentes asociados
#-----------------------------------------------------------------------------------------------
yOSON.AppCore.addModule "tipsy", ((Sb) ->
	st=
		"tip":".tipsyItem"
	dom= {}
	catchDom= ()->
		dom.tip= $ st.tip
	bindEvents= ()->
		dom.tip.tipsy
			gravity: 's'
			html: true
			classTipsy: 'cmsTipsy'
			opacity: 1
	init: (oParams) ->
		catchDom()
		bindEvents()
)