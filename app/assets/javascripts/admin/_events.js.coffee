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


  # активируем select2
  $('.js-select2').select2()

  # показываем миниатюру картинки после ее загрузки
  $(document).on('change', 'input[type="file"]', (e) ->
    $input = $(@)
    window.loadImage e.target.files[0], ((img) =>
      $input.closest('.js-form-img-container').find('.js-form-img-placeholder').html(img)

      # скрываем ссылку «кропить», потому что изображения не сохранены
      $('.js-form-crop-link').text('чтобы получить доступ к кропингу изображений, нужно сохранить товар').attr('href', '#')
    )
  )