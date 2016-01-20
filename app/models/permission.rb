class Permission < ActiveRecord::Base
  has_many :user_group_own_permissions


  @@all_permissions=[
      ['READ_NOVEL', '读小说'],
      ['WRITE_NOVEL', '写小说'],
      ['COMMENT_NOVEL', '评论小说'],
      ['CHANGE_NOVEL_STATUS', '修改小说状态'],
      ['CHANGE_CHAPTER_STATUS', '修改章节状态'],
      ['CHANGE_USER_GROUP', '修改用户分组'],
      ['DELETE_USER', '删除用户'],
      ['CHANGE_USER_LEVEL', '修改用户等级'],
      ['ALL_USERS','所有用户']
  ]

  @@all_permissions.length.times do |i|
    eval("#{@@all_permissions[i][0]}=#{i}")
  end

  def self.permissions
    @@all_permissions
  end

  # READ_NOVEL=0  # 读小说
  # WRITE_NOVEL=1  # 写小说
  # COMMENT_NOVEL=2
  # CHANGE_NOVEL_STATUS=3
  # DELETE_USER=4
  # CHANGE_USER_GROUP=5
  # CHANGE_USER_LEVEL=6
  # CHANGE_CHAPTER_STATUS=7


end
