class User < ActiveRecord::Base
  belongs_to :user_group
  has_many :chapters, class_name: 'Chapter', foreign_key: :author_id
  has_many :chapter_comments
  has_many :chapter_votes
  has_many :novel_comments
  has_many :roles

  validates_associated :user_group
  validates :user_group_id, presence: true
  validates :user_name, uniqueness: true, presence: true,
            format:{with: /\A[a-zA-Z0-9_@$.]+\z/i, message: I18n.t('my.errors.signup.validations.user_name')}
  validates :nick_name, presence: true
  validates :user_group_id, presence: true
  validates :level, presence: true, numericality: {greater_than: 0}
  validates :password_digest, presence: true

  attr_accessor :remember_token #, :activation_token, :reset_token

  # 密码
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  ######### 类方法 ############

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 返回随机令牌
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  ############ 实例方法 ###########

  def vote_chapter(chapter_id, positive)
    am=chapter_votes.where(chapter_id: chapter_id)
    if am.any?
       if am.first.rate == (positive ? level : -level)
         return false
       else
         am.first.destroy
       end
    else
      ChapterVote.create(
          chapter_id: chapter_id,
          user_id: id,
          rate: (positive ? level: -level)
      )
    end
  end

  def permissions
    self.user_group.user_group_own_permissions
        .where('user_level <= ?', self.level)
  end

  # 检查用户是否拥有某权限
  def has_permission?(permission_id)
    self.user_group.user_group_own_permissions
        .where('user_level <= ? and permission_id = ?', self.level, permission_id).any?
  end

  # 在数据库中记住我
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 忘记我
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end


  private


end
