class User < ActiveRecord::Base
  has_secure_password
  
  before_save{ |user| user.email = email.downcase}
  before_save :create_remember_token
  
  #validating name
  validates(:name, presence: true, length: {maximum: 50})
  
  #validating email
  #REGEX constant validates format of email
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates(:email, presence: true, length: {minimum: 6},
  uniqueness: {case_sensitive: false}, 
  format: {with:VALID_EMAIL_REGEX})
  
  
  
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
  
end
