# frozen_string_literal: true

class ScoresController < ApplicationController
  # 一覧を表示：GET
  def index; end

  # 個々のデータを表示：GET
  def show; end

  # 新規作成画面を表示：GET
  def new; end

  # 編集画面を表示：GET
  def edit; end

  # 作成を実行：POST
  def create; end

  # 更新を実行：PATCH/PUT
  def update; end

  # 削除を実行：DELETE
  def destroy; end

  private

  def score_params
    params.require(:score).permit
  end
end
