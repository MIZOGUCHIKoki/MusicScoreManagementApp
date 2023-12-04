# frozen_string_literal: true

class User < ApplicationRecord
  validates :name,  presence: true, # Presence（存在性；空白でない）
                    length: { maximum: 50 } # 最大長50
  validates :email, presence: true, # Presence（存在性；空白でない）
                    length: { maximum: 255 } # 最大長255
end
