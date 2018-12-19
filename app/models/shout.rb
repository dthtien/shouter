class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true
  has_many :likes

  after_commit :write_content, on: :create

  searchkick
  def search_data
    {
      body_content: content.body
    }
  end

  private

  def write_content
    WritingJob.perform_later(id)
  end
end
