class User < ActiveRecord::Base
  belongs_to :user_group
  has_many :chapters
  has_many :chapter_comments
  has_many :chapter_votes
  has_many :novel_comments
  has_many :roles

  validates_associated :user_group
  validates :user_group_id, presence: true
  validates :name, uniqueness: true, presence: true,
            format:{with: /\A[a-zA-Z0-9_@$.]+\z/i, message:'用户名请使用字母、数字、_、@、$、.。'}
  validates :nick_name, presence: true
  validates :user_group_id, presence: true
  validates :level, presence: true
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

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # # Activates an account.
  # def activate
  #   update_attribute(:activated,    true)
  #   update_attribute(:activated_at, Time.zone.now)
  # end

  # # Sends activation email.
  # def send_activation_email
  #   UserMailer.account_activation(self).deliver_now
  # end

  # # Sets the password reset attributes.
  # def create_reset_digest
  #   self.reset_token = User.new_token
  #   update_attribute(:reset_digest, User.digest(reset_token))
  #   update_attribute(:reset_sent_at, Time.zone.now)
  # end

  # # Sends password reset email.
  # def send_password_reset_email
  #   UserMailer.password_reset(self).deliver_now
  # end

  # # Returns true if a password reset has expired.
  # def password_reset_expired?
  #   reset_sent_at < 2.hours.ago
  # end

  private

  # # Converts email to all lower-case.
  # def downcase_email
  #   self.email = email.downcase
  # end
  #
  # # Creates and assigns the activation token and digest.
  # def create_activation_digest
  #   self.activation_token  = User.new_token
  #   self.activation_digest = User.digest(activation_token)
  # end

end
