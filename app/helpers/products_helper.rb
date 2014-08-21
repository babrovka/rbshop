module ProductsHelper

  # заглушка кнопки сортировки
  # имеет стрелочку, которая показывает сортировку
  def sort_link_to title, url='#', options={}
    link_to url, options do
      content_tag(:span, title) +
      content_tag(:span, nil, class: 'fa fa-caret-up')
    end
  end

  # кнопка добавить в корзину
  # сложная структура и поэтому вынесена в хэлпер
  def add_to_cart_btn(product, extra_css=nil)
    link_to('#', class: "btn m-primary js-form-submitter #{extra_css}") do
      content_tag(:span, nil, class: 'fa fa-shopping-cart') +
      content_tag(:span, 'в корзину')
    end.html_safe +
    form_tag(line_items_path(product_id: product.id), remote: true, class: 'hidden js-form-submitting' ) do
    end
  end

end