class Api::V1::CollateralsController < ApplicationController

    def show
        
        if(params[:user_id].present?)
            user = User.find(params[:user_id])
        else
            user = current_user
        end

        
        if user.present?
            return json_response({
                message: "Collateral listed!", 
                immovable_collaterals: user.immovable_collaterals,
                movable_collaterals: user.movable_collaterals})
            
        end

        json_response({message: "Invalid service", collaterals: {}}, :not_found)
    end

    def create

        # collateral_params = params.reject{|k,v| k == "collateral_type"}
        if params[:collateral_type] == 'movable'
            if params.present?
                collateral_params = movable_collateral_params
                collateral_params[:user_id] = current_user.id
                if MovableCollateral.save(collateral_params)
                    return json_response({message: "collateral created!"}, :created)
                end
            end
        elsif params[:collateral_type] == 'immovable'
            if params.present?
                collateral_params = immovable_collateral_params
                collateral_params[:user_id] = current_user.id
                if ImmovableCollateral.save(collateral_params)
                    return json_response({message: "collateral created!"}, :created)
                end
            end
        end

        json_response({message: "Invalid service"}, :unprocessable_entity)
    end

    def destroy
        
        if params[:collateral_type] == 'movable'
            if params.present? && valid_collateral_owner(params)
                if MovableCollateral.delete(params[:id])
                    return json_response({message: "collateral deleted!"})
                end
            end
        elsif params[:collateral_type] == 'immovable'
            if params.present?
                if ImovableCollateral.delete(params[:id])
                    return json_response({message: "collateral deleted!"})
                end
            end
        end

        json_response({message: "Invalid service"}, :unprocessable_entity)
    end

    private

    def valid_collateral_owner(params)
        case params[:collateral_type]
        when "movable"
            result = MovableCollateral.where(id: params[:id], user_id: current_user.id)
        when "immovable"
            result = ImmovableCollateral.where(id: params[:id], user_id: current_user.id)
        end

        result.present?
    end

    def movable_collateral_params
        params.permit(
            :proof_of_ownership,
            :signed,
            :owner,
            :no_evidence,
            :name_representative,
            :publication_date,
            :machine_number,
            :chassis_number,
            :brand,
            :classification,
            :serial_number,
            :collateral_value,
            :binding_value,
            :color
        )
    end

    def immovable_collateral_params
        params.permit(
            :proof_of_ownership,
            :collateral_value,
            :signed,
            :owner,
            :name_representative,
            :certificate_number,
            :publication_date,
            :province,
            :city,
            :district,
            :village,
            :street,
            :land_area,
            :letter_of_measurement,
            :gs_su_date,
            :no_land_identity,
            :letter_of_pbbtax,
            :nop,
            :binding_value
        )
    end
end