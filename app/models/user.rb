class User < ApplicationRecord
  include Clearance::User

  has_many :shouts
  validates :username, presence: true, uniqueness: true
end
