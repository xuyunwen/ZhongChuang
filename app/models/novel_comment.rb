class NovelComment < ActiveRecord::Base
  belongs_to :novel
  belongs_to :user
end
