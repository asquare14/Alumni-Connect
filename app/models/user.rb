class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy 
  has_many :user_groups
  has_many :groups, through: :user_groups
  acts_as_messageable
  mount_uploader :dp, ImageUploader

  def mailboxer_email(object)
    email
  end

end
