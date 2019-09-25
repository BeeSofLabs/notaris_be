# == Schema Information
#
# Table name: users_roles
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role_id    :bigint(8)
#  user_id    :bigint(8)
#
# Indexes
#
#  index_users_roles_on_role_id  (role_id)
#  index_users_roles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#  fk_rails_...  (user_id => users.id)
#

class UsersRole < ApplicationRecord
  belongs_to :users
  belongs_to :roles
end
