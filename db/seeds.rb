# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

99.times do |t|
  name = Faker::Name.name
  email = "example#{t + 1}@railstutorial.org"
  User.create!(name:,
               email:,
               password: 'password',
               password_confirmation: 'password')
end

users = User.order(:created_at).take(6)
50.times do
  name = Faker::Lorem.sentence(word_count: 1)
  users.each { |user| user.scores.create!(name:) }
end

User.create!(name: 'Example User',
             email: 'example@railstutorial.org',
             password: 'password',
             password_confirmation: 'password',
             admin: true)
