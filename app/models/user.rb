class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

  has_many :opinions, dependent: :destroy
  has_one_attached :photo, dependent: :destroy
  has_one_attached :cover, dependent: :destroy

  has_many :active_relationships,
           class_name: 'Relationship',
           foreign_key: 'follower_id',
           dependent: :destroy

  has_many :following,
           through: :active_relationships,
           source: :followed

  has_many :passive_relationships,
           class_name: 'Relationship',
           foreign_key: 'followed_id',
           dependent: :destroy

  has_many :followers,
           through: :passive_relationships,
           source: :follower

  validates :username, presence: true, length: { maximum: 50, minimum: 4 }

  validates :fullname, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/.freeze

  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_insensitive: true }

  validates :password, presence: true, length: { minimum: 8 }

  validates :password_confirmation, presence: true, length: { minimum: 8 }

  def not_following_users
    User.all.where.not(id: following.select(:id)).where.not(id: id).order(created_at: :desc).take(3)
  end

  def feed
    following_ids = 'SELECT followed_id FROM relationships
                      WHERE follower_id = :user_id'
    Opinion.where("user_id IN (#{following_ids})
                  OR user_id = :user_id", user_id: id)
  end

  def follow(user)
    following << user
  end

  def unfollow(user)
    following.delete(user)
  end

  def following?(user)
    following.include?(user)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name # assuming the user model has a name
      # user.photo = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      # if (data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info'])
      #   user.email = data['email'] if user.email.blank?
      if (data = session['devise.github_data'] && session['devise.github_data']['extra']['raw_info'])
        user.email = data['email'] if user.email.blank?
      end
    end
  end
end

# def self.from_omniauth(auth)
#   user = User.find_by(email: auth.info.email)
#   if user
#     user.provider = auth.provider
#     user.uid = auth.uid
#     user.save
#   else
#     user = User.where(provider: auth.provider, uid: auth.uid).first_or_create do |uzer|
#       uzer.email = auth.info.email
#       uzer.password = Devise.friendly_token[0, 20]
#       uzer.username = auth.info.name
#       uzer.save
#     end
#   end
#   user
# end

# end
