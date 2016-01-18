class Role < ActiveRecord::Base
  belongs_to :novel
  belongs_to :author, class_name: 'User'

  validates :author_id, presence: true
  validates :novel_id, presence: true
  validates_associated :novel
  validates_associated :author
  validates :name, presence: true
  validates :profile, presence: true

end
