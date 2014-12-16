class User < ActiveRecord::Base
	has_many :vendors, dependent: :destroy
	has_many :purchases, dependent: :destroy
	has_many :deals, :through => :vendors
  validates :email, :username, uniqueness: true
  validates :name, :username, :email, :password_digest, presence: true

	def authenticate(password)
    if BCrypt::Password.new(self.password_digest) == password
      return self
    else
      return nil
    end
  end
end