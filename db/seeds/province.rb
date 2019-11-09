Indonesia.provinces.each do |province|
	idn_province = IndonesiaProvince.create(province_name: province[:name])
	puts("-----province #{idn_province} created!")
	# puts("-----province #{idn_province} created!")

		cities = Indonesia.regencies(province[:id])
		cities.each do |city|
			idn_city = IndonesiaCity.create(city_name: city[:name], indonesia_province_id: idn_province.id)
			puts("-----city #{idn_city} created!")
			# puts("-----city #{idn_city} created!")

			districts = Indonesia.districts(city[:id])
			districts.each do |district|
				idn_district = IndonesiaDistrict.create(district_name: district[:name], indonesia_city_id: idn_city.id)
				puts("-----district #{idn_district} created!")
				# puts("-----district #{idn_district} created!")

				villages = Indonesia.villages(district[:id])
				villages.each do |village|
					idn_village = IndonesiaVillage.create(village_name: village[:name], indonesia_district_id: idn_district.id)
					puts("-----village #{idn_village} created!")
					# puts("-----village #{idn_village} created!")

				end
			end
		end
end