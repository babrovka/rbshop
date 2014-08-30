$ ->
  new window.app.MainSlider('.js-main-slider')

  window.order_popover = new window.app.Popover('.js-order-create-popover')
  window.order_popover.hide()

  @.tabs = new window.app.Tabs(['#description', '#payment', '#ingredients'])
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


  console.log $('.js-main-menu-2level:empty').remove()

  # главное меню
  $('<div class="main-menu__block"></div>').insertBefore('.js-main-menu-2level > li')
  $('.js-main-menu > li').mouseenter( ->
    $(@).closest('li').addClass('m-active')
  ).mouseleave( ->
    $(@).closest('li').removeClass('m-active')
  )
