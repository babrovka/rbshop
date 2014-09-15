class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def personal  
  end

  def orders
  end

end