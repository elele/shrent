# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  username         :string(255)      not null
#  email            :string(255)
#  crypted_password :string(255)
#  salt             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!
  # attr_accessible :title, :body

  attr_accessible :email, :password, :password_confirmation ,:username
    
  validates_confirmation_of :password  
  validates_presence_of :password, :on => :create  
  validates_presence_of :email  
  validates_uniqueness_of :email
end
