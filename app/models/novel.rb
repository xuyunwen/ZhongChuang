class Novel < ActiveRecord::Base
  belongs_to :category
  has_many :chapters
  has_many :novel_comments
  has_many :roles

  validates :name, presence: true
  validates :category_id, presence: true
  validates_associated :category

  class Status
    WORKING=0
    FINISHED=1
  end
  def working?
    status == Status.WORKING
  end
  def finished?
    status == Status.FINISHED
  end

  def self.working_novels
    Novel.all.where(status: Status::WORKING)
  end

  def all_finished_chapters
    self.chapters.where(status: Chapter::Status::LOCK)
  end
end
