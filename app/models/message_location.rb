class MessageLocation < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :message ,:as => :relatable

  def render

  end
end
