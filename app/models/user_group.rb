class UserGroup < ActiveRecord::Base
  has_many :users
  has_many :user_group_own_permissions

  validates :name, uniqueness: true, presence: true



  COMMON_USER_GROUP_ID=0
  EDITOR_USER_GROUP_ID=1
  ADMIN_USER_GROUP_ID=2

  def self.common_user_group
    @common_user_group||=UserGroup.find(COMMON_USER_GROUP_ID)
  end

  def self.editor_user_group
    @editor_user_group||=UserGroup.find(EDITOR_USER_GROUP_ID)
  end

  def self.admin_user_group
    @admin_user_group||=UserGroup.find(ADMIN_USER_GROUP_ID)
  end

  def common_user_group?
    id == COMMON_USER_GROUP_ID
  end

  def editor_user_group?
    id == EDITOR_USER_GROUP_ID
  end
  def admin_user_group?
    id == ADMIN_USER_GROUP_ID
  end
end
