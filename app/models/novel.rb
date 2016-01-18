class Novel < ActiveRecord::Base
  belongs_to :category
  has_many :chapters
  has_many :novel_comments
  has_many :roles

  validates :name, presence: true
  validates :category_id, presence: true
  validates_associated :category

end
