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