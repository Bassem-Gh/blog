# frozen_string_literal: true

# articles model
class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
