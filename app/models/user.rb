class User < ActiveRecord::Base
  belongs_to :user_group
  has_many :chapters
  has_many :chapter_comments
  has_many :chapter_votes
  has_many :novel_comments
  has_many :roles

  validates_associated :user_group

  validates :user_group_id, presence: true

  validates :name, uniqueness: true, presence: true
  validates :nick_name, presence: true
  validates :user_group_id, presence: true
  validates :level, presence: true
  validates :password_digest, presence: true

end
