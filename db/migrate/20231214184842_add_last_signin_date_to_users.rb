# frozen_string_literal: true

class AddLastSigninDateToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_signin_date, :date
  end
end
