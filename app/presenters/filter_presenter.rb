class FilterPresenter

  def initialize(template)
    @template = template
  end

  # список чекбоксов поискового фильтра по таксону
  # принимает
  #   - имя enum из модели Taxon
  #   - f объект формы под чекбоксы
  #   - html параметры
  def taxons_list(type, f, *args)
    taxons = Taxon.send(type)

    if taxons.present?
      h.content_tag :ul, *args do
        taxons.map do |taxon|
          h.content_tag :li do
            f.label "taxons_id_in_#{taxon.id}" do
              f.check_box( :taxons_id_in, { multiple: true }, taxon.id, nil) +
              h.content_tag(:span, taxon.title)
            end
          end
        end.flatten.compact.join.html_safe
      end
    else
      nil
    end
  end


  # заголовок поискового фильтра по таксону
  # принимает
  #   - имя enum из модели Taxon
  #   - html параметры
  def taxons_title(type, *args)
    h.content_tag(:h5, h.t(type, scope: 'activerecord.attributes.taxon.taxon_types'), *args)
  end

  # заголовок ценового фильтра
  # принимает ничего
  def price_title(*args)
    h.content_tag(:h5, 'по цене', *args)
  end


  # область с фильтром по цене
  # принимает
  #   - f объект формы под чекбоксы
  #   - html параметры
  def price_list(f, *args)
    html = []

    html << h.content_tag(:div, nil, class: 'js-price-slider-handler')

    html << h.content_tag(:li) do
          h.content_tag(:span, 'от') +
          f.text_field(:price_gteq,
                       type: :number,
                       class: 'js-price-slider-input-min',
                       'data-default' => 500
          )
    end

    html << h.content_tag(:li) do
          h.content_tag(:span, 'до') +
          f.text_field( :price_lteq,
                        type: :number,
                        class: 'js-price-slider-input-max',
                        'data-default' => 10000
          )
    end

    h.content_tag :ul, *args do
      html.flatten.compact.join.html_safe
    end
  end

private

  def h
    @template
  end

end