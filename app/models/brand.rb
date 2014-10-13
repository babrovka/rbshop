# == Schema Information
#
# Table name: brands
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  partner_id :integer
#

class Brand < ActiveRecord::Base
  has_many :products
end
