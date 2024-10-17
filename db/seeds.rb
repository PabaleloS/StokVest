# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "open-uri"

puts "Clearing database"
# Message.destroy_all
User.destroy_all
Member.destroy_all
Stokvel.destroy_all

puts "Creating 7 Stovel groups and their owners.."

gontse = User.create!(first_name: "Gontse", last_name: "M", email: "gontse@stokvel.com", password: "password")
gontse_file = URI.open("https://avatars.githubusercontent.com/u/146489308?v=4")
# gontse.photo.attach(io: gontse_file, filename: "avatar.png", content_type: "image/png")
gontse.save
gontse_stokvel = Stokvel.create!(user: gontse, name: "Gontse's Stokvel", balance: 0, contribution_amount: 500, description: "This stokvel was created to support community projects in the local area.", contribution_frequency: 'monthly')
gontse_member = Member.create!(stokvel: gontse_stokvel, user: gontse, join_date: Date.today, balance: 0, status: "accepted")

karabo = User.create!(first_name: "Karabo", last_name: "M", email: "karabo@stokvel.com", password: "password")
karabo_file = URI.open("https://avatars.githubusercontent.com/u/157271602?v=4") # Replace with a valid URL
# karabo.photo.attach(io: karabo_file, filename: "avatar.png", content_type: "image/png")
karabo.save
karabo_stokvel = Stokvel.create!(user: karabo, name: "Travel Stokvel", balance: 0, contribution_amount: 1000, description: "Join this stokvel to save for your dream vacation!", contribution_frequency: 'monthly')
karabo_member = Member.create!(stokvel: karabo_stokvel, user: karabo, join_date: Date.today, balance: 0, status: "accepted")

pabalelo = User.create!(first_name: "Pabalelo", last_name: "S", email: "pabalelo@stokvel.com", password: "password")
pabalelo_file = URI.open("https://avatars.githubusercontent.com/u/114606058?v=4")
# pabalelo.photo.attach(io: pabalelo_file, filename: "avatar.png", content_type: "image/png")
pabalelo.save
pabalelo_stokvel = Stokvel.create!(user: pabalelo, name: "Building Tomorrow", balance: 0, contribution_amount: 1500, description: "Our stokvel helps members save money for a house, car or business.", contribution_frequency: 'monthly')
pabalelo_member = Member.create!(stokvel: pabalelo_stokvel, user: pabalelo, join_date: Date.today, balance: 0, status: "accepted")

kagiso = User.create!(first_name: "Kagiso", last_name: "M", email: "kagiso@stokvel.com", password: "password")
kagiso_file = URI.open("https://avatars.githubusercontent.com/u/123456789?v=4") # Replace with a valid URL
# kagiso.photo.attach(io: kagiso_file, filename: "avatar.png", content_type: "image/png")
kagiso.save
kagiso_stokvel = Stokvel.create!(user: kagiso, name: "Kagiso's Savings", balance: 0, contribution_amount: 800, description: "A stokvel for saving towards personal goals.", contribution_frequency: 'monthly')
kagiso_member = Member.create!(stokvel: kagiso_stokvel, user: kagiso, join_date: Date.today, balance: 0, status: "accepted")

achmant = User.create!(first_name: "Achmant", last_name: "M", email: "achmant@stokvel.com", password: "password")
achmant_file = URI.open("https://avatars.githubusercontent.com/u/144101420?v=4")
# achmant.photo.attach(io: achemant_file, filename: "avatar.png", content_type: "image/png")
achmant.save
achmant_stokvel = Stokvel.create!(user: achmant, name: "Achmant's Investments", balance: 0, contribution_amount: 1200, description: "A stokvel focused on investing in stocks and bonds.", contribution_frequency: 'monthly')
Member.create!(stokvel: achmant_stokvel, user: achmant, join_date: Date.today, balance: 0, status: "accepted")

puts "7 Stokvel and their owners created"

puts "Creating some app users and adding members to existing Stokvels..."

