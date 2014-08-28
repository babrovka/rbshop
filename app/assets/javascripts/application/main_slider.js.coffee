class window.app.MainSlider extends window.app.Scroller
  params:
    container: '.js-main-slider-container'
    item: '.js-main-slider-item'
    nav_container: "<nav class='nav-growpop'></nav>"
    next_btn: "<a href='#' class='main-slider__btn m-next next'><span class='icon-wrap'></span></a>"
    prev_btn: "<a href='#' class='main-slider__btn m-prev prev'><span class='icon-wrap'></span></a>"
    shadow_left: ""
    shadow_right: ""


  _init_sizes: ->
    console.log @.item_width = @.$items.eq(0).outerWidth()
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

#  _render_elems: ->
#    @.$next_btn = $(@.params.next_btn).appendTo(@.$el)
#    $(@.params.shadow_right).appendTo(@.$el)
#    @.$prev_btn = $(@.params.prev_btn).appendTo(@.$el)
#    $(@.params.shadow_left).appendTo(@.$el)


#  _init_events: ->
#    if @.$next_btn.length
#      @.$next_btn.on('click', (e) =>
#        e.preventDefault()
#        @.scroll_next()
#      )
#
#    if @.$prev_btn.length
#      @.$prev_btn.on('click', (e) =>
#        e.preventDefault()
#        @.scroll_prev()
#      )
#
#
#  scroll_next: (n=1) ->
#    max_offset = -@.max_width + @.el_width
#    new_offset = @.$container.position().left - n*@.item_width
#    new_offset
#    new_offset = max_offset if new_offset <= max_offset
#    @.set_new_offset(new_offset)
#
#
#  scroll_prev: (n=1) ->
#    new_offset = @.$container.position().left + n*@.item_width
#    new_offset = 0 if new_offset >= 0
#    @.set_new_offset(new_offset)


#  set_new_offset: (offset) ->
#    @.$container.stop().animate({left: offset}, 600, 'swing')
#    @.$container.velocity('stop').velocity( { translateX : offset }, { easing: 'easeInOut', duration: 200 } )

