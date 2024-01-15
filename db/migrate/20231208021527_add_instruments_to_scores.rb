# frozen_string_literal: true

class AddInstrumentsToScores < ActiveRecord::Migration[7.1]
  def change
    add_column :scores, :piccolo, :integer, default: 0, null: false # ピッコロ
    add_column :scores, :c_flute, :integer, default: 0, null: false # Cフルート
    add_column :scores, :oboe, :integer, default: 0, null: false # オーボエ
    add_column :scores, :english_horn, :integer, default: 0, null: false # イングリッシュホルン
    add_column :scores, :b_clarinet, :integer, default: 0, null: false # B♭クラリネット
    add_column :scores, :e_clarinet, :integer, default: 0, null: false # E♭クラリネット
    add_column :scores, :b_bass_clarinet, :integer, default: 0, null: false # B♭バスクラリネット
    add_column :scores, :bassoon, :integer, default: 0, null: false # バスーン（ファゴット）
    add_column :scores, :e_alto_saxophone, :integer, default: 0, null: false # E♭アルトサクソフォーン
    add_column :scores, :b_tenor_saxophone, :integer, default: 0, null: false # B♭テナーサクソフォーン
    add_column :scores, :b_baritone_saxophone, :integer, default: 0, null: false # B♭バリトンサクソフォーン
    add_column :scores, :b_trumpet, :integer, default: 0, null: false # B♭トランペット
    add_column :scores, :f_horn, :integer, default: 0, null: false # Fホルン
    add_column :scores, :trombone, :integer, default: 0, null: false # トロンボーン
    add_column :scores, :euphonium, :integer, default: 0, null: false # ユーフォニアム
    add_column :scores, :tuba, :integer, default: 0, null: false # チューバ
    add_column :scores, :string_bass, :integer, default: 0, null: false # ストリングバス（コントラバス）
    add_column :scores, :eb, :integer, default: 0, null: false # エレキベース
    add_column :scores, :piano, :integer, default: 0, null: false # ピアノ
    add_column :scores, :harp, :integer, default: 0, null: false # ハープ
    add_column :scores, :timpani, :integer, default: 0, null: false # ティンパニ
    add_column :scores, :drums, :integer, default: 0, null: false # ドラムセット
    add_column :scores, :percussion, :integer, default: 0, null: false # パーカッション（打楽器）
  end
end
