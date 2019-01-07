class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy 
  has_many :user_groups
  has_many :groups, through: :user_groups
  mount_uploader :dp, ImageUploader
  
  has_many :private_messages, class_name: 'Private::Message'
  has_many  :private_conversations, 
             foreign_key: :sender_id, 
             class_name: 'Private::Conversation'
  
end
