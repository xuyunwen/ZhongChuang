class Chapter < ActiveRecord::Base
  belongs_to :novel
  belongs_to :author
  belongs_to :cite
end
