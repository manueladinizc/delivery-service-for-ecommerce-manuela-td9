# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#Modality
Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)
Modality.create!(name: 'Same day delivery', minimum_distance: 3, maximum_distance:10, minimum_weight:0, maximum_weight:20, flat_rate:10, modality_status: 1)
Modality.create!(name: 'Express delivery', minimum_distance: 3, maximum_distance:25, minimum_weight:0, maximum_weight:30, flat_rate:20)
modality = Modality.create!(name: 'Standart service', minimum_distance: 3, maximum_distance:25, minimum_weight:0, maximum_weight:30, flat_rate:20)

#usuário Adm
UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

#usuário Regular
UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')

#Vehicle
Vehicle.create!(registration_plate: 123456, brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:1, modality: modality)

Vehicle.create!(registration_plate: 987456, brand: "Kia", car_model: "Bongo", model_year: 2019, weight_capacity:800, car_status:0, modality: modality)

Vehicle.create!(registration_plate: 123987, brand: "Renault", car_model: "Master", model_year: 2020, weight_capacity:500, car_status:1, modality: modality)