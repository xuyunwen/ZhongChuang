# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


## 用户分组初始化数据
user_groups=[
    [UserGroup::COMMON_USER_GROUP_ID, 'Common'],
    [UserGroup::EDITOR_USER_GROUP_ID, 'Editor'],
    [UserGroup::ADMIN_USER_GROUP_ID, 'Admin'],
  ]
user_groups.each{|i|
  begin
  UserGroup.create!(id: i[0], name: i[1])
  rescue
# ignored
  end
}

## 权限初始化数据
Permission.permissions.length.times do |i|
  begin
  Permission.create!(id:i, describe: Permission.permissions[i][1])
   rescue
# ignored
  end
  # eval("#{permissions[i][0]}=#{i}")
end

## 初始化权限
user_group_own_permissions = [
    [ UserGroup::COMMON_USER_GROUP_ID,	0,	Permission::COMMENT_NOVELS         ],
    [ UserGroup::COMMON_USER_GROUP_ID,	0,	Permission::COMMENT_CHAPTERS        ],
    [ UserGroup::COMMON_USER_GROUP_ID,	1,	Permission::VOTE_CHAPTERS      ],
    [ UserGroup::COMMON_USER_GROUP_ID,	1,	Permission::MANAGE_ROLES      ],
    [ UserGroup::COMMON_USER_GROUP_ID,	1,	Permission::WRITE_CHAPTERS       ],

    # 主编的权限
    [ UserGroup::EDITOR_USER_GROUP_ID,	0,	Permission::COMMENT_NOVELS          ],
    [ UserGroup::EDITOR_USER_GROUP_ID,	0,	Permission::COMMENT_CHAPTERS         ],
    [ UserGroup::EDITOR_USER_GROUP_ID,	1,	Permission::VOTE_CHAPTERS       ],
    [ UserGroup::EDITOR_USER_GROUP_ID,	1,	Permission::MANAGE_ROLES       ],
    [ UserGroup::EDITOR_USER_GROUP_ID,	1,	Permission::WRITE_CHAPTERS       ],


  ]
(0..user_group_own_permissions.length-1).each{|i|
  ugop=user_group_own_permissions[i]
  UserGroupOwnPermission.create!(user_group_id:ugop[0], user_level:ugop[1], permission_id:ugop[2])
}
# 管理员拥有所有权限
Permission.permissions.length.times do |i|
    UserGroupOwnPermission.create!(user_group_id:UserGroup::ADMIN_USER_GROUP_ID,
                                   user_level: 0, permission_id:i)
end

## 小说分类
categories = %w[玄幻 武侠 都市 仙侠 历史 言情 古典]
(0..categories.length-1).each{|i|
  Category.create!(id:i, name:categories[i])
}


## 创建管理员用户
admins=[
    ['chendacai', '陈大才', 3, 'chendacai'],
    ['liujinghang', ' 刘京杭', 0, 'liujinghang'],
    ['lishunxi', '李顺喜', 0, 'lishunxi'],
  ]
(0..admins.length-1).each{|i|
  user=admins[i]
  password_digest=User.digest user[3]
  UserGroup.admin_user_group.users.create!(id:i, user_name:user[0], nick_name:user[1],
                                 level:user[2], password_digest: password_digest)
}



