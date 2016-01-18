# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## 用户分组初始化数据
group_names=%w[Common Editor Admin]
(0..group_names.length-1).each { |i|
  UserGroup.create!(id: i, name: group_names[i])
}


## 权限初始化数据
permission_describes=%w[读小说 写小说 评论 更改章节状态 提升用户等级 删除用户 更改用户组]
(0..permission_describes.length-1).each { |i|
  Permission.create!(id:i, describe: permission_describes[i])
}


## 初始化权限
user_group_own_permissions = [
    [0, 0,	0,	0],	# 普通0级用户可读小说
    [1, 0,	0,	1],	# 普通0级用户可写小说
    [2,	0,	1,	2],	# 普通1级用户可写评论
    [3,	1,	0,	0],	# 主编0级用户可读小说
    [4,	1,	0,	1],	# 主编0级用户可写小说
    [5,	1,	0,	2],	# 主编0级用户可写评论
    [6,	1,	0,	3]	# 主编0级用户可更改用户状态
  ]
user_group_own_permissions.each{|i|
  UserGroupOwnPermission.create!(id:i[0], user_group_id:i[1], user_level:i[2], permission_id:i[3])
}

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
admin_user_group=UserGroup.find_by_name('Admin')
(0..admins.length-1).each{|i|
  user=admins[i]
  admin_user_group.users.create!(id:i, name:user[0], nick_name:user[1], level:user[2], password_digest:user[3])
}