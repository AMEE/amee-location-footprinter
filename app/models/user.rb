class User < ActiveRecord::Base
  validates :email, :token, :name, :presence => true

end
