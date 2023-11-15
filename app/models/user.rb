# frozen_string_literal: true

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.email = email.downcase } # email を小文字へ変換する．
  validates :name,  presence: true, # 入力必須
                    length: { maximum: 50 } # 最大長50
  validates :email, presence: true, # 入力必須
                    length: { maximum: 255 }, # 最大長255
                    format: { with: VALID_EMAIL_REGEX }, # FORMATに沿っているか？
                    uniqueness: { case_sensitive: false } # 一意なものであるか?
  validates :password, presence: true, # 入力必須
                       length: { in: 6..50 } # 8〜50文字
  has_secure_password # NEED `bcrypt`
end
