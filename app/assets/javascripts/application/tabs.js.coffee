class window.app.Tab
  constructor: (el) ->
    @._init_elems(el)
    @._enable_events()
    @._init_state()
    @

  _init_elems: (el) ->
    @.$el = $(el)
    if @.$el.length
      @.$tab = @.$el
      content_id = @.$tab.attr('href')
      @.$content = $(document).find("#{content_id}")

  _enable_events: ->
    if @.$tab.length
      @.$tab.on('click', (e) =>
        e.preventDefault()
        $(document).trigger('tabs.click', [@])
      )

      $(document).on('tabs.active', (e, id) =>
        e.preventDefault()
        if id == "##{@.$content.attr('id')}"
          @.show()
        else
          @.hide()
      )

  _init_state: ->
    if @.$tab.length && @.$tab.hasClass('m-active')
      @.show()
    else
      @.hide()


  show: ->
    @.$tab.addClass('m-active')
    @.$content.show()

  hide: ->
    @.$tab.removeClass('m-active')
    @.$content.hide()


class window.app.Tabs
  constructor: (ids) ->
    @._init_elems(ids)

    $(document).on('tabs.click', (e, tab) =>
      e.preventDefault()
      @._switch_tabs(tab)
    )

    @._init_by_url()

  _init_elems: (ids) ->
    @.tabs = []
    @.ids = ids
    if ids.length
      for id in ids
        el = $("a[href='#{id}']")
        @.tabs.push(new window.app.Tab(el))

  # управляет переключением табов
  _switch_tabs: (active_tab) ->
    active_tab.show()
    tabs_to_hide = _.without(@.tabs, active_tab)
    _.each tabs_to_hide, (tab) ->
      tab.hide()


  # открывает нужный таб при открытии страницы
  # если в адреской строке есть знакомый хэш
  # то активируем таб с этим хэшем
  # иначе первый из объявленных
  _init_by_url: ->
    current_id = window.location.hash
    console.log sent_id = @.ids[0]
    if @.ids.indexOf(current_id) > -1
      sent_id = current_id
    $(document).trigger('tabs.active', [sent_id])
