# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
5.times do
  FactoryBot.create(:tag)
end


25.times do
  FactoryBot.create(:book, :has_flags)
end

5.times do
  FactoryBot.create(:user, :author)
end

2.times do
  FactoryBot.create(:user, :admin)
end

