$ ->
  new window.app.MainSlider('.js-main-slider')

  window.order_popover = new window.app.Popover('.js-order-create-popover')
  window.order_popover.hide()

  window.add_to_cart_popover = new window.app.AddToCartPopover('.js-add-to-cart-popover')
  window.add_to_cart_popover.hide()

  @.tabs = new window.app.Tabs(['#description', '#payment', '#ingredients', '#comments'])
  _.each($('.js-scroller'), (el) -> new window.app.Scroller(el))


  # на странице «корзина» убиваем поповер связанный с «ваш товар добавлен»
  unless window.location.pathname.match(/cart/) == null
    delete window.add_to_cart_popover

  # работа счетчика.
  # инпут с кнопками «больше» и «меньше»
  $('.js-counter a').on('click', (e) ->
    e.preventDefault()
    $link = $(@)
    $target = $link.closest('.js-counter').find('input')
    current_val = $target.val()
    if $link.hasClass('js-counter-up')
      ++current_val
    else
      --current_val

    current_val = 0 if current_val < 0
    current_val = 999 if current_val >= 999 # потому что по дизайну вмещается 3 символа

    $target.val(current_val)
  )


  # клик по ссылке автоматически подтверждает форму
  # может быть две схемы работы
  # 1. ссылка внутри формы
  # 2. ссылка где-то рядом с формой в dom
  $(document).on('click', '.js-form-submitter', (e)->
    e.preventDefault()
    $form = $(@).closest('form')
    if $form.length
      $form.submit()
      return
    else
      $form = $(@).parent().find('.js-form-submitting')
      $form.submit()
      return
  )


  $('.js-main-menu-2level:empty').remove()

  # главное меню
  $('<div class="main-menu__block"></div>').insertAfter('.js-main-menu > li > a')
  $('.js-main-menu > li').mouseenter( ->
    $(@).closest('li').addClass('m-active')
  ).mouseleave( ->
    $(@).closest('li').removeClass('m-active')
  )


  # вставляем спиннер для отображения процесса загрузки
  # по окончанию загрузки убираем его
  # если ujs после complete заменяет текущий элемент, тоспиннер уничтожается автоматически
  # чтобы не создавать грязных помех, сделаем показ спиннера через таймаут
  # но чтобы не захломлять оперативку, данный таймер будет всегда один
  # и будет очищаться постоянно в процесс работы ujs
  window.ajax_timer_id = 0

  add_spinner = (elem) ->
    $container = $(elem).closest('.js-spinner-container').append("<div class='element-spinner'><div class='fa fa-spinner fa-spin'></div></div>")
    # делаем отступ, чтобы спиннер был посередине блока
    $container.find('.element-spinner').css
      'padding-top': "#{($container.height()-16)/2}px"



  $(document).on('ajax:before', '[data-remote="true"]', (e) ->
    clearTimeout(window.ajax_timer_id)
    elem = @
    window.ajax_timer_id = setTimeout( ->
      add_spinner(elem)
    , 500)
  ).on('ajax:complete', '[data-remote="true"]', (e) ->
    clearTimeout(window.ajax_timer_id);
    $(@).closest('.js-spinner-container').find('.element-spinner').remove()
  )


  # обработка слайдера цены на странице с фильтром товаров
  $container = $('.js-price-slider')
  $min_input = $container.find('.js-price-slider-input-min')
  $max_input = $container.find('.js-price-slider-input-max')

  # определяем активные значения слайдера
  current_min_val = $min_input.val() || $min_input.data('default') || 0
  current_max_val = $max_input.val() || $max_input.data('default') || 100000

  # записываем активные значения слайдера в инпуты, если те пусты
  $min_input.val(current_min_val) unless $min_input.val()
  $max_input.val(current_max_val) unless $max_input.val()

  # активизация плагина
  $slider = $('.js-price-slider-handler')
  $slider.slider(
    range: true
    min: 0
    max: 10000
    step: 100
    values: [ current_min_val, current_max_val ]
    slide: ( event, ui ) ->
      $min_input.val( ui.values[0] );
      $max_input.val( ui.values[1] );

    stop: ->
      $max_input.trigger('change')

  )

  # после изменения значений напрямую в инпутах, меняем значения слайдера
  $min_input.on('change', ->
    min = $min_input.val()
    max = $max_input.val()

    # если выходим за границы выбранного максимального значения
    if min > max
      min = max
      $min_input.val(max)

    $slider.slider( values: [min, max] )
  )

  $max_input.on('change', ->
    min = $min_input.val()
    max = $max_input.val()

    # если выходим за границы выбранного минимального значения
    if max < min
      max = min
      $max_input.val(min)

    $slider.slider( values: [min, max] )
  )


  # показываем окошечко с результатами фильтрации

  # заготовка под окошко с кол-вом найденных товаров
  unless $('.js-filter-hint').length
    $filter_hint = $("<div class='js-filter-hint filter__hint'><span></span><a href='#' class='link'>Показать</a></div>").appendTo('.js-filter-form').hide()

  # клик по ссылке внутри блока подсказки подтверждает форму и грузит результаты
  $filter_hint.find('a').on('click', (e) ->
    e.preventDefault()
    $filter_hint.closest('form').submit()
  )

  render_data = (data) ->
    $filter_hint.find('span').text(data.text)

  render_load_spinner = ->
    $filter_hint.find('span').html("<span class='fa fa-spinner fa-spin'></span> загрузка...")

  request_data = (form) =>
    $form = $(form)
    $.ajax
      type: 'GET'
      url: form.action
      dataType: 'json'
      data: $form.serialize()
      success: (data) -> render_data(data)



  $('.js-filter-form').on('change', (e) ->
    $current_item_parent = $(e.target).parent()

    render_load_spinner()

    left_pos = $current_item_parent.width() + $current_item_parent[0].offsetLeft + 30
    $filter_hint.show().css
      left: left_pos
      top: $current_item_parent[0].offsetTop

    form = $current_item_parent.closest('form')[0]
    request_data(form)
  )

  # навешиваем всем чекбоксам красивые иконочки
  $("input[type='checkbox']").closest('label')
                              .addClass('checkbox')
                              .prepend("<span class='checkbox__icon'></span>")

  # ставим/убираем галочки при кликах на чекбокс
  $("input[type='checkbox']").on('change', (e) ->
    $(@).closest('label').find('.checkbox__icon').toggleClass('m-active')
  )

  # ставим галочки при загрузке страницы
  $("input[type='checkbox']:checked").closest('label').find('.checkbox__icon').addClass('m-active')


  # включаем тултипы
  # особенно применяются как подсказки в фильтрах
  $('.js-hint').tooltip(
    position :
      my : "left center",
      at : "right+20 center",
      using : (position, feedback) ->
        $(this).css(position)
        $("<div>")
          .addClass("arrow")
          .appendTo(this)
    show : null
    open : (event, ui) ->
      ui.tooltip.animate({ left : ui.tooltip.position().left + 10 }, 60);
    hide:
      effect : "slideLeft",
      delay : 10
  )