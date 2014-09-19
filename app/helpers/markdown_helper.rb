module MarkdownHelper
  def markdown(text)
    Redcarpet.new(text, :hard_wrap).to_html.html_safe
  end
  
  def special_markdown(number, text)
    text = number.to_s + '.&nbsp;' + text 
    Redcarpet.new(text, :hard_wrap).to_html.html_safe
  end
end
