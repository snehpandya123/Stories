class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_create :set_default_roles
 
   acts_as_voter
  has_reputation :votes, source: {reputation: :votes, of: :stories}, aggregated_by: :sum
  
  has_many :folders
  has_many :phases, through: :folders
  has_many :stories, through: :phases
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable ,:confirmable, :lockable, :timeoutable, :omniauthable  ,:omniauth_providers => [:facebook]

         attr_accessible :email, :password, :password_confirmation

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
user = User.where(:provider => auth.provider, :uid => auth.uid).first
if user
return user
else
registered_user = User.where(:email => auth.info.email).first
if registered_user
return registered_user
else
user = User.create(#name:auth.extra.raw_info.name,
provider:auth.provider,
uid:auth.uid,
email:auth.info.email,
password:Devise.friendly_token[0,20],
)
end end
end


def voted_for?(story)
  evaluations.where(target_type: story.class, target_id: story.id).present?
end


 private
    def set_default_roles
      self.roles = ['Default']
    end
end
