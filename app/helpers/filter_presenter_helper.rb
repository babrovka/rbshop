module FilterPresenterHelper

  def filter_presenter
    presenter = FilterPresenter.new(self)
    yield presenter if block_given?
    presenter
  end

end