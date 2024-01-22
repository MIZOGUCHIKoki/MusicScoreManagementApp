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
User.create!(name: 'Example User',
             email: 'example@example.com',
             password: 'password',
             password_confirmation: 'password',
             admin: true)
10.times do |t|
  name = Faker::Name.name
  email = "example#{t + 1}@example.com"
  User.create!(name:,
               email:,
               password: 'password',
               password_confirmation: 'password')
end

users = User.order(:created_at).take(6)
name = Faker::Lorem.sentence(word_count: 2)
composer = Faker::Name.name
arranger = Faker::Name.name
users.each do |user|
  user.scores.create!(name:,
                      composer:,
                      arranger:,
                      grade: '1',
                      m_time: 320,
                      timpani: 1,
                      drums: 1,
                      percussion: 1)
end

