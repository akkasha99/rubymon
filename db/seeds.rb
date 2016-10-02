# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "----------Deleting Monsters Types from types table----------"
Type.destroy_all
puts "----------All Monsters have been deleted----------"

puts "----------Seeding Monsters Types in types table----------"
%w(water earth electric wind fire).each do |type|
  Type.create(:name => type)
end
water_monster = Type.find_by_name('water')
earth_monster = Type.find_by_name('earth')
electric_monster = Type.find_by_name('electric')
wind_monster = Type.find_by_name('wind')
fire_monster = Type.find_by_name('fire')

water_monster.update_attributes(:strong_against => fire_monster.id, :weak_against => earth_monster.id)
earth_monster.update_attributes(:strong_against => water_monster.id, :weak_against => electric_monster.id)
electric_monster.update_attributes(:strong_against => earth_monster.id, :weak_against => wind_monster.id)
wind_monster.update_attributes(:strong_against => electric_monster.id, :weak_against => fire_monster.id)
fire_monster.update_attributes(:strong_against => wind_monster.id, :weak_against => water_monster.id)

puts "-----Monsters types have been seeded-----"
