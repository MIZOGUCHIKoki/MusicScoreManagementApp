# frozen_string_literal: true

class User < ApplicationRecord
  has_many :scores, dependent: :destroy

  scope :user_search, lambda { |search_params|
    return if search_params.blank?

    name_like(search_params[:name])
      .email_like(search_params[:email])
  }
  scope :name_like, ->(search_word) { where('name LIKE ?', "%#{search_word}") }
  scope :email_like, ->(search_word) { where('email LIKE ?', "%#{search_word}") }
end
