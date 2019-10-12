50.times do |n|
	user = User.create!(
		approved: true,
		dob: 20.years.ago,
		email: Faker::Internet.email,
		identity_image: Faker::IDNumber.brazilian_citizen_number,
		identity_number: Faker::IDNumber.brazilian_citizen_number,
		name: Faker::Name.unique.name,
		password: "password#{n}",
		password_confirmation: "password#{n}",
		phone: Faker::PhoneNumber.phone_number,
	)
	user.add_role(:notaris) if user
	puts "#{user}.. created" if user
end
