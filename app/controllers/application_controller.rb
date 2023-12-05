# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  # サインイン済みのユーザか確認する
  def signed_in_user
    return true if signed_in?

    # 偽である場合（サインインできていない時）の処理
    store_location # どこからやってきたか保存する
    flash[:danger] = 'サインインしてください'
    redirect_to signin_path, status: :see_other
    false
  end
end
