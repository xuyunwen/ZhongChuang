class NovelComment < ActiveRecord::Base
  belongs_to :novel
  belongs_to :user

  default_scope { order(:created_at) }

  validates :novel_id, presence: true
  validates :user_id, presence: true
  validates_associated :novel
  validates_associated :user
  validates :content, presence: true #, length: { minimum: 15}

end
