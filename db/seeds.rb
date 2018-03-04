# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = LensShifter.create(email: "kdmattson11@outlook.com", password: "testingtesting", admin: false)

Profile.create(first_name: "Kay", last_name: "Mattson", lens_shifter_id: user1.id )

user2 = LensShifter.create(email: "jessy.cawley@gmail.com", password: "testingtesting", admin: false)

Profile.create(first_name: "Jessica", last_name: "Cawley", lens_shifter_id: user2.id )

user3 = LensShifter.create(email: "syl2145@columbia.edu", password: "testingtesting", admin: false)

Profile.create(first_name: "Shamira", last_name: "", lens_shifter_id: user3.id )

user4 = LensShifter.create(email: "marah@koeberle.me", password: "testingtesting", admin: false)

Profile.create(first_name: "Marah", last_name: "Köberle", lens_shifter_id: user4.id )

user5 = LensShifter.create(email: "aidah.binale@gmail.com", password: "testingtesting", admin: false)

Profile.create(first_name: "Aidah", last_name: "binale", lens_shifter_id: user5.id )

user6 = LensShifter.create(email: "nickdmoses@gmail.com", password: "testingtesting", admin: false)

Profile.create(first_name: "Nick", last_name: "Moses", lens_shifter_id: user6.id )

user7 = LensShifter.create(email: "adele.charbonneau@hotmail.fr", password: "testingtesting", admin: false)

Profile.create(first_name: "Adele", last_name: "Charbonneau", lens_shifter_id: user7.id )

user8 = LensShifter.create(email: "vyasm@oregonstate.edu", password: "testingtesting", admin: false)

Profile.create(first_name: "Manasi", last_name: "Vyas", lens_shifter_id: user8.id )

user9 = LensShifter.create(email: "rbrahmbhatt6@gmail.com", password: "testingtesting", admin: false)

Profile.create(first_name: "Rahul", last_name: "Brahmbhatt", lens_shifter_id: user9.id )

user10 = LensShifter.create(email: "abeckett13@gmail.com", password: "testingtesting", admin: false)

Profile.create(first_name: "Ashley", last_name: "Beckett", lens_shifter_id: user10.id )

user11 = LensShifter.create(email: "louisslade@gmail.com", password: "testingtesting", admin: false)

Profile.create(first_name: "Louis", last_name: "", lens_shifter_id: user11.id )

user12 = LensShifter.create(email: "kbbolch@gmail.com", password: "testingtesting", admin: false)

Profile.create(first_name: "Kimberly", last_name: "Bolch", lens_shifter_id: user12.id )

user13 = LensShifter.create(email: "beatrice.linda@gmail.com", password: "testingtesting", admin: false)

Profile.create(first_name: "Linda", last_name: "Beatrice", lens_shifter_id: user13.id )

user14 = LensShifter.create(email: "taracake@gmail.com", password: "testingtesting", admin: false)

Profile.create(first_name: "Tara", last_name: "", lens_shifter_id: user14.id )

user15 = LensShifter.create(email: "michaelanne.butler@gmail.com", password: "testingtesting", admin: false)

Profile.create(first_name: "Michaelangelo", last_name: "Butler", lens_shifter_id: user15.id )

user16 = LensShifter.create(email: "shruthi.vijayakumar@gmail.com", password: "testingtesting", admin: false)

Profile.create(first_name: "Shruthi", last_name: "Vijayakumar", lens_shifter_id: user16.id )

user17 = LensShifter.create(email: "scrook0717@gmail.com", password: "testingtesting", admin: false)

Profile.create(first_name: "Scott", last_name: "crook", lens_shifter_id: user17.id )

user18 = LensShifter.create(email: "stephanie.walstrom@gmail.com", password: "testingtesting", admin: false)

Profile.create(first_name: "Stephanie", last_name: "Walstrom", lens_shifter_id: user18.id )

