class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def personal  
  end

  def orders
    @collection = current_user.orders.order('created_at DESC')
  end

  def update
    current_user.update_attributes permitted_params
    redirect_to :back
  end


private
  def permitted_params
    params.require(:user).permit(:name, :phone, :city, :address)
  end

end