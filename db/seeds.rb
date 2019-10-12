# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Role.all.blank?
puts ".. #{Role.all.blank?}"
Role.create(
	[
		{name: "notaris"},
		{name: "debitur"},
		{name: "kreditur"},
		{name: "bpn"},
		{name: "collateral_owner"},
		{name: "admin"}
	]
)
end