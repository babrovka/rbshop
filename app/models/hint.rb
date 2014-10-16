# == Schema Information
#
# Table name: hints
#
#  id   :integer          not null, primary key
#  name :string(255)
#  text :text
#  type :integer          default(0)
#

class Hint < ActiveRecord::Base

  enum hint_type: [ :info, :help ]

  default_scope { order('name ASC') }

end
