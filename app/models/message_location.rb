# == Schema Information
#
# Table name: message_locations
#
#  id         :integer          not null, primary key
#  location_x :float
#  location_y :float
#  scale      :string(255)
#  label      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MessageLocation < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :message ,:as => :relatable

  def render

  end


   def self.get_distance(m1,m2)
   	lat1 = m1.location_x
   	lng1 = m1.location_y
   	lat2 = m2.location_x
   	lng2 = m2.location_y

		lat_diff = (lat1 - lat2)*Math::PI/180.0  
    lng_diff = (lng1 - lng2)*Math::PI/180.0  
    lat_sin = Math.sin(lat_diff/2.0) ** 2  
    lng_sin = Math.sin(lng_diff/2.0) ** 2  
    first = Math.sqrt(lat_sin + Math.cos(lat1*Math::PI/180.0) * Math.cos(lat2*Math::PI/180.0) * lng_sin)  
    result = Math.asin(first) * 2 * 6378137.0  
   end 
    
end
