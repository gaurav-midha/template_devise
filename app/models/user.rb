class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :confirmable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  has_many :authentications
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  def apply_omniauth(auth)
    authentications.build(:provider => auth['provider'], :uid => auth['uid'])
  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
end
