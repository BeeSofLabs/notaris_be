class UserSeed
		ROLES = %i(notaris debitur kreditur collateral_owner)
		def seed_users
			ROLES.each do |role|
				50.times do
					user = User.create!(
						approved: true,
						dob: 20.years.ago,
						email: Faker::Internet.email,
						identity_image: Faker::IDNumber.brazilian_citizen_number,
						identity_number: Faker::IDNumber.brazilian_citizen_number,
						name: Faker::Name.unique.name,
						password: "password",
						password_confirmation: "password",
						phone: Faker::PhoneNumber.phone_number,
					)
					user.add_role(role) if user
					user.has_role?(:notaris) ? user.notary_services.create!(notary_services) : nil 
					puts "user #{user.email} with role #{role} created.." if user
				end
				puts "end of seed #{role}========================================================================="
			end
		end

		def seed_admin
			user = User.create!(
				approved: true,
				dob: 20.years.ago,
				email: "super_admin@email.com",
				identity_image: Faker::IDNumber.brazilian_citizen_number,
				identity_number: Faker::IDNumber.brazilian_citizen_number,
				name: "super_admin",
				password: "SuperpPassword",
				password_confirmation: "SuperpPassword",
				phone: Faker::PhoneNumber.phone_number,
			)
			user.add_role(:admin) if user
			puts "user #{user.email} with role admin created.." if user
			puts "end of seed admin ========================================================================="
		end

		def seed_bpn
			user = User.create!(
				approved: true,
				dob: 20.years.ago,
				email: "bpnri@email.gov",
				identity_image: Faker::IDNumber.brazilian_citizen_number,
				identity_number: Faker::IDNumber.brazilian_citizen_number,
				name: Faker::Name.unique.name,
				password: "password",
				password_confirmation: "password",
				phone: Faker::PhoneNumber.phone_number,
			)
			user.add_role(:bpn) if user
			puts "user #{user.email} with role bpn created.." if user
			puts "end of seed bpn========================================================================="
		end

		def notary_services
			[
				{
					price: rand(100_000..200_000),
					service_type: "fidusia"
				},
				{
					price: rand(200_000..300_000),
					service_type: "skmht"
				},
				{
					price: rand(300_000..400_000),
					service_type: "apht"
				},
				{
					price: rand(400_000..500_000),
					service_type: "skmht and apht"
				}
			]
		end
end
# run
UserSeed.new().seed_users
UserSeed.new().seed_admin
UserSeed.new().seed_bpn