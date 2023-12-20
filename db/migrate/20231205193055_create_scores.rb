# frozen_string_literal: true

class CreateScores < ActiveRecord::Migration[7.1]
  def change
    create_table :scores do |t|
      t.text :name, null: false
      t.text :composer
      t.text :arranger
      t.text :grade
      t.integer :time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :scores, %i[user_id created_at]
  end
end
