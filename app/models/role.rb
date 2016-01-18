class Role < ActiveRecord::Base
  belongs_to :novel
  belongs_to :author
end
