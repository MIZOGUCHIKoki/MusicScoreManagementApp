# frozen_string_literal: true

class User < ApplicationRecord
  # リレーション
  has_many :scores, dependent: :destroy

  # 仮想属性の追加（getter, setterを :remmber_token に設定する）
  attr_accessor :remember_token

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
                       length: { minimum: 6 }, # 最小長6
                       allow_nil: true # パスワードが空白でも更新できるように
  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost:)
  end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続的セッションのためにユーザをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    # パスワードなどは更新しないので，1項目のみ更新する update_attribute を使用
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザのサインイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # セッションハイジャック防止のためのセッショントークンを返す
  # この記憶ダイジェスト再利用しているのは単に利便性のため
  def session_token
    remember_digest || remember
  end
end
