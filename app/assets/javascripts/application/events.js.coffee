$ ->
  tabs = new window.app.Tabs(['#description', '#payment', '#ingredients'])

  new window.app.Scroller()

  # работа счетчика.
  # инпут с кнопками «больше» и «меньше»
  $('.js-counter a').on('click', (e) ->
    console.log 'aaa'
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


  # кнопка автоматически подтверждает форму внутри которой она находится
  $(document).on('click', '.js-form-submitter', (e)->
    e.preventDefault()
    $(@).closest('form').submit()
  )