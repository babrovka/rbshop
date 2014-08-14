class window.app.Scroller
  params:
    el: '.js-scroller'
    container: '.js-scroller-container'
    item: '.js-scroller-item'
    next_btn: "<a href='#' class='scroller__btn m-next'></a>"
    prev_btn: "<a href='#' class='scroller__btn m-prev'></a>"

  constructor : () ->
    @.$el = $(@.params.el)
    @.$container = $(@.params.container)
    @.$items = @.$container.find(@.params.item)

    if @.$el.length && @.$container.length && @.$items.length
      @._init_sizes()
      @._render_elems()
      @._init_events()


  _init_sizes: ->
    @.item_width = @.$items.eq(0).width()
    @.max_width = 0
    @.max_width = @.item_width * @.$items.length
    @.$container.width(@.max_width)
    @.$el.height(@.$items.eq(0).height())


  _render_elems: ->
    @.$next_btn = $(@.params.next_btn).appendTo(@.$el)
    @.$prev_btn = $(@.params.prev_btn).appendTo(@.$el)


  _init_events: ->
    if @.$next_btn.length
      @.$next_btn.on('click', (e) =>
        e.preventDefault()
        @.scroll_next()
      )

    if @.$prev_btn.length
      @.$prev_btn.on('click', (e) =>
        e.preventDefault()
        @.scroll_prev()
      )


  scroll_next: (n=1) ->
    new_offset = @.$container.position().left - n*@.item_width
    new_offset = @.max_width if new_offset <= -@.max_width
    @.set_new_offset(new_offset)


  scroll_prev: (n=1) ->
    new_offset = @.$container.position().left + n*@.item_width
    new_offset = 0 if new_offset >= 0
    @.set_new_offset(new_offset)


  set_new_offset: (offset) ->
    @.$container.animate({left: offset}, 300)