module ProductsHelper

  # заглушка кнопки сортировки
  # имеет стрелочку, которая показывает сортировку
  def sort_link_to title, type, *args
    options = sorted_url_params(type)
    url = url_for(options)

    # в зависимости от типа сортировки и текущей сортировки выставляем класс для стрелочки
    icon_class = sorted_direction.include?('asc') ? 'fa-caret-up' : 'fa-caret-down'
    icon_class = 'fa-sort' unless request.original_url.include?(type.to_s)

    link_to url, *args do
      content_tag(:span, title) +
      content_tag(:span, nil, class: "fa #{icon_class}")
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


  # мета информация продукта
  # состоит из заголовка мета информации
  # и самого содержимого
  def product_meta_tag(attr, title)
    unless attr.blank?
      content_tag :p do
        content_tag(:span, "#{title}: ") +
        content_tag(:b, attr)
      end
    end
  end

private

  # формируем параметры для сортировки
  def sorted_url_params(type)
    _params = params.dup
    direction = sorted_direction
    if _params.try(:[], :q).blank?
      _params.merge!({ q: { s: "#{type.to_s} #{direction}" }})
    else
      _params[:q].merge!({ s: "#{type.to_s} #{direction}" })
    end
    _params
  end

  # направление сортировки
  def sorted_direction
    params.try(:[], :q).try(:[], :s).try(:include?, ('asc')) ? 'desc' : 'asc'
  end

end