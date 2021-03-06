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


    def self.names
      @names||=%w(连载中 已完结)
    end

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


  # 获取所有活跃章节
  def all_active_chapters
    self.chapters.where(status: Chapter::Status::ACTIVE).order(:number)
  end

  # 获取活跃章节号
  def active_chapter_num
    last=all_finished_chapters.last
    last.nil?? 1 : (last.number + 1)
  end

  # 获取所有概要
  def all_summary
    all_finished_chapters.reorder('number desc').select(:number, :title, :summary)
  end

  # 获取所有伏笔
  def all_foreshadowing
    all_finished_chapters.reorder('number desc').select(:number, :title, :foreshadowing)
  end

  def new_chapter_num(user)
    last=all_finished_chapters.last
    my_active_chapter_num=chapters.where(author_id: user.id).order(:number).last
    if my_active_chapter_num.nil?
      last.nil?? 1 : (last.number + 1)
    elsif last.nil?
      my_active_chapter_num.number + 1
    elsif last.number > my_active_chapter_num.number
      last.number + 1
    else
      my_active_chapter_num.number + 1
    end
  end
end
