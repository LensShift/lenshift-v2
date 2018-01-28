# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = LensShifter.create(email: 'weihsi.hu@gmail.com', password: 'password', admin: true)

LensShifterProfile.create(first_name: 'WeiHsi', last_name: 'Hu', lens_shifter_id: user1.id, location: 'UK' )