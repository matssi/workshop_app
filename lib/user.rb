require 'bcrypt'

class User
  include BCrypt
  include DataMapper::Resource
  attr_accessor :password, :password_confirmation

  property :id, Serial
  property :name, String
  property :email, String
  property :password_digest,Text

  validates_confirmation_of :password, message: 'Sorry, your passwords don\'t match'

  before :save do
    if self.password == self.password_confirmation
      self.password_digest = BCrypt::Password.create(self.password)
    else
      break
    end
  end



  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end


end
