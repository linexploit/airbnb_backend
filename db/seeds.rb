# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

# BIEN A METTRE AU DEBUT /// Méthode pour générer un numéro de téléphone français valide
def generate_french_phone_number
 prefix = '01'
 number = Faker::Number.number(digits: 8)
 formatted_number = "#{prefix}#{number}"
 formatted_number
end

# Détruire la base actuelle
ActiveRecord::Base.connection.tables.each do |table|
 next if table == 'schema_migrations'
 ActiveRecord::Base.connection.execute("TRUNCATE #{table} CASCADE")
end

# Créer 20 utilisateurs avec des numéros de téléphone valides
20.times do
 email = Faker::Internet.email
 phone_number = generate_french_phone_number
 description = Faker::Lorem.paragraph
 User.create!(
     email: email,
     phone_number: phone_number,
     description: description
 )
puts "Users bien créés"
end

# Créer 10 villes
10.times do
 city_name = Faker::Address.city
 # Générer un code postal valide pour la France
 zip_code = nil
 loop do
     zip_code = Faker::Address.zip_code
     break if zip_code.match(/\A(([0-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/)
 end
 # Créer la ville avec les données générées
 City.create!(
     name: city_name,
     zip_code: zip_code
 )
puts "Cities bien créés"
end

# Créer 50 listings
50.times do
 # Générer une description de 140 caractères ou plus
 description = Faker::Lorem.characters(number: 140)
   
 listing = Listing.create!(
     available_beds: Faker::Number.between(from: 1, to: 5),
     price: Faker::Number.between(from: 50, to: 200),
     description: description, # Utiliser la description générée
     has_wifi: [true, false].sample,
     welcome_message: Faker::Lorem.sentence,
     user: User.all.sample,
     city: City.all.sample
 )
puts "Listings bien créés"
end

# Créer 5 réservations dans le passé
5.times do
  start_date = Faker::Date.backward(days: 365)
  end_date = Faker::Date.between(from: start_date + 1.day, to: start_date + 365.days)
  Reservation.create!(
     start_date: start_date,
     end_date: end_date,
     user: User.all.sample,
     listing: Listing.all.sample
  )
puts "Résa passées bien créés"
 end
 
 # Créer 5 réservations dans le futur
 5.times do
  start_date = Faker::Date.forward(days: 365)
  end_date = Faker::Date.between(from: start_date + 1.day, to: start_date + 365.days)
  Reservation.create!(
     start_date: start_date,
     end_date: end_date,
     user: User.all.sample,
     listing: Listing.all.sample
  )
puts "Résa futures bien créés"
 end

#  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#  MES TESTS
#  User.count
#  City.count
#  Listing.count
#  Reservation.count
 
#  User.first.inspect
#  City.first.inspect
#  Listing.first.inspect
#  Reservation.first.inspect

#  User.all.limit(5).each { |user| puts user.inspect }
#  City.all.limit(5).each { |city| puts city.inspect }
#  Listing.all.limit(5).each { |listing| puts listing.inspect }
#  Reservation.all.limit(5).each { |reservation| puts reservation.inspect }

#  Listing.where(available_beds: 1).each { |listing| puts listing.inspect }

# # Afficher la ville d'un listing
# Listing.first.city.inspect

# # Afficher l'utilisateur d'un listing
# Listing.first.user.inspect

# # Afficher les listings d'une ville
# City.first.listings.each { |listing| puts listing.inspect }

# # Afficher les réservations d'un listing
# Listing.first.reservations.each { |reservation| puts reservation.inspect }
#  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
