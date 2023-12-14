# frozen_string_literal: true

namespace :user do
  desc 'Delete old users'
  task delete_old_users: :environment do
    User.where('last_signin_date < ?', 2.years.ago).destroy_all
    puts 'Old users deleted successfully.'
  end
end
