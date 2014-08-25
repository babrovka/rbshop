$ ->

  # запрещаем стандартные клики по ссылке в форме
  $('.js-checkout-form a').on('click', (e) ->
    $target = $(@)
    if $target.hasClass 'm-active'
      $target.closest('form').submit()
  )


  # как только все поля забиты, то выставляем кнопку активной
  $('.js-checkout-form input, .js-checkout-form textarea ').on('keyup', (e) ->
    $form = $(@).closest('form')
    $link = $form.find('a')
    name = $form.find('#order_name').val()
    email = $form.find('#order_email').val()
    phone = $form.find('#order_phone').val()
    address = $form.find('#order_address').val()

    console.log "#{name.length} #{email.length} #{phone.length} #{address.length}"

    if name.length >= 2 && email.length >= 5 && phone.length >= 7 && address.length >= 2
      console.log 'yes'
      $link.removeClass('m-disactive').addClass('m-active') if $link.hasClass('m-disactive')
    else
      console.log 'no'
      $link.removeClass('m-active').addClass('m-disactive')
  )