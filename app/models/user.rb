require 'random_word_generator'
class User < ActiveRecord::Base
  rolify
  
  acts_as_voter
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :database_authenticatable, :rememberable, :trackable, :validatable,
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
                            
  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  #(?=.*[[:^alnum:]]) # Must contain a symbol
  /x
  validates :password,:if => :password_required?, :format => { 
                                    :with =>  PASSWORD_FORMAT,#/(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/,
                                    :message => "Password should contain at least 8 characters, one upper case, one lower case and one numeric." 
  }
  
  has_many :statuses
  has_many :user_friendships
  has_many :friends, through: :user_friendships 
  has_many :comments, dependent: :destroy
  
  #has_many :friends, -> { where(user_friendships: {status: 'accepted'}).order('first_name DESC') }, :through => :user_friendships
  
  has_many :books
  has_many :swaps
  
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
        o = [('a'..'z'), ('A'..'Z'), (1..9)].map { |i| i.to_a }.flatten
        string = (0...14).map { o[rand(o.length)] }.join
        user.password = string
        user.remote_avatar_url = user.large_image 
      end
  end
  
  def large_image
    "https://graph.facebook.com/#{self.uid}/picture?type=large"
  end
  
  
  # Metodo che usiamo nelle view per mostrare o meno il tasto aggiungi amico, current_user.has_friend(friend_id) ritorna true in caso di amicizia.
  def has_friend(friend_id)
    @friendship1 = UserFriendship.where(user_id: friend_id, friend_id: self.id).first
    @friendship2 = UserFriendship.where(friend_id: friend_id, user_id: self.id).first
    return (!@friendship1.nil? or !@friendship2.nil?)
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
  