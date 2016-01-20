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
  def self.finished_novels
    Novel.all.where(status: Status::FINISHED)
  end

  # 获取所有定版章节
  def all_finished_chapters
    self.chapters.where(status: Chapter::Status::LOCK).order(:number)
  end

  # 获取活跃章节号
  def active_chapter_num
    last=all_finished_chapters.last
    last.nil?? 1 : (last.number + 1)
  end
end
