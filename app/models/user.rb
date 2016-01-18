class User < ActiveRecord::Base
  belongs_to :user_group
end
