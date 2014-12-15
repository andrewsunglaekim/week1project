class User < ActiveRecord::Base
	has_many :vendors
	has_many :purchases
	has_many :deals, :through => :vendors

	def authenticate(password)
    if BCrypt::Password.new(self.password_digest) == password
      return self
    else
      return nil
    end
  end
end