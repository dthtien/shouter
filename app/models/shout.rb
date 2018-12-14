class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true
  has_many :likes

  after_commit :write_content, on: :create

  private

  def write_content
    WritingJob.perform_later(self.id)
  end
end
