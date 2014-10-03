class User < ActiveRecord::Base
  self.table_name = "shop_users"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  after_create :send_welcome_mail
  
  has_one :cart
  has_many :orders
  
  def discount
    case self.bought_counter
    when 30000
      3 
    when 50000
      5 
    when 100000
      10
    when 150000
      15 
    when 200000
      20
    else
      nil
    end
  end
  
  private
  
  def send_welcome_mail
   UserMailer.welcome(self).deliver
  end
 
end
