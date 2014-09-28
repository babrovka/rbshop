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
    anim_clock: 1500

  constructor : (el) ->
    @.$el = $(el)
    @.$container = @.$el.find(@.params.container)
    @.$items = @.$container.find(@.params.item)
    @.$current_item = @.$items.first().addClass('m-current')

    if @.$el.length && @.$container.length && @.$items.length
      @._init_sizes()
      @._render_buttons()
      @._init_events()

    @.$previews = $("#{@.params.previews} > div")
    if @.$previews.length && @.$next_btn.length && @.$prev_btn.length
      @.add_previews_for_current_slide(0)
      setInterval(=>
        @.scroll_next()
      , @.params.clock)

  _init_events : ->
    if @.$next_btn.length
      @.$next_btn.on('click', (e) =>
        e.preventDefault()
        @.scroll_next()
      ).on('mouseenter', (e) -> $(@).closest('a').addClass('m-active')
      ).on('mouseleave', (e) -> $(@).closest('a').removeClass('m-active')
      )

    if @.$prev_btn.length
      @.$prev_btn.on('click', (e) =>
        e.preventDefault()
        @.scroll_prev()
      ).on('mouseenter', (e) -> $(@).closest('a').addClass('m-active')
      ).on('mouseleave', (e) -> $(@).closest('a').removeClass('m-active')
      )

  _turn_off_clicks : ->
    if @.$next_btn.length
      @.$next_btn.off('click')

    if @.$prev_btn.length
      @.$prev_btn.off('click')

  _init_sizes: ->
    @.item_width = @.$items.eq(0).outerWidth()
    @.el_width = @.$el.width()
    @.max_width = 0
    @.max_width = @.item_width * @.$items.length
    @.$container.width(@.max_width)


  _render_buttons: ->
    @.$nav_container = $(@.params.nav_container).appendTo(@.$el)
    if @.$nav_container.length
      @.$next_btn = $(@.params.next_btn).appendTo(@.$nav_container)
      @.$prev_btn = $(@.params.prev_btn).appendTo(@.$nav_container)


  scroll_next : (n = 1) ->
    @._turn_off_clicks()
    @.before_moved_next()
    @.scroll(1)
    @.after_moved_next()


  scroll_prev : (n = 1) ->
    @._turn_off_clicks()
    @.before_moved_prev()
    @.scroll(-1)
    @.after_moved_prev()

  scroll: (pos_diff) ->
    to_pos = @.calculate_pos(pos_diff)
    @.$current_item = @.$items.eq(to_pos).addClass('m-current')


  current_pos: ->
    @.$items.index(@.$current_item)


  calculate_pos: (pos_diff) ->
    to_pos = @.current_pos() + pos_diff
    to_pos = @.$items.length - 1 if to_pos < 0
    to_pos = 0 if to_pos >= @.$items.length
    to_pos

  before_moved_prev: ->
    @.$prev_btn.removeClass('m-active')
    @.$current_item.addClass('navOutPrev')
    @.$items.eq(@.calculate_pos(-1)).addClass('navInPrev')

  before_moved_next: ->
    @.$next_btn.removeClass('m-active')
    @.$current_item.addClass('navOutNext')
    @.$items.eq(@.calculate_pos(1)).addClass('navInNext')

  after_moved_next: ->
    setTimeout( =>
      @.$items.removeClass('navInNext navOutNext')
      @.$items.not(@.$current_item).removeClass('m-current')
      @.add_previews_for_current_slide(@.current_pos())
      @._init_events()
      @.$next_btn.addClass('m-active')
    , @.params.anim_clock)


  after_moved_prev: ->
    setTimeout( =>
      @.$items.removeClass('navInPrev navOutPrev')
      @.$items.not(@.$current_item).removeClass('m-current')
      @.add_previews_for_current_slide(@.current_pos())
      @._init_events()
      @.$prev_btn.addClass('m-active')
    , @.params.anim_clock)



  add_previews_for_current_slide : (current_id) ->
    prev_id = @.calculate_pos(-1)
    next_id = @.calculate_pos(1)

    $preview_prev = @.$previews.eq(prev_id)
    $preview_next = @.$previews.eq(next_id)

    @.$next_btn.find('.js-preview-next').html($preview_next)
    @.$prev_btn.find('.js-preview-prev').html($preview_prev)