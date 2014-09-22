class window.app.AddToCartPopover extends window.app.Popover

  # переопределяем метод, чтобы не срабатывал колбэк через 5сек
  show_callback: ->

  _init_events: ->
    @.$el.find(@.params.exit_btn).on('click', (e) =>
      e.preventDefault()
      @.hide()
    )