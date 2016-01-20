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
  UserGroup.create!(id: i[0], name: i[1])
}

## 权限初始化数据
permissions=[
    [Permission::READ_NOVEL, '读小说'],
    [Permission::WRITE_NOVEL, '写小说'],
    [Permission::COMMENT_NOVEL, '评论小说'],
    [Permission::CHANGE_NOVEL_STATUS, '修改小说状态'],
    [Permission::CHANGE_CHAPTER_STATUS, '修改章节状态'],
    [Permission::CHANGE_USER_GROUP, '修改用户分组'],
    [Permission::DELETE_USER, '删除用户'],
    [Permission::CHANGE_USER_LEVEL, '修改用户等级'],
  ]
permissions.each{|i|
  Permission.create!(id:i[0], describe: i[1])
}


## 初始化权限
user_group_own_permissions = [
    [ UserGroup::COMMON_USER_GROUP_ID,	0,	Permission::READ_NOVEL          ],	# 普通0级用户可读小说
    [ UserGroup::COMMON_USER_GROUP_ID,	0,	Permission::WRITE_NOVEL         ],	# 普通0级用户可写小说
    [ UserGroup::COMMON_USER_GROUP_ID,	1,	Permission::COMMENT_NOVEL       ],	# 普通1级用户可写评论
    [	UserGroup::EDITOR_USER_GROUP_ID,	0,	Permission::READ_NOVEL          ],	# 主编0级用户可读小说
    [	UserGroup::EDITOR_USER_GROUP_ID,	0,	Permission::WRITE_NOVEL         ],	# 主编0级用户可写小说
    [	UserGroup::EDITOR_USER_GROUP_ID,	0,	Permission::COMMENT_NOVEL       ],	# 主编0级用户可写评论
    [	UserGroup::EDITOR_USER_GROUP_ID,	0,	Permission::CHANGE_NOVEL_STATUS],	# 主编0级用户可更改用户状态
    [	UserGroup::EDITOR_USER_GROUP_ID,	0,	Permission::CHANGE_CHAPTER_STATUS],	# 主编0级用户可更改用户状态
    # 管理员拥有所有权限
    [	UserGroup::ADMIN_USER_GROUP_ID,	0,	Permission::READ_NOVEL          ],
    [	UserGroup::ADMIN_USER_GROUP_ID,	0,	Permission::WRITE_NOVEL         ],
    [	UserGroup::ADMIN_USER_GROUP_ID,	0,	Permission::COMMENT_NOVEL       ],
    [	UserGroup::ADMIN_USER_GROUP_ID,	0,	Permission::CHANGE_NOVEL_STATUS],
    [	UserGroup::ADMIN_USER_GROUP_ID,	0,	Permission::CHANGE_CHAPTER_STATUS],
    [	UserGroup::ADMIN_USER_GROUP_ID,	0,	Permission::DELETE_USER],

  ]
(0..user_group_own_permissions.length-1).each{|i|
  ugop=user_group_own_permissions[i]
  UserGroupOwnPermission.create!(id:i, user_group_id:ugop[0], user_level:ugop[1], permission_id:ugop[2])
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
admin_user_group=UserGroup.find(UserGroup::ADMIN_USER_GROUP_ID)
(0..admins.length-1).each{|i|
  user=admins[i]
  password_digest=User.digest user[3]
  admin_user_group.users.create!(id:i, name:user[0], nick_name:user[1],
                                 level:user[2], password_digest: password_digest)
}




############################ 下面是测试数据 ################

## 创建

## 添加小说 <左耳>

zuo_dir='test_data/novels/zuo'

novel=Novel.new
novel.name='左耳'
novel.description='一部激荡的青春热血小说'
novel.category_id=Category.find_by_name('言情').id
novel.status=Novel::Status::WORKING
novel.save

Dir.entries(zuo_dir).each do |sub|
  file="#{zuo_dir}/#{sub}"
  if File.file?(file) and file.end_with?('.txt')
    chapter=Chapter.new
    chapter.number=sub[/\d+/]
   # puts "开始创建章节#{file}"
    chapter.content=File.read(file)
    chapter.author_id=User.first.id
    chapter.novel_id=novel.id
    chapter.status=Chapter::Status::LOCK
    chapter.title=sub[/(?<=_).*(?=.txt)/]
    chapter.draft=false
    chapter.save
  end
end


10.times{ |i|
  novel=Novel.new
  novel.name="左耳#{i}"
  novel.description='一部激荡的青春热血小说'
  novel.category_id=Category.find_by_name('言情').id
  novel.status=Novel::Status::WORKING
  novel.save

}

## 添加小说评论

