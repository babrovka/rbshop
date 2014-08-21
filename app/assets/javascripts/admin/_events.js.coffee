$ ->
  # кнопки редактирования-просмотра в таблицах
  # делаем почти-прозрачными,чтобы при показе колонки не прыгали в своей ширине
  # при наведении мыши показываем ярко,при убирании мыши снова делаем полупрозрачными
  $('.js-item-row-btns').css(opacity: 0.1)
  $('.js-item-row').on('mouseover', ->
    $(@).closest('.js-item-row').find('.js-item-row-btns').animate({opacity: 1}, 50)
  ).on('mouseleave', ->
    $(@).closest('.js-item-row').find('.js-item-row-btns').animate({opacity: 0.1}, 50)
  )

