$ ->
  tabs = new window.app.Tabs(['#description', '#payment', '#ingredients'])

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

    $target.val(current_val)
  )