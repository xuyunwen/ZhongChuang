class Permission < ActiveRecord::Base
  has_many :user_group_own_permissions


  @@all_permissions=[

      %w(VIEW_USERS 查看所有用户),

      %w(MANAGE_USER 管理用户),

      %w(MANAGE_CATEGORY 管理分类),

      %w(MANAGE_NOVEL 管理小说),

      %w(MANAGE_CHAPTER 管理章节),

      %w(COMMENT_NOVEL 评论小说),

      %w(COMMENT_CHAPTER 评论章节),

      %w(VOTE_CHAPTER 章节投票),

      %w(MANAGE_ROLE 管理角色),

      %w(WRITE_NOVEL 写章节),
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
