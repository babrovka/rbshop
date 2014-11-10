OrderStatusPresenter = Struct.new(:order, :view_context) do
  def status_html
    translated_status = I18n.t(order.status, scope: 'enums.order.status')

    view_context.content_tag :span, class: 'order__status' do
      view_context.content_tag(:span, nil, class: icon_class) +
      view_context.content_tag(:span, translated_status)
    end.html_safe
  end


private

  def icon_class
    icon_css = ['fa']
    icon_css << case order.status.to_s
                  when 'not_paid' then 'fa-times m-cancelled'
                  when 'paid' then 'fa-check m-delivered'
                  when 'ready_for_delivery' then 'fa-spinner m-in-progress'
                  when 'delivered' then 'fa-check-circle m-delivered'
                end

    icon_css.join(' ')
  end

end