# frozen_string_literal: true

class User < ApplicationRecord
  # コールバック
  before_save { self.email = self.email.downcase } # 保存前にemailを小文字に変換する

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name,  presence: true, # Presence（存在性；空白でない）
                    length: { maximum: 50 } # 最大長50
  validates :email, presence: true, # Presence（存在性；空白でない）
                    length: { maximum: 255 }, # 最大長255
                    format: { with: VALID_EMAIL_REGEX }, # emailの正規表現
                    uniqueness: true # 一意性の検証
  has_secure_password
  validates :password, presence: true, # Presence（存在性；空白でない）
                       length: { minimum: 6 } # 最小長6
end
