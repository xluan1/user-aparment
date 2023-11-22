class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :username, presence: true, uniqueness: true, format: { with: /[a-zA-Z0-9]/ }
end
