# frozen_string_literal: true

class CreateScores < ActiveRecord::Migration[7.1]
  def change
    create_table :scores, &:timestamps
  end
end
