# == Schema Information
#
# Table name: menu_home_previews
#
#  id         :bigint(8)        not null, primary key
#  label      :string
#  link_url   :string
#  menu_image :string
#  position   :integer          default(0)
#

class MenuHomePreview < ApplicationRecord
end
