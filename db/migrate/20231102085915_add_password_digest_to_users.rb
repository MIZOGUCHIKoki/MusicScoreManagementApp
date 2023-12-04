# frozen_string_literal: true

class AddPasswordDigestToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password_digest, :string
    add_column :users, :is_admin, :boolean, default: false, null: false
  end
end
