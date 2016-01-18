class Permission < ActiveRecord::Base
  has_many :user_group_own_permissions

end
