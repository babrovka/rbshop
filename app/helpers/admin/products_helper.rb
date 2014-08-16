module Admin::ProductsHelper

  # показыавет порядковый номер товара в списке
  # в зависимости от номера страницы выдает число от 1 до 999999
  def number_in_list(i)
    per_page = 15 # этот параметр задается в has_scope в контроллере
    page_num = params[:page].to_i
    page_num = 1 if page_num == 0
    (i+1)+((page_num-1).to_i*per_page)
  end
end