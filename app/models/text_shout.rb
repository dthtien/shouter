class TextShout < ApplicationRecord
  has_many :shouts, as: :content

  validates :body, presence: :true, length: {in: 1..144}
end
