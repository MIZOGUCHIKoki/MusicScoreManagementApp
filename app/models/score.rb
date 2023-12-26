# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { maximum: 50 }
end
