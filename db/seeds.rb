# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#Modality
modality_1 = Modality.create!(name: 'Ship from store', minimum_distance: 11, maximum_distance:50, minimum_weight:10, maximum_weight:100, flat_rate:15)
modality_2 = Modality.create!(name: 'On-Demand delivery', minimum_distance: 3, maximum_distance:10, minimum_weight:0, maximum_weight:20, flat_rate:10, modality_status: 1)
modality_3 = Modality.create!(name: 'Express delivery', minimum_distance: 3, maximum_distance:25, minimum_weight:0, maximum_weight:30, flat_rate:20)
modality_4 = Modality.create!(name: 'Standart service', minimum_distance: 3, maximum_distance:25, minimum_weight:0, maximum_weight:30, flat_rate:20, modality_status: 1)


#usuário Adm
UserAdm.create!(name: 'Manuela', email: 'manuela@sistemadefrete.com.br', password: 'password')

#usuário Regular
UserRegular.create!(name: 'Manu', email: 'manu@sistemadefrete.com.br', password: 'password')

#Vehicle
#modality_1
Vehicle.create!(registration_plate: 123456, brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:0, modality: modality_1)
Vehicle.create!(registration_plate: 987456, brand: "Kia", car_model: "Bongo", model_year: 2019, weight_capacity:800, car_status:0, modality: modality_1)
Vehicle.create!(registration_plate: 123987, brand: "Renault", car_model: "Master", model_year: 2020, weight_capacity:500, car_status:1, modality: modality_1)
#modality_2
Vehicle.create!(registration_plate: 145756, brand: "Kia", car_model: "Bongo", model_year: 2019, weight_capacity:800, car_status:0, modality: modality_2)
Vehicle.create!(registration_plate: 973987, brand: "Renault", car_model: "Master", model_year: 2020, weight_capacity:500, car_status:1, modality: modality_2)
Vehicle.create!(registration_plate: 900787, brand: "Renault", car_model: "Master", model_year: 2020, weight_capacity:500, car_status:0, modality: modality_2)
#modality_3
Vehicle.create!(registration_plate: 175456, brand: "Kia", car_model: "Bongo", model_year: 2019, weight_capacity:800, car_status:0, modality: modality_3)
Vehicle.create!(registration_plate: 273987, brand: "Renault", car_model: "Master", model_year: 2020, weight_capacity:500, car_status:1, modality: modality_3)
Vehicle.create!(registration_plate: 280987, brand: "Renault", car_model: "Master", model_year: 2020, weight_capacity:500, car_status:0, modality: modality_3)
#modality_4
Vehicle.create!(registration_plate: 875456, brand: "Kia", car_model: "Bongo", model_year: 2019, weight_capacity:800, car_status:0, modality: modality_4)
Vehicle.create!(registration_plate: 789987, brand: "Renault", car_model: "Master", model_year: 2020, weight_capacity:500, car_status:1, modality: modality_4)
Vehicle.create!(registration_plate: 457456, brand: "Mercedes-Benz", car_model: "Sprinter", model_year: 2017, weight_capacity:300, car_status:0, modality: modality_4)


#WeightPrices
#Modality_1
WeightPrice.create!(initial_weight:0, final_weight:10, weight_rate:1, modality: modality_1 )
WeightPrice.create!(initial_weight:11, final_weight:30, weight_rate:5, modality: modality_1 )
WeightPrice.create!(initial_weight:31, final_weight:100, weight_rate:9, modality: modality_1 )
WeightPrice.create!(initial_weight:101, final_weight:1000, weight_rate:13, modality: modality_1 )
#Modality_2
WeightPrice.create!(initial_weight:0, final_weight:10, weight_rate:2, modality: modality_2 )
WeightPrice.create!(initial_weight:11, final_weight:30, weight_rate:6, modality: modality_2 )
WeightPrice.create!(initial_weight:31, final_weight:100, weight_rate:10, modality: modality_2 )
WeightPrice.create!(initial_weight:101, final_weight:1000, weight_rate:14, modality: modality_2 )
#Modality_3
WeightPrice.create!(initial_weight:0, final_weight:10, weight_rate:3, modality: modality_3 )
WeightPrice.create!(initial_weight:11, final_weight:30, weight_rate:7, modality: modality_3 )
WeightPrice.create!(initial_weight:31, final_weight:100, weight_rate:11, modality: modality_3 )
WeightPrice.create!(initial_weight:101, final_weight:1000, weight_rate:15, modality: modality_3 )
#Modality_4
WeightPrice.create!(initial_weight:0, final_weight:10, weight_rate:4, modality: modality_4 )
WeightPrice.create!(initial_weight:11, final_weight:30, weight_rate:8, modality: modality_4 )
WeightPrice.create!(initial_weight:31, final_weight:100, weight_rate:12, modality: modality_4 )
WeightPrice.create!(initial_weight:101, final_weight:1000, weight_rate:16, modality: modality_4 )

#DistancePrices
#Modality_1
DistancePrice.create!(initial_distance:0, final_distance:50, distance_rate:2, modality: modality_1 )
DistancePrice.create!(initial_distance:51, final_distance:150, distance_rate:9, modality: modality_1 )
DistancePrice.create!(initial_distance:150, final_distance:800, distance_rate:13, modality: modality_1 )
#Modality_2
DistancePrice.create!(initial_distance:0, final_distance:50, distance_rate:4, modality: modality_2 )
DistancePrice.create!(initial_distance:51, final_distance:150, distance_rate:10, modality: modality_2 )
DistancePrice.create!(initial_distance:150, final_distance:800, distance_rate:15, modality: modality_2 )
#Modality_3
DistancePrice.create!(initial_distance:0, final_distance:50, distance_rate:6, modality: modality_3 )
DistancePrice.create!(initial_distance:51, final_distance:150, distance_rate:11, modality: modality_3 )
DistancePrice.create!(initial_distance:150, final_distance:800, distance_rate:17, modality: modality_3 )
#Modality_4
DistancePrice.create!(initial_distance:0, final_distance:50, distance_rate:8, modality: modality_4 )
DistancePrice.create!(initial_distance:51, final_distance:150, distance_rate:12, modality: modality_4 )
DistancePrice.create!(initial_distance:150, final_distance:800, distance_rate:20, modality: modality_4 )