user1 = User.create!(first_name: "Aubrey", last_name: "A", email: "aubrey@stokvel.com", password: "password")
user1_file = URI.open("https://thispersondoesnotexist.com")
# user1.photo.attach(io: user1_file, filename: "avatar.png", content_type: "image/png")
user1.save
user2 = User.create!(first_name: "Bonolo", last_name: "B", email: "bonolo@stokvel.com", password: "password")
user2_file = URI.open("https://thispersondoesnotexist.com")
# user2.photo.attach(io: user2_file, filename: "avatar.png", content_type: "image/png")
user2.save
user3 = User.create!(first_name: "Cele", last_name: "C", email: "cele@stokvel.com", password: "password")
user3_file = URI.open("https://thispersondoesnotexist.com")
# user3.photo.attach(io: user3_file, filename: "avatar.png", content_type: "image/png")
user3.save
user4 = User.create!(first_name: "Dylan", last_name: "D", email: "dylan@stokvel.com", password: "password")
user4_file = URI.open("https://thispersondoesnotexist.com")
# user4.photo.attach(io: user4_file, filename: "avatar.png", content_type: "image/png")
user4.save
user5 = User.create!(first_name: "Ellis", last_name: "E", email: "ellis@stokvel.com", password: "password")
user5_file = URI.open("https://thispersondoesnotexist.com")
# user5.photo.attach(io: user5_file, filename: "avatar.png", content_type: "image/png")
user5.save
user6 = User.create!(first_name: "Francis", last_name: "F", email: "francis@stokvel.com", password: "password")
user6_file = URI.open("https://thispersondoesnotexist.com")
# user6.photo.attach(io: user6_file, filename: "avatar.png", content_type: "image/png")
user6.save
user7 = User.create!(first_name: "Gomolemo", last_name: "G", email: "gomolemo@stokvel.com", password: "password")
user7_file = URI.open("https://thispersondoesnotexist.com")
# user7.photo.attach(io: user7_file, filename: "avatar.png", content_type: "image/png")
user7.save
user8 = User.create!(first_name: "Harper", last_name: "H", email: "harper@stokvel.com", password: "password")
user8_file = URI.open("https://thispersondoesnotexist.com")
# user8.photo.attach(io: user8_file, filename: "avatar.png", content_type: "image/png")
user8.save
user9 = User.create!(first_name: "Isabel", last_name: "I", email: "isabel@stokvel.com", password: "password")
user9_file = URI.open("https://thispersondoesnotexist.com")
# user9.photo.attach(io: user9_file, filename: "avatar.png", content_type: "image/png")
user9.save

puts "#{User.count} users created"

puts "Adding members to Gontse's Stokvel..."

gontse_member_1 = Member.create!(stokvel: gontse_stokvel, user: user1, join_date: Date.today, balance: 0, status: "accepted")
gontse_member_2 = Member.create!(stokvel: gontse_stokvel, user: user2, join_date: Date.today, balance: 0, status: "accepted")
gontse_member_3 = Member.create!(stokvel: gontse_stokvel, user: user3, join_date: Date.today, balance: 0, status: "accepted")

puts "Adding members to Karabo's Stokvel..."

karabo_member_1 = Member.create!(stokvel: karabo_stokvel, user: user4, join_date: Date.today, balance: 0, status: "accepted")
karabo_member_2 = Member.create!(stokvel: karabo_stokvel, user: user5, join_date: Date.today, balance: 0, status: "accepted")
karabo_member_3 = Member.create!(stokvel: karabo_stokvel, user: user6, join_date: Date.today, balance: 0, status: "accepted")

puts "Adding members to Pabalelo's Stokvel..."

pabalelo_member_1 = Member.create!(stokvel: pabalelo_stokvel, user: user7, join_date: Date.today, balance: 0, status: "accepted")
pabalelo_member_2 = Member.create!(stokvel: pabalelo_stokvel, user: user8, join_date: Date.today, balance: 0, status: "accepted")
pabalelo_member_3 = Member.create!(stokvel: pabalelo_stokvel, user: user9, join_date: Date.today, balance: 0, status: "accepted")


puts "Adding members to Kagiso's Stokvel..."

kagiso_member_1 = Member.create!(stokvel: kagiso_stokvel, user: user1, join_date: Date.today, balance: 0, status: "accepted")
kagiso_member_2 = Member.create!(stokvel: kagiso_stokvel, user: user2, join_date: Date.today, balance: 0, status: "accepted")
kagiso_member_3 = Member.create!(stokvel: kagiso_stokvel, user: user3, join_date: Date.today, balance: 0, status: "accepted")

puts "Adding members to Achmant's Stokvel..."

achmant_member_1 = Member.create!(stokvel: achmant_stokvel, user: user4, join_date: Date.today, balance: 0, status: "accepted")
achmant_member_2 = Member.create!(stokvel: achmant_stokvel, user: user5, join_date: Date.today, balance: 0, status: "accepted")
achmant_member_3 = Member.create!(stokvel: achmant_stokvel, user: user6, join_date: Date.today, balance: 0, status: "accepted")

puts "#{Member.count} members have been assigned to stokvels."
