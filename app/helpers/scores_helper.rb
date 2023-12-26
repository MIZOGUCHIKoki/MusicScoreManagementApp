# frozen_string_literal: true

module ScoresHelper
  def m2ms(sec)
    return '時間未設定' if sec.nil?

    m = sec / 60
    s = sec % 60
    "#{m}分#{s}秒"
  end
end
