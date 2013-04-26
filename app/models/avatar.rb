class Avatar < ActiveRecord::Base
  # attr_accessible :title, :body
   mount_uploader :picture, AvatarUploader
   belongs_to :house
end
