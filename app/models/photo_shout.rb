class PhotoShout < ApplicationRecord
  has_attached_file :body, styles: {thumb: '200x200'}

  validates_attachment :body,
    content_type: {content_type: ['image/jpeg', 'image/png'] },
    presence: true
end
