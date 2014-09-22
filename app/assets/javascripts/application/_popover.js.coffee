class window.app.Popover
  params :
    backdrop : '.js-popovers-backdrop'
    exit_btn : '.js-popover-exit'
    text_field: '.js-popover-text'

  constructor : (el, timer=false) ->
    @.$el = $(el)
    @.$backdrop = $(@.params.backdrop)
    @.$text_field = $(@.params.text_field)
    @.timer = timer

    if @.is_exist()
      @._init_position()
      @._init_events()

    @

  show_callback: ->
    setTimeout(->
      window.location = '/'
    , 5000)


  show: (text) ->
    if @.is_exist()
      @.$text_field.text(text)
      @.$backdrop.fadeIn(200)
      @.$el.fadeIn(300)
      @.show_callback()

    @


  hide: ->
    if @.is_exist()
      @.$backdrop.fadeOut(100)
      @.$el.fadeOut(100)

    @


  is_exist : ->
    @.$el.length && @.$backdrop.length && @.$text_field

  _init_position: ->
    height = @.$el.outerHeight()
    @.$el.css('margin-top': -height/2)

    @


  _init_events: ->
    @.$el.find(@.params.exit_btn).on('click', (e) =>
      e.preventDefault()
      window.location = '/'
    )