$ ->
  new window.app.MainSlider('.js-main-slider')

  window.order_popover = new window.app.Popover('.js-order-create-popover')
  window.order_popover.hide()

  window.add_to_cart_popover = new window.app.AddToCartPopover('.js-add-to-cart-popover')
  window.add_to_cart_popover.hide()

  @.tabs = new window.app.Tabs(['#description', '#payment', '#ingredients', '#comments'])
  _.each($('.js-scroller'), (el) -> new window.app.Scroller(el))


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
  current_min_val = $min_input.val() || $min_input.data('default')+1000 || 1000
  current_max_val = $max_input.val() || $max_input.data('default')-1000 || 8000

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