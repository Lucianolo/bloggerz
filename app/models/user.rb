require 'random_word_generator'
class User < ActiveRecord::Base
  
  acts_as_voter
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
         
  mount_uploader :avatar, AvatarUploader
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true,
                            uniqueness: true,
                            format: {
                              with: /\A[a-zA-Z0-9_-]*\z/,
                              message: "Must be formatted correctly."
                            }
  
  has_many :statuses
  has_many :user_friendships
  has_many :friends, through: :user_friendships 
  has_many :comments, dependent: :destroy
  
  #has_many :friends, -> { where(user_friendships: {status: 'accepted'}).order('first_name DESC') }, :through => :user_friendships
  
  has_many :books
  
  #after_create :send_welcome_mail
         
  
  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        first_name = auth.info.name.partition(" ").first
        medium_name = auth.info.name.partition(" ").last
        last_name = medium_name.partition(" ").last
        if last_name == "" 
          last_name=medium_name
        end
        user.first_name = first_name
        user.last_name = last_name
        user.profile_name = first_name+"_"+last_name
        user.password = RandomWordGenerator.composed(2, 10, '_')
        user.remote_avatar_url = user.large_image 
      end
  end
  
  def large_image
    "https://graph.facebook.com/#{self.uid}/picture?type=large"
  end
  
  
  def full_name
    first_name.capitalize+" "+last_name.capitalize
  end
  
  def gravatar_url
    stripped_email = email.strip
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)
    "https://gravatar.com/avatar/#{hash}"
  end
  
  def to_param
    profile_name
  end

  def self.search(search)
    where("full_name LIKE ?", "%#{search}%") 
    where("profile_name LIKE ?", "%#{search}%")
  end
 
end
  