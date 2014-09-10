class User < ActiveRecord::Base
  self.table_name = "shop_users"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  after_create :send_welcome_mail
  
  
  
  private
  
  def send_welcome_mail
   UserMailer.welcome(self).deliver
  end
 
end
