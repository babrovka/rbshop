module ProductsHelper

  def sort_link_to title, url='#', options={}
    link_to url, options do
      content_tag(:span, title) +
      content_tag(:span, nil, class: 'fa fa-caret-up')
    end
  end

end