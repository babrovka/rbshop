UserPresenter = Struct.new(:user) do
  def title
    user.email
  end
end