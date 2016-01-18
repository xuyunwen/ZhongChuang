class UserGroupOwnPermission < ActiveRecord::Base
  belongs_to :user_group
  belongs_to :permission

  validates_associated :user_group
  validates_associated :permission

  validates :user_group_id, presence: true
  validates :permission_id, presence: true
  validates :user_level, presence: true, default:0

end