#Deadline
#Modality_1
Deadline.create!(initial_interval:0, final_interval:50, duration:1, modality: modality_1 )
Deadline.create!(initial_interval:51, final_interval:150, duration:5, modality: modality_1 )
Deadline.create!(initial_interval:151, final_interval:800, duration:7, modality: modality_1 )
Deadline.create!(initial_interval:801, final_interval:1500, duration:9, modality: modality_1 )
#Modality_2
Deadline.create!(initial_interval:0, final_interval:50, duration:2, modality: modality_2 )
Deadline.create!(initial_interval:51, final_interval:150, duration:6, modality: modality_2 )
Deadline.create!(initial_interval:151, final_interval:800, duration:8, modality: modality_2 )
Deadline.create!(initial_interval:801, final_interval:1500, duration:10, modality: modality_2 )
#Modality_3
Deadline.create!(initial_interval:0, final_interval:50, duration:3, modality: modality_3 )
Deadline.create!(initial_interval:51, final_interval:150, duration:6, modality: modality_3 )
Deadline.create!(initial_interval:151, final_interval:800, duration:8, modality: modality_3 )
Deadline.create!(initial_interval:801, final_interval:1500, duration:11, modality: modality_3 )
#Modality_4
Deadline.create!(initial_interval:0, final_interval:50, duration:4, modality: modality_4 )
Deadline.create!(initial_interval:51, final_interval:150, duration:7, modality: modality_4 )
Deadline.create!(initial_interval:151, final_interval:800, duration:9, modality: modality_4 )
Deadline.create!(initial_interval:801, final_interval:1500, duration:12, modality: modality_4 )


#Work_Orders
WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345VVC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100, work_order_status: 2)        
OpenWorkOrder.create!(modality_id: 1, work_order_id: 1, total_price: 1978, deadline_date: (Time.now - 5.day))
CloseWorkOrder.create!(work_order_id: 1, description: "", delivery_date: (Time.now - 6.day))

WorkOrder.create!(pickup_address: "Rua da Saudade, 10", pickup_city: 'Recife', pickup_state: "PE", product_code: "12345VVC", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 252", customer_name: "João", delivery_city: "Recife", delivery_state: 'PE', distance:100, work_order_status: 3)        
OpenWorkOrder.create!(modality_id: 1, work_order_id: 2, total_price: 1978, deadline_date: (Time.now - 5.day))
CloseWorkOrder.create!(work_order_id: 2, delivery_date: (Time.now - 2.day), description: "Houve atraso no transporte deviso a protesto nas estradas")

WorkOrder.create!(pickup_address: "Rua das Fronteiras, 18", pickup_city: 'Recife', pickup_state: "PE", product_code: "18845ABD", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 1000", customer_name: "Carolina", delivery_city: "Recife", delivery_state: 'PE', distance:10)

WorkOrder.create!(pickup_address: "Rua da lua, 87", pickup_city: 'Recife', pickup_state: "PE", product_code: "52785ABD", height:50, width:50, depth:60, weight:150, delivery_address: "Av. Boa viagem, 1000", customer_name: "Caio", delivery_city: "Recife", delivery_state: 'PE', distance:406)

WorkOrder.create!(pickup_address: "Rua torta, 587", pickup_city: 'Recife', pickup_state: "PE", product_code: "82845ABD", height:50, width:50, depth:60, weight:950, delivery_address: "Av. Boa viagem, 1000", customer_name: "Camila", delivery_city: "Recife", delivery_state: 'PE', distance:350)

WorkOrder.create!(pickup_address: "Rua da Mariana Batista, 789", pickup_city: 'Recife', pickup_state: "PE", product_code: "284458BD", height:50, width:50, depth:60, weight:369, delivery_address: "Av. Boa viagem, 800", customer_name: "Marcos", delivery_city: "Recife", delivery_state: 'PE', distance:250)

WorkOrder.create!(pickup_address: "Rua da Menina, 7874", pickup_city: 'Recife', pickup_state: "PE", product_code: "5284SJBD", height:50, width:50, depth:60, weight:80, delivery_address: "Av. Boa viagem, 800", customer_name: "Marcos", delivery_city: "Recife", delivery_state: 'PE', distance:57)

WorkOrder.create!(pickup_address: "Rua da Menina, 7874", pickup_city: 'Recife', pickup_state: "PE", product_code: "5284SSSS", height:50, width:50, depth:60, weight:180, delivery_address: "Av. Boa viagem, 800", customer_name: "Marcos", delivery_city: "Recife", delivery_state: 'PE', distance:30)

WorkOrder.create!(pickup_address: "Rua da Menina, 7874", pickup_city: 'Recife', pickup_state: "PE", product_code: "5284SKKK", height:50, width:50, depth:60, weight:240, delivery_address: "Av. Boa viagem, 800", customer_name: "Marcos", delivery_city: "Recife", delivery_state: 'PE', distance:200)

WorkOrder.create!(pickup_address: "Rua da Menina, 7874", pickup_city: 'Recife', pickup_state: "PE", product_code: "5284SHHH", height:50, width:50, depth:60, weight:100, delivery_address: "Av. Boa viagem, 800", customer_name: "Marcos", delivery_city: "Recife", delivery_state: 'PE', distance:183)


