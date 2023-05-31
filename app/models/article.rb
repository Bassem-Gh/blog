# frozen_string_literal: true

# articles model
class Article < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  scope :sorted, -> { order(published_at: :desc, updated_at: :desc) }
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where('published_at <= ?', Time.current) }
  scope :scheduled, -> { where('published_at >', Time.current) }
  def draft?
    published_at.nil?
  end
  # used to check whether a post s published or not for example to avoid commenting in drafts

  def published?
    published_at? && published_at <= Time.current
  end

  def schedule?
    published_at? && published_at >= Time.current
  end
end
