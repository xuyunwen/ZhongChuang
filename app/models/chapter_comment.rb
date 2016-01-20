class ChapterComment < ActiveRecord::Base
  belongs_to :chapter
  belongs_to :user

  validates :chapter_id, presence: true
  validates :user_id, presence: true
  validates_associated :chapter
  validates_associated :user

  validates :content, presence: true #, length: { minimum: 15}


end
