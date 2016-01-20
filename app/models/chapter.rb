class Chapter < ActiveRecord::Base
  belongs_to :novel
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  belongs_to :cite, class_name: 'Chapter'
  has_many :followings, class_name: 'Chapter', foreign_key: :cite_id

  has_many :chapter_comments
  has_many :chapter_votes

  validates_associated :novel
  validates_associated :author
# validates_associated :cite

  validates :author_id, presence: true
  validates :novel_id, presence: true
  validates :number, presence: true
  validates :status, presence: true
  validates :title, presence: true
  validates :content, presence: true

  default_scope { order(:number) }

  class Status
    ACTIVE=1
    LOCK=2
    TRASH=3

    def self.names
      @names||=%w(活跃章节 定稿章节 废弃章节)
    end
  end

  def full_title
    "第 #{number} 章 #{title}"
  end


end
