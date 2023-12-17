# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :user

  scope :grade_sort_no, ->    { order(created_at: :desc) }
  scope :grade_sort_desc, ->  { order('CAST(grade AS float) DESC') }
  scope :grade_sort_asc, ->   { order('CAST(grade AS float) ASC') }

  validates :name,                  presence: true,
                                    length: { maximum: 50 }
  validates :composer,              length: { maximum: 255 }
  validates :arranger,              length: { maximum: 255 }
  validates :grade,                 length: { maximum: 5 }
  # validates :time,                inculsion: { in:  }
  validates :piccolo,               inclusion: { in: [0, 1] }
  validates :c_flute,               inclusion: { in: [0, 1] }
  validates :oboe,                  inclusion: { in: [0, 1] }
  validates :english_horn,          inclusion: { in: [0, 1] }
  validates :e_clarinet,            inclusion: { in: [0, 1] }
  validates :b_clarinet,            inclusion: { in: [0, 1] }
  validates :b_bass_clarinet,       inclusion: { in: [0, 1] }
  validates :bassoon,               inclusion: { in: [0, 1] }
  validates :e_alto_saxophone,      inclusion: { in: [0, 1] }
  validates :b_tenor_saxophone,     inclusion: { in: [0, 1] }
  validates :b_baritone_saxophone,  inclusion: { in: [0, 1] }
  validates :b_trumpet,             inclusion: { in: [0, 1] }
  validates :f_horn,                inclusion: { in: [0, 1] }
  validates :trombone,              inclusion: { in: [0, 1] }
  # validates :baritone,              inclusion: { in: [0, 1] }
  validates :tuba,                  inclusion: { in: [0, 1] }
  validates :string_bass,           inclusion: { in: [0, 1] }
  validates :piano,                 inclusion: { in: [0, 1] }
  validates :harp,                  inclusion: { in: [0, 1] }
  validates :timpani,               inclusion: { in: [0, 1] }
  validates :drums,                 inclusion: { in: [0, 1] }
  validates :percussion,            inclusion: { in: [0, 1] }

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
end
