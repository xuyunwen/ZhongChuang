class UserGroup < ActiveRecord::Base
  has_many :users
  has_many :user_group_own_permissions

  validates :name, uniqueness: true, presence: true


end
