# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :user

  grade_sort_no ->    { order(created_at: :desc) }
  grade_sort_desc ->  { order('CAST(grade AS float) DESC') }
  grade_sort_asc ->   { order('CAST(grade AS float) ASC') }
  validates :name,      presence: true,
                        length: { maximum: 50 }
  validates :composer,  length: { maximum: 255 }
  validates :arranger,  length: { maximum: 255 }
  validates :grade,     length: { maxumum: 5 }
  # validates :piccoro, inclusion: { in:[0,1] }
end
