class User < ActiveRecord::Base
  has_many :posts
  has_many :follows, foreign_key: :followee_id
  has_many :followings, foreign_key: :follower_id, class_name: "::Follow"
  has_many :followers, through: :follows, class_name: User
  has_many :followees, through: :followings, class_name: User

  attr_accessor :password
  validates_presence_of :fname, :lname, :uname, :password, :password_confirmation, :email, :location, :avatar
  validates_confirmation_of :password
  validates :email,:uname, uniqueness: true
  before_save :downcase_fields
  before_save :encrypt_password
  
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png" 
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
 
  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def self.authenticate(uname, password)
    user = User.where(uname: uname).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def downcase_fields
    self.fname.downcase!
    self.lname.downcase!
    self.uname.downcase!
    self.email.downcase!
    self.location.downcase!
  end
end
