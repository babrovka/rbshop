class window.app.Scroller
  params:
    el: '.js-scroller'
    container: '.js-scroller-container'
    item: '.js-scroller-item'
    width: '250px'
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
    sum_width = 0
    sum_width = @.$items.eq(0).width() * @.$items.length
    @.$container.width(sum_width)


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
    @.$el

