$ ->
  tabs = new window.app.Tabs(['#description', '#payment', '#ingredients'])

  new window.app.Scroller()
  
  _.each($('.js-scroller'), (el) -> new window.app.Scroller(el))
  new window.app.MainSlider('.js-main-slider')

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


  # инициализируем поповеры
  window.order_popover = new window.app.Popover('.js-order-create-popover')
#  window.order_popover.hide()