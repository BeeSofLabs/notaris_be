class Api::V1::IndonesiasController < ApplicationController
	skip_before_action :authorize_request
	def villages
		response = {
			villages: IndonesiaVillage.where(indonesia_district_id: params[:district_id])
		}
		json_response(response)
	end

	def districts
		response = {
			districts: IndonesiaDistrict.where(indonesia_city_id: params[:city_id])
		}
		json_response(response)
	end

	def cities
		response = {
			cities: IndonesiaCity.where(indonesia_province_id: params[:province_id])
		}
		json_response(response)
	end

	def provinces
		response = {
			provinces: IndonesiaProvince.all
		}
		json_response(response)
	end

end
