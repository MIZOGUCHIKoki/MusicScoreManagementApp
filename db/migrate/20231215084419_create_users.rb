# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.integer :user_id
      t.text :email
      t.text :name
      t.text :password
      t.date :login

      t.timestamps
    end
  end
end
