UserPresenter = Struct.new(:user, :view_context) do
  def title_html
    titles = []

    # формируем Имя Ф.
    titles << user.try(:first_name).try(:capitalize)
    titles << "#{user.try(:last_name)[0].try(:capitalize)}."

    # формируем email, если имени нет
    titles << user.email unless titles.count

    titles.flatten.map do |title|
      view_context.content_tag :span, title
    end.join.html_safe
  end
end