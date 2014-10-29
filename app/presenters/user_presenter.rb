UserPresenter = Struct.new(:user, :view_context) do
  def title_html
    titles = []

    # формируем Имя Ф.
    titles << user.try(:first_name)
    titles << "#{user.try(:last_name).try(:first)}."

    # формируем email, если имени нет
    titles = [user.email] unless titles.count > 2

    titles.flatten.map do |title|
      view_context.content_tag :span, title
    end.join.html_safe
  end
end