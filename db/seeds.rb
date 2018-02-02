# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = LensShifter.create(email: 'aparnasinbox@gmail.com', password: 'password', admin: true)
user2 = LensShifter.create(email: 'rourkehealey10@gmail.com', password: 'password', admin: true)
user3 = LensShifter.create(email: 'minamotamedi28@gmail.com', password: 'password', admin: true)
user4 = LensShifter.create(email: 'kathleen.turner.seattle@gmail.com', password: 'password', admin: true)
user5 = LensShifter.create(email: 'valerie.leisten@gmail.com', password: 'password', admin: true)


Profile.create(first_name: 'Aparna', last_name: 'Shrivastava', lens_shifter_id: user1.id )
Profile.create(first_name: 'Rourke', last_name: 'Healey', lens_shifter_id: user2.id )
Profile.create(first_name: 'Mina', last_name: 'Motamedi', lens_shifter_id: user3.id )
Profile.create(first_name: 'Kathleen', last_name: 'Turner', lens_shifter_id: user4.id )
Profile.create(first_name: 'Valerie', last_name: 'Leisten', lens_shifter_id: user5.id )