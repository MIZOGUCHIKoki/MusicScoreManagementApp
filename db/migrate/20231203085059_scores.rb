# frozen_string_literal: true

class Scores < ActiveRecord::Migration[7.1]
  def change
    add_column :scores, :name, :string # 曲名
    add_column :scores, :composer, :string # 作曲者名
    add_column :scores, :arranger, :string # 編曲者
    add_column :scores, :grade, :integer # グレード 1, 2, 3, 4
    add_column :scores, :time, :integer # 演奏時間（秒）

    add_column :scores, :piccolo, :integer, default: 0, null: false # ピッコロ
    add_column :scores, :piccolo, :integer, default: 0, null: false # ピッコロ
    add_column :scores, :piccolo, :integer, default: 0, null: false # ピッコロ
    add_column :scores, :piccolo, :integer, default: 0, null: false # ピッコロ
  end
end
