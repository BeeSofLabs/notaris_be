# == Schema Information
#
# Table name: notaris_orders
#
#  id                     :bigint(8)        not null, primary key
#  binding_value          :string
#  brand_fidusia          :string
#  certificate_number     :string
#  chassis_number_fidusia :string
#  city                   :string
#  classification_fidusia :string
#  collateral_value       :string
#  color_fidusia          :string
#  district               :string
#  land_area              :string
#  letter_of_measurement  :string
#  letter_of_pbbtax       :string
#  machine_number_fidusia :string
#  name_representative    :string
#  no_evidence_fidusia    :string
#  no_land_identity       :string
#  nop                    :string
#  owner                  :string
#  proof_of_ownership     :string
#  province               :string
#  publication_date       :string
#  seri_fidusia           :string
#  street                 :string
#  tgl_gs_su              :string
#  village                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint(8)
#
# Indexes
#
#  index_notaris_orders_on_city      (city)
#  index_notaris_orders_on_district  (district)
#  index_notaris_orders_on_province  (province)
#  index_notaris_orders_on_user_id   (user_id)
#  index_notaris_orders_on_village   (village)
#

class NotarisOrder < ApplicationRecord

    def pullAllNotarisOrder
    end
end
