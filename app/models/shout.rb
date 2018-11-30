class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true
  has_many :likes
end
