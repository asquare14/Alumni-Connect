class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy 
  has_many :user_groups
  has_many :groups, through: :user_groups
  mount_uploader :dp, ImageUploader
  has_many :expertise_users
  has_many :expertises, through: :expertise_users
  has_many :mentors, :class_name => 'MentorMentee', :foreign_key => 'mentor_id'
  has_many :mentees, :class_name => 'MentorMentee', :foreign_key => 'mentee_id'
end
