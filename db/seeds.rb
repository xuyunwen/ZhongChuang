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
# permissions=[
#     [Permission::READ_NOVEL, '读小说'],
#     [Permission::WRITE_NOVEL, '写小说'],
#     [Permission::COMMENT_NOVEL, '评论小说'],
#     [Permission::CHANGE_NOVEL_STATUS, '修改小说状态'],
#     [Permission::CHANGE_CHAPTER_STATUS, '修改章节状态'],
#     [Permission::CHANGE_USER_GROUP, '修改用户分组'],
#     [Permission::DELETE_USER, '删除用户'],
#     [Permission::CHANGE_USER_LEVEL, '修改用户等级'],
#   ]
# permissions.each{|i|
#   Permission.create!(id:i[0], describe: i[1])
# }
Permission.permissions.length.times do |i|
   Permission.create!(id:i, describe: Permission.permissions[i][1])
  # eval("#{permissions[i][0]}=#{i}")
end

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
(0..admins.length-1).each{|i|
  user=admins[i]
  password_digest=User.digest user[3]
  UserGroup.admin_user_group.users.create!(id:i, user_name:user[0], nick_name:user[1],
                                 level:user[2], password_digest: password_digest)
}




############################ 下面是测试数据 ################

########### 帮助方法
# 从上传的文件流中获取编码的图片数据
def get_pic_str(stream)
  return nil unless stream
  data=stream.read
  pic_str='data:image/png;base64,'
  pic_str << Base64.encode64(data)
  return pic_str
end

def rand_sentences(min, max)
  Faker::Lorem.paragraph(min, false, max-min)
end

def rand_paragraph(min, max)
  ps=''
  num=(min..max).to_a.sample
  num.times{|n|
    ps << rand_sentences(1, 30) << "\n"
  }
  ps
end
########## 帮助方法结束

########## 设置开始

production=Rails.env.production?
generate_img= production ? true : false
common_user_number= production ? 100 : 10
editor_user_number= production ? 5 : 5
novel_number= production ? 100 : 50
chapter_number= production ? 1000 : 100
novel_comment_number= production ? 1000 : 200
chapter_comment_number= production ? 3000 : 300
chapter_vote_number= production ? 3000 : 500
role_number= production ? 10 : 10

########## 设置结束

## 创建普通用户
common_user_number.times do |n|
  user_name  = Faker::Internet.user_name
  nick_name = Faker::Name.name
  level = Faker::Number.between(0,10)
  password = '123456'
  header= generate_img ? get_pic_str(open(Faker::Avatar.image)) : nil
  UserGroup.common_user_group.users.create(
                                       user_name: user_name,
                                       nick_name: nick_name,
                                       level: level,
                                       password: password,
                                       password_confirmation: password,
                                       header: header
  )
end

## 创建主编
editor_user_number.times do |n|
  user_name  = Faker::Internet.user_name
  nick_name = Faker::Name.name
  level = Faker::Number.between(0,10)
  password = '123456'
  header= generate_img ? get_pic_str(open(Faker::Avatar.image)) : nil
  UserGroup.editor_user_group.users.create(
      user_name: user_name,
      nick_name: nick_name,
      level: level,
      password: password,
      password_confirmation: password,
      header: header
  )
end


## 创建小说
category_ids=Category.all.map{|m| m.id}
novel_number.times{|n|
  name=Faker::Book.title
  description=Faker::Lorem.paragraph
  category_id=category_ids.sample
  cover=generate_img ? get_pic_str(open(Faker::Avatar.image)) : nil
  status=[0,1].sample
  Novel.create(name: name,
               description: description,
               category_id: category_id,
               cover: cover,
               status: status
  )
}

## 添加小说评论
novel_ids=Novel.all.map{|m| m.id}
user_ids=User.all.map{|m| m.id}
novel_comment_number.times{ |n|
  novel_id=novel_ids.sample
  user_id=user_ids.sample
  content=rand_sentences(3,15)
  NovelComment.create(novel_id: novel_id,
                      user_id: user_id,
                      content: content
  )
}

## 添加小说章节
chapter_number.times{|n|
  novel_id=novel_ids.sample
  number=Novel.find(novel_id).active_chapter_num
  content=rand_paragraph(10, 20)
  author_id=user_ids.sample
  status=Chapter::Status::LOCK
  title=Faker::Book.title
  summary=Faker::Lorem.sentence(3)
  sss=Faker::Lorem::sentence(3)
  fs=Faker::Lorem::sentence(3)
  draft=false
  Chapter.create(
             novel_id: novel_id,
             number: number,
             content: content,
             author_id: author_id,
             status: status,
             title: title,
             summary: summary,
             subsequent_summary: sss,
             foreshadowing: fs,
             draft: false
  )
}

## 添加章节评论
chapter_ids=Chapter.all.map{|m| m.id}
user_ids=User.all.map{|m| m.id}
chapter_comment_number.times{ |n|
  chapter_id=chapter_ids.sample
  user_id=user_ids.sample
  content=rand_sentences(3,15)
  ChapterComment.create(chapter_id: chapter_id,
                      user_id: user_id,
                      content: content
  )
}

## 添加章节投票
chapter_vote_number.times{|n|
  chapter_id=chapter_ids.sample
  User.all.sample.vote_chapter(chapter_id, [true,false].sample)
}

## 添加小说角色
role_number.times{|n|
  novel_id=novel_ids.sample
  author=user_ids.sample
  name=Faker::Name.name
  profile=rand_sentences(3,10)
  Role.create(
          novel_id: novel_id,
          author_id: author,
          name: name,
          profile: profile
  )
}

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


