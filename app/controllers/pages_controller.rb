#
# Данный контроллер необходим только для отрисовки главной страницы
#
# Если нужно создать еще пару статических страниц
# то нужно воспользоваться гемом high_voltage
# и просто поместить файл html.slim в папку pages
# и в роутингах прописать адрес
# никаких методов в контроллерах делать не нужно
#
class PagesController < ApplicationController

  # главная страница
  def index
    # для активации инверсной шапки на странице
    @extra_header = true
    @extra_products = Product.in_stock.important.limit 10
    @slides = Slide.for_allowed_products
  end


end