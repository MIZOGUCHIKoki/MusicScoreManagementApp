# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params) # 実装は終わっていないことに注意!
    if @user.save == true
      # 保存の成功をここで扱う。
      reset_session
      log_in @user
      flash[:success] = 'Welcome!'
      redirect_to @user # userのページにリダイレクト
    else
      render 'new', status: :unprocessable_entity # 保存に失敗した場合
    end
  end

  def destroy; end
  def show_detail; end
  def show_list; end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
