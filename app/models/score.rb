# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :composer,  length: { maximum: 255 }
  validates :arranger,  length: { maximum: 255 }
  # 最長でなく、数値の最大が5
  validates :grade, allow_nil: true,
                    numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :m_time, allow_nil: true,
                     numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1800 }
  # 0，1でなく、0から10までの数値を受け取る
  validates :piccolo, :c_flute, :oboe, :english_horn, :b_clarinet, :e_clarinet,
            :b_bass_clarinet, :bassoon, :e_alto_saxophone, :b_tenor_saxophone,
            :b_baritone_saxophone, :b_trumpet, :f_horn, :trombone, :euphonium,
            :tuba, :string_bass, :eb, :piano, :harp, :timpani, :drums, :percussion,
            numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  scope :grade_sort_no, ->    { order(created_at: :desc) }
  scope :grade_sort_desc, ->  { order(grade: :desc) }
  scope :grade_sort_asc, ->   { order(grade: :asc) }
  scope :score_search, lambda { |search_params|
  return if search_params.blank?

    # search_paramsが存在しないもしくは中身がないときの判定

    name_like(search_params[:name])
      .composer_like(search_params[:composer])
      .arranger_like(search_params[:arranger])
      .grade_like(search_params[:grade])
  }
  scope :name_like, ->(name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :composer_like, ->(composer) { where('composer LIKE ?', "%#{composer}%") if composer.present? }
  scope :arranger_like, ->(arranger) { where('arranger LIKE ?', "%#{arranger}%") if arranger.present? }
  scope :grade_like, ->(grade) { where('grade LIKE ?', "#{grade}%") if grade.present? }
  # if ~.present?:~の文字列が空か存在しない場合に処理をスキップする

  # 実引数:search_params, 仮引数:x
  # 21ブロック以上だと注意されるため，20ブロックに収めました
  scope :score_search_gakki, lambda { |search_params|
    return if search_params.blank?
    use_piccolo(search_params[:piccolo])
      .use_c_flute(search_params[:c_flute])
      .use_oboe(search_params[:oboe])
      .use_english_horn(search_params[:english_horn])
      .use_e_clarinet(search_params[:e_clarinet])
      .use_b_clarinet(search_params[:b_clarinet])
      .use_b_bass_clarinet(search_params[:b_bass_clarinet])
      .use_bassoon(search_params[:bassoon])
      .use_e_alto_saxophone(search_params[:e_alto_saxophone])
      .use_b_tenor_saxophone(search_params[:b_tenor_saxophone])
      .use_b_baritone_saxophone(search_params[:b_baritone_saxophone])
      .use_b_trumpet(search_params[:b_trumpet])
      .use_f_horm(search_params[:f_horn])
      .use_trombone(search_params[:trombone])
      .use_eb(search_params[:eb])
      .use_euphonium(search_params[:euphonium])
      .use_tuba(search_params[:tuba])
      .use_string_bass(search_params[:string_bass]).use_piano(search_params[:piano])
      .use_harp(search_params[:harp]).use_timpani(search_params[:timpani])
      .use_drums(search_params[:drums]).use_percussion(search_params[:percussion])
  }
  # 仮引数"x"は"0"か"1"である
  # スコープの条件式 : x以上の対応するカラムを取ってくる
  scope :use_piccolo, ->(x) { where(piccolo: x..) }
  scope :use_c_flute, ->(x) { where(c_flute: x..) }
  scope :use_oboe, ->(x) { where(oboe: x..) }
  scope :use_english_horn, ->(x) { where(english_horn: x..) }
  scope :use_e_clarinet, ->(x) { where(e_clarinet: x..) }
  scope :use_b_clarinet, ->(x) { where(b_clarinet: x..) }
  scope :use_b_bass_clarinet, ->(x) { where(b_bass_clarinet: x..) }
  scope :use_bassoon, ->(x) { where(bassoon: x..) }
  scope :use_e_alto_saxophone, ->(x) { where(e_alto_saxophone: x..) }
  scope :use_b_tenor_saxophone, ->(x) { where(b_tenor_saxophone: x..) }
  scope :use_b_baritone_saxophone, ->(x) { where(b_baritone_saxophone: x..) }
  scope :use_b_trumpet, ->(x) { where(b_trumpet: x..) }
  scope :use_f_horm, ->(x) { where(f_horn: x..) }
  scope :use_trombone, ->(x) { where(trombone: x..) }
  scope :use_eb, ->(x) { where(eb: x..) }
  scope :use_euphonium, ->(x) { where(euphonium: x..) }
  scope :use_tuba, ->(x) { where(tuba: x..) }
  scope :use_string_bass, ->(x) { where(string_bass: x..) }
  scope :use_piano, ->(x) { where(piano: x..) }
  scope :use_harp, ->(x) { where(harp: x..) }
  scope :use_timpani, ->(x) { where(timpani: x..) }
  scope :use_drums, ->(x) { where(drums: x..) }
  scope :use_percussion, ->(x) { where(percussion: x..) }
end
