class Permission < ActiveRecord::Base
  has_many :user_group_own_permissions


  READ_NOVEL=0
  WRITE_NOVEL=1
  COMMENT_NOVEL=2
  CHANGE_NOVEL_STATUS=3
  DELETE_USER=4
  CHANGE_USER_GROUP=5
  CHANGE_USER_LEVEL=6
  CHANGE_CHAPTER_STATUS=7
end
