class window.app.MainSlider extends window.app.Scroller
  params:
    container: '.js-main-slider-container'
    item: '.js-main-slider-item'
    previews: '.js-main-slider-previews'
    nav_container: "<nav class='nav-growpop'></nav>"
    next_btn: "<a href='#' class='main-slider__btn m-next next'><span class='icon-wrap fa fa-angle-right'></span><div class='js-preview-next'></div></a>"
    prev_btn: "<a href='#' class='main-slider__btn m-prev prev'><span class='icon-wrap fa fa-angle-left'></span><div class='js-preview-prev'></div></a>"
    shadow_left: ""
    shadow_right: ""
    clock: 5000

  _custom_constructor: ->
    @.$previews = $("#{@.params.previews} > div")
    if @.$previews.length && @.$next_btn.length && @.$prev_btn.length
      @.add_previews_for_current_slide(0)
      setInterval( =>
        @.scroll_next()
      , @.params.clock)



  _init_sizes: ->
    @.item_width = @.$items.eq(0).outerWidth()
    @.el_width = @.$el.width()
    @.max_width = 0
    @.max_width = @.item_width * @.$items.length
    @.$container.width(@.max_width)
#    @.$el.height(@.$items.eq(0).height())


  _render_buttons: ->
    @.$nav_container = $(@.params.nav_container).appendTo(@.$el)
    if @.$nav_container.length
      @.$next_btn = $(@.params.next_btn).appendTo(@.$nav_container)
      @.$prev_btn = $(@.params.prev_btn).appendTo(@.$nav_container)

  after_moved: ->
    current_id = Math.abs(@.$container.position().left / @.item_width)
    @.add_previews_for_current_slide(current_id)


  add_previews_for_current_slide: (current_id) ->
    max_count = Math.abs(@.max_width / @.item_width)

    next_id = current_id + 1
    next_id = 0 if next_id > max_count - 1

    prev_id = current_id - 1
    prev_id = max_count if current_id < 0

    $preview_prev = @.$previews.eq(prev_id)
    $preview_next = @.$previews.eq(next_id)

    @.$next_btn.find('.js-preview-next').html($preview_next)
    @.$prev_btn.find('.js-preview-prev').html($preview_prev)




