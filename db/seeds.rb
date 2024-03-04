# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
5.times do
  FactoryBot.create(:genre)
end

5.times do
  FactoryBot.create(:user, :is_author)
end

25.times do
  FactoryBot.create(:book, :has_flags)
end

6.times do
  FactoryBot.create(:business)
end

2.times do
  FactoryBot.create(:user, :admin)
end

FactoryBot.create(:promo)

FactoryBot.create(:user, email: 'test@test.com', role: 'super_admin')
