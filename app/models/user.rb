# == Schema Information
#
# Table name: shop_users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  bought_counter         :integer          default(0)
#  name                   :string(255)
#  phone                  :string(255)
#  city                   :string(255)
#  address                :string(255)
#

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
    when 50000
      10
    when 100000
      15
    else
      5
    end
  end
  
  private
  
  def send_welcome_mail
   UserMailer.welcome(self).deliver
  end
 
end
