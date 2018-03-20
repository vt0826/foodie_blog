class Post < ActiveRecord::Base
  belongs_to :user
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png" 
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  def self.follow(users, id)
    users.each do |user|
     return true  if user.id == id
    end 
  end

end
