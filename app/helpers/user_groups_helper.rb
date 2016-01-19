module UserGroupsHelper

  def common_user_group
    @common_user_group||=UserGroup.find_by_name 'Common'
  end
end
