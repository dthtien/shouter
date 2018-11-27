class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true

  scope :newest, -> {order('created_at desc')}
end
